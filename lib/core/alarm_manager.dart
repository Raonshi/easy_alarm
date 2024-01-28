import 'dart:convert';
import 'package:alarm/alarm.dart';
import 'package:easy_alarm/common/tools.dart';
import 'package:easy_alarm/core/route.dart';
import 'package:easy_alarm/modules/alarm/model/alarm_entity/alarm_entity.dart';
import 'package:easy_alarm/modules/alarm/model/alarm_group/alarm_group.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlarmManager {
  final String _tag = "[AlarmManager]";

  static final AlarmManager _instance = AlarmManager._internal();
  factory AlarmManager() => _instance;
  AlarmManager._internal();

  final List<AlarmGroup> _alarmGroups = [];
  List<AlarmGroup> get cachedAlarmGroups => _alarmGroups;

  final String _alarmKey = "ALARMS";

  get firstEmptyId {
    if (_alarmGroups.isEmpty) return 0;

    final List<int> ids = _alarmGroups.map((e) => e.id).toList();
    ids.sort();
    for (int i = 0; i < ids.length; i++) {
      if (ids[i] != i) return i;
    }

    return ids.length;
  }

  Future<void> init() async {
    await Future.wait([loadAlarms(), initAlarm()]);
  }

  Future<void> loadAlarms() async {
    await SharedPreferences.getInstance().then((prefs) {
      _alarmGroups.clear();
      final List<String> alarmStrings = prefs.getStringList(_alarmKey) ?? [];
      if (alarmStrings.isNotEmpty) {
        _alarmGroups.addAll(alarmStrings.map((e) => AlarmGroup.fromJson(jsonDecode(e))));
      }
    });
  }

  Future<void> initAlarm() async {
    await Alarm.init(showDebugLogs: true);
    await Alarm.setNotificationOnAppKillContent("이지 알람", "앱이 종료되면 알람이 울리지 않을 수 있습니다.");

    Alarm.ringStream.stream.listen(_handleAlarmRinging);
  }

  Future<void> _handleAlarmRinging(AlarmSettings settings) async {
    mainNavKey.currentContext!.replaceNamed(Path.alarm.path, extra: settings);
  }

  /// Remove every alarms from the system and the storage.
  Future<void> resetAlarms() async {
    await SharedPreferences.getInstance().then((prefs) async {
      _alarmGroups.clear();
      await Future.wait([
        prefs.remove(_alarmKey),
        Alarm.stopAll(),
      ]);
    });
  }

  /// Save an alarm to the storage and the system.
  Future<void> saveAlarm(AlarmGroup alarmGroup) async {
    await SharedPreferences.getInstance().then((prefs) async {
      _alarmGroups.add(alarmGroup);
      final List<String> alarmStrings = _alarmGroups.map((e) => jsonEncode(e.toJson())).toList();
      await Future.wait([
        prefs.setStringList(_alarmKey, alarmStrings),
        _addAlarmGroup(alarmGroup),
      ]);
    });
  }

  /// Replace an alarm to the storage and the system.
  Future<void> replaceAlarmGroup(AlarmGroup newAlarmGroup) async {
    await SharedPreferences.getInstance().then((prefs) async {
      final int idx = _alarmGroups.indexWhere((element) => element.id == newAlarmGroup.id);
      if (idx == -1) return;

      final AlarmGroup prevAlarmGroup = _alarmGroups[idx];
      final List<AlarmEntity> prevAlarms = prevAlarmGroup.alarms.toList();
      for (AlarmEntity alarm in prevAlarms) {
        await Alarm.stop(alarm.id);
      }

      _alarmGroups.replaceRange(idx, idx + 1, [newAlarmGroup]);
      final List<String> alarmStrings = _alarmGroups.map((e) => jsonEncode(e.toJson())).toList();
      await Future.wait([
        prefs.setStringList(_alarmKey, alarmStrings),
        _addAlarmGroup(newAlarmGroup),
      ]);
    });
  }

  /// Wait for the next alarm to ring.
  Future<void> waitForSnooze(AlarmEntity entity) async {
    await Alarm.stop(entity.id);

    final AlarmGroup? group = _getAlarmGroup(entity);

    if (group != null && entity.snoozeDuration != null && entity.nextDateTime != null) {
      await SharedPreferences.getInstance().then((prefs) async {
        final List<Future> futures = [];

        // Create next snooze settings
        final AlarmSettings setting = AlarmSettings(
          id: entity.id,
          dateTime: entity.nextDateTime!.add(Duration(minutes: entity.snoozeDuration!)),
          assetAudioPath: entity.sound.path,
          vibrate: entity.vibration,
          fadeDuration: 2.0,
          notificationTitle: "이지 알람",
          notificationBody: "알람이 울리고 있습니다. 앱을 실행해 알람을 종료해주세요.",
        );

        futures.add(Alarm.set(alarmSettings: setting));

        List<AlarmEntity> entities = group.alarms.toList();
        final int idx = entities.indexWhere((element) => element.id == entity.id);
        if (idx == -1) {
          lgr.e("$_tag waitForSnooze\n - AlarmEntity not found");
          return;
        }
        final AlarmEntity newEntity = entity.copyWith(
          snoozeDuration: entity.snoozeDuration,
          nextTimstamp: entity.nextDateTime!.millisecondsSinceEpoch + entity.snoozeDuration! * 1000 * 60,
        );

        lgr.d(newEntity.nextDateTime);

        entities.add(newEntity);
        entities.removeAt(idx);

        _alarmGroups.removeAt(_alarmGroups.indexOf(group));

        // Replace AlarmGroup
        _alarmGroups.add(group.copyWith(alarms: entities));

        final List<String> alarmStrings = _alarmGroups.map((e) => jsonEncode(e.toJson())).toList();
        futures.add(prefs.setStringList(_alarmKey, alarmStrings));

        await Future.wait(futures);
      });
    }
  }

  /// Add next routine alarm to the system if alarm has next routine.
  Future<void> prepareNextRoutine(AlarmEntity entity) async {
    await Alarm.stop(entity.id);
    await SharedPreferences.getInstance().then((prefs) async {
      final List<Future> futures = [];

      //Find AlarmGroup using AlarmEntity
      final AlarmGroup? group = _getAlarmGroup(entity);
      if (group != null) {
        final List<AlarmEntity> groupAlarms = group.alarms.toList();

        if (group.routine) {
          // Check if alarm has next routine
          groupAlarms.sort((a, b) => a.timestamp.compareTo(b.timestamp));
          final int timestamp = entity.timestamp;
          final int nextRoutineIdx = groupAlarms.indexWhere((element) => element.timestamp > timestamp);

          final DateTime nextWeekdayTime = entity.dateTime.add(const Duration(days: 7));
          // Create next current weekday entity
          final AlarmEntity nextWeekdayAlarmEntity = entity.copyWith(
            id: nextWeekdayTime.millisecondsSinceEpoch,
            timestamp: nextWeekdayTime.millisecondsSinceEpoch,
          );

          // If next routine exist
          late final AlarmEntity nextAlarmEntity;
          if (nextRoutineIdx != -1) {
            // Add next rountine entity to system
            nextAlarmEntity = groupAlarms[nextRoutineIdx];
            groupAlarms.add(nextAlarmEntity);
          } else {
            nextAlarmEntity = nextWeekdayAlarmEntity;
          }
          final AlarmSettings nextSettings = AlarmSettings(
            id: nextAlarmEntity.id,
            dateTime: nextAlarmEntity.dateTime,
            assetAudioPath: nextAlarmEntity.sound.path,
            vibrate: nextAlarmEntity.vibration,
            fadeDuration: 2.0,
            notificationTitle: "이지 알람",
            notificationBody: "알람이 울리고 있습니다. 앱을 실행해 알람을 종료해주세요.",
          );
          futures.add(Alarm.set(alarmSettings: nextSettings));
          groupAlarms.add(nextWeekdayAlarmEntity);
        }
        // Remove current routine AlarmEntity
        groupAlarms.removeWhere((e) => e.id == entity.id);
        _alarmGroups.removeAt(_alarmGroups.indexOf(group));

        // Replace AlarmGroup
        if (group.routine) _alarmGroups.add(group.copyWith(alarms: groupAlarms));

        final List<String> alarmStrings = _alarmGroups.map((e) => jsonEncode(e.toJson())).toList();
        futures.add(prefs.setStringList(_alarmKey, alarmStrings));
        await Future.wait(futures);
      }
    });
  }

  /// Delete an alarm group from the storage and the system.
  Future<void> deleteAlarmGroup(int id) async {
    await SharedPreferences.getInstance().then((prefs) async {
      final int idx = _alarmGroups.indexWhere((element) => element.id == id);
      if (idx == -1) {
        lgr.e("$_tag deleteAlarm\n - AlarmGroup not found");
        return;
      }

      final AlarmGroup targetAlarmGroup = _alarmGroups[idx];
      final List<Future> futures = [];

      for (AlarmEntity alarm in targetAlarmGroup.alarms) {
        futures.add(Alarm.stop(alarm.id));
      }

      _alarmGroups.removeAt(idx);
      final List<String> alarmStrings = _alarmGroups.map((e) => jsonEncode(e.toJson())).toList();

      futures.add(prefs.setStringList(_alarmKey, alarmStrings));
      await Future.wait(futures);
    });
  }

  /// Delete alarm entity from the storage and the system.
  Future<void> deleteAlarmEntity(int id) async {
    await SharedPreferences.getInstance().then((prefs) async {
      final List<Future> futures = [];

      // Find Alrm Group
      final int groupIdx = _alarmGroups.indexWhere((element) => element.id == id);
      if (groupIdx == -1) {
        lgr.e("$_tag deleteAlarm\n - AlarmGroup not found");
        return;
      }
      final AlarmGroup targetAlarmGroup = _alarmGroups[groupIdx];
      final List<AlarmEntity> targetAlarms = targetAlarmGroup.alarms.toList();

      // Find Alarm Entity
      final int entityIdx = targetAlarms.indexWhere((element) => element.id == id);
      if (entityIdx == -1) {
        lgr.e("$_tag deleteAlarm\n - AlarmEntity not found");
        return;
      }
      final AlarmEntity targetAlarm = targetAlarms[entityIdx];

      // Stop Alarm and Delete Alarm Entity
      futures.add(Alarm.stop(targetAlarm.id));
      targetAlarms.removeAt(entityIdx);
      _alarmGroups.replaceRange(groupIdx, groupIdx + 1, [targetAlarmGroup.copyWith(alarms: targetAlarms)]);

      // Save Alarm Group
      final List<String> alarmStrings = _alarmGroups.map((e) => jsonEncode(e.toJson())).toList();
      futures.add(prefs.setStringList(_alarmKey, alarmStrings));
      await Future.wait(futures);
    });
  }

  /// Add an alarm to the system.
  Future<void> _addAlarmGroup(AlarmGroup alarmGroup) async {
    final List<AlarmEntity> alarms = alarmGroup.alarms.toList();
    alarms.sort((a, b) => a.timestamp.compareTo(b.timestamp));

    final AlarmEntity firstAlarm = alarms.first;
    final AlarmSettings setting = AlarmSettings(
      id: firstAlarm.id,
      dateTime: firstAlarm.dateTime,
      assetAudioPath: firstAlarm.sound.path,
      vibrate: firstAlarm.vibration,
      fadeDuration: 2.0,
      notificationTitle: "이지 알람",
      notificationBody: "알람이 울리고 있습니다. 앱을 실행해 알람을 종료해주세요.",
    );

    await Alarm.set(alarmSettings: setting);
  }

  AlarmGroup? _getAlarmGroup(AlarmEntity entity) {
    final int groupIdx = _alarmGroups.indexWhere((group) => group.alarms.map((e) => e.id).contains(entity.id));
    if (groupIdx == -1) {
      lgr.d("$_tag addNextRoutine : AlarmGroup not found");
      return null;
    }
    return _alarmGroups[groupIdx];
  }
}
