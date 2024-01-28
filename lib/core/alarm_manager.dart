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

  @Deprecated("This value will be removed next time")
  final List<AlarmEntity> _alarms = [];
  @Deprecated("This value will be removed next time")
  List<AlarmEntity> get cachedAlarms => _alarms;

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
  Future<void> waitForSnooze(AlarmEntity alarmEntity) async {
    await Alarm.stop(alarmEntity.id);
    if (alarmEntity.snoozeDuration != null) {
      //Find AlarmGroup using AlarmEntity
      final int groupIdx = _alarmGroups.indexWhere((group) => group.alarms.map((e) => e.id).contains(alarmEntity.id));
      if (groupIdx == -1) {
        lgr.d("$_tag addNextRoutine : AlarmGroup not found");
        return;
      }
      final AlarmGroup group = _alarmGroups[groupIdx];

      // Find AlarmEntity from AlarmGroup
      final List<AlarmEntity> groupAlarms = group.alarms.toList();
      final int entityIdx = groupAlarms.indexWhere((element) => element.id == alarmEntity.id);
      if (entityIdx == -1) {
        lgr.d("$_tag addNextRoutine : AlarmEntity not found");
        return;
      }

      // Create next snooze AlarmEntity
      final DateTime nexRoutineTime = alarmEntity.dateTime.add( Duration(minutes: alarmEntity.snoozeDuration!));
      final AlarmEntity nextRoutineEntity = alarmEntity.copyWith(
        id: nexRoutineTime.millisecondsSinceEpoch,
        timestamp: nexRoutineTime.millisecondsSinceEpoch,
      );

      final AlarmSettings setting = AlarmSettings(
        id: nextRoutineEntity.id,
        dateTime: nextRoutineEntity.dateTime,
        assetAudioPath: nextRoutineEntity.sound.path,
        vibrate: nextRoutineEntity.vibration,
        fadeDuration: 2.0,
        notificationTitle: "이지 알람",
        notificationBody: "알람이 울리고 있습니다. 앱을 실행해 알람을 종료해주세요.",
      );

      // Prepare next routine AlarmEntity
      groupAlarms.removeAt(entityIdx);
      groupAlarms.add(nextRoutineEntity);

      // Replace AlarmGroup
      _alarmGroups.removeAt(groupIdx);
      _alarmGroups.add(group.copyWith(alarms: groupAlarms));

      await Alarm.set(alarmSettings: setting);
    }
  }

  void addNextRoutine(AlarmEntity entity) {
    //Find AlarmGroup using AlarmEntity
    final int groupIdx = _alarmGroups.indexWhere((group) => group.alarms.map((e) => e.id).contains(entity.id));
    if (groupIdx == -1) {
      lgr.d("$_tag addNextRoutine : AlarmGroup not found");
      return;
    }
    final AlarmGroup group = _alarmGroups[groupIdx];

    // Find AlarmEntity from AlarmGroup
    final List<AlarmEntity> groupAlarms = group.alarms.toList();
    final int entityIdx = groupAlarms.indexWhere((element) => element.id == entity.id);
    if (entityIdx == -1) {
      lgr.d("$_tag addNextRoutine : AlarmEntity not found");
      return;
    }

    // Create next routine AlarmEntity
    final DateTime nexRoutineTime = entity.dateTime.add(const Duration(days: 7));
    final AlarmEntity nextRoutineEntity = entity.copyWith(
      id: nexRoutineTime.millisecondsSinceEpoch,
      timestamp: nexRoutineTime.millisecondsSinceEpoch,
    );
    final AlarmSettings newSettings = AlarmSettings(
      id: nextRoutineEntity.id,
      dateTime: nextRoutineEntity.dateTime,
      assetAudioPath: nextRoutineEntity.sound.path,
      vibrate: nextRoutineEntity.vibration,
      fadeDuration: 2.0,
      notificationTitle: "이지 알람",
      notificationBody: "알람이 울리고 있습니다. 앱을 실행해 알람을 종료해주세요.",
    );

    // Prepare next routine AlarmEntity
    groupAlarms.removeAt(entityIdx);
    groupAlarms.add(nextRoutineEntity);

    // Replace AlarmGroup
    _alarmGroups.removeAt(groupIdx);
    _alarmGroups.add(group.copyWith(alarms: groupAlarms));

    // Save Alarm Group
    SharedPreferences.getInstance().then((prefs) async {
      final List<String> alarmStrings = _alarmGroups.map((e) => jsonEncode(e.toJson())).toList();
      final List<Future> futures = [];

      futures.add(Alarm.set(alarmSettings: newSettings));
      futures.add(prefs.setStringList(_alarmKey, alarmStrings));
      await Future.wait(futures);
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
    final List<Future<bool>> futures = [];
    for (AlarmEntity alarm in alarmGroup.alarms) {
      final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(alarm.timestamp);
      final AlarmSettings setting = AlarmSettings(
        id: alarm.id,
        dateTime: dateTime,
        assetAudioPath: alarm.sound.path,
        vibrate: alarm.vibration,
        fadeDuration: 2.0,
        notificationTitle: "이지 알람",
        notificationBody: "알람이 울리고 있습니다. 앱을 실행해 알람을 종료해주세요.",
      );

      futures.add(Alarm.set(alarmSettings: setting));
    }

    await Future.wait(futures);
  }
}
