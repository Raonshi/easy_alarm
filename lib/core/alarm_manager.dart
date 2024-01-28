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

  // get firstEmptyId {
  //   if (_alarms.isEmpty) return 0;

  //   final List<int> ids = _alarms.map((e) => e.id).toList();
  //   ids.sort();
  //   for (int i = 0; i < ids.length; i++) {
  //     if (ids[i] != i) return i;
  //   }

  //   return ids.length;
  // }

  // Future<void> init() async {
  //   await Future.wait([loadAlarms(), initAlarm()]);
  //   lgr.d("$_tag initialized\n - Stored Alarm List : $_alarms\n - System Alarm List : ${Alarm.getAlarms()}");
  // }

  // Future<void> loadAlarms() async {
  //   await SharedPreferences.getInstance().then((prefs) {
  //     _alarms.clear();
  //     final List<String> alarmStrings = prefs.getStringList(_alarmKey) ?? [];
  //     if (alarmStrings.isNotEmpty) {
  //       _alarms.addAll(alarmStrings.map((e) => AlarmEntity.fromJson(jsonDecode(e))));
  //     }
  //   });
  // }

  // Future<void> initAlarm() async {
  //   await Alarm.init(showDebugLogs: true);
  //   await Alarm.setNotificationOnAppKillContent("이지 알람", "앱이 종료되면 알람이 울리지 않을 수 있습니다.");

  //   Alarm.ringStream.stream.listen(_handleAlarmRinging);
  // }

  // Future<void> _handleAlarmRinging(AlarmSettings settings) async {
  //   mainNavKey.currentContext!.replaceNamed(Path.alarm.path, extra: settings);
  // }

  // /// Remove every alarms from the system and the storage.
  // Future<void> resetAlarms() async {
  //   await SharedPreferences.getInstance().then((prefs) async {
  //     _alarms.clear();
  //     await Future.wait([
  //       prefs.remove(_alarmKey),
  //       Alarm.stopAll(),
  //     ]);
  //   });
  //   lgr.d("$_tag resetAlarms\n - Stored Alarm List : $_alarms\n - System Alarm List : ${Alarm.getAlarms()}");
  // }

  // /// Save an alarm to the storage and the system.
  // Future<void> saveAlarm(AlarmEntity alarm) async {
  //   await SharedPreferences.getInstance().then((prefs) async {
  //     _alarms.add(alarm);
  //     final List<String> alarmStrings = _alarms.map((e) => jsonEncode(e.toJson())).toList();
  //     await Future.wait([
  //       prefs.setStringList(alarms, alarmStrings),
  //       _addAlarm(alarm),
  //     ]);
  //   });
  //   lgr.d("$_tag saveAlarm\n - Stored Alarm List : $_alarms\n - System Alarm List : ${Alarm.getAlarms()}");
  // }

  // /// Replace an alarm to the storage and the system.
  // Future<void> replaceAlarm(AlarmEntity alarm) async {
  //   await SharedPreferences.getInstance().then((prefs) async {
  //     final int idx = _alarms.indexWhere((element) => element.id == alarm.id);
  //     if (idx == -1) return;

  //     await Alarm.stop(alarm.id);
  //     _alarms.replaceRange(idx, idx + 1, [alarm]);
  //     final List<String> alarmStrings = _alarms.map((e) => jsonEncode(e.toJson())).toList();
  //     await Future.wait([
  //       prefs.setStringList(alarms, alarmStrings),
  //       _addAlarm(alarm),
  //     ]);
  //   });
  //   lgr.d("$_tag replaceAlarm\n - Stored Alarm List : $_alarms\n - System Alarm List : ${Alarm.getAlarms()}");
  // }

  //   /// Delete an alarm from the storage and the system.
  // Future<void> deleteAlarm(int id) async {
  //   await SharedPreferences.getInstance().then((prefs) async {
  //     _alarms.removeWhere((element) => element.id == id);
  //     final List<String> alarmStrings = _alarms.map((e) => jsonEncode(e.toJson())).toList();
  //     await Future.wait([prefs.setStringList(_alarmKey, alarmStrings), Alarm.stop(id)]);
  //   });
  //   lgr.d("$_tag deleteAlarm\n - Stored Alarm List : $_alarms\n - System Alarm List : ${Alarm.getAlarms()}");
  // }

  // /// Add an alarm to the system.
  // Future<void> _addAlarm(AlarmEntity alarm) async {
  //   final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(alarm.timestamp);

  //   final AlarmSettings setting = AlarmSettings(
  //     id: alarm.id,
  //     dateTime: dateTime,
  //     assetAudioPath: alarm.sound.path,
  //     vibrate: alarm.vibration,
  //     fadeDuration: 2.0,
  //     notificationTitle: "이지 알람",
  //     notificationBody: "알람이 울리고 있습니다. 앱을 실행해 알람을 종료해주세요.",
  //   );
  //   await Alarm.set(alarmSettings: setting);
  //   lgr.d("$_tag _addAlarm\n - Stored Alarm List : $_alarms\n - System Alarm List : ${Alarm.getAlarms()}");
  // }

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
    lgr.d("$_tag initialized\n - Stored Alarm List : $_alarmGroups\n - System Alarm List : ${Alarm.getAlarms()}");
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
    lgr.d("$_tag resetAlarms\n - Stored Alarm List : $_alarmGroups\n - System Alarm List : ${Alarm.getAlarms()}");
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
    lgr.d("$_tag saveAlarm\n - Stored Alarm List : $_alarmGroups\n - System Alarm List : ${Alarm.getAlarms()}");
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
    lgr.d("$_tag replaceAlarm\n - Stored Alarm List : $_alarmGroups\n - System Alarm List : ${Alarm.getAlarms()}");
  }

  /// Wait for the next alarm to ring.
  Future<void> waitForNextAlarm(AlarmEntity alarmEntity) async {
    await Alarm.stop(alarmEntity.id);
    final AlarmSettings setting = AlarmSettings(
      id: alarmEntity.id,
      dateTime: alarmEntity.dateTime,
      assetAudioPath: alarmEntity.sound.path,
      vibrate: alarmEntity.vibration,
      fadeDuration: 2.0,
      notificationTitle: "이지 알람",
      notificationBody: "알람이 울리고 있습니다. 앱을 실행해 알람을 종료해주세요.",
    );

    await Alarm.set(alarmSettings: setting);
    lgr.d("$_tag _addAlarm\n - Stored Alarm List : $_alarmGroups\n - System Alarm List : ${Alarm.getAlarms()}");
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

    lgr.d("$_tag deleteAlarm\n - Stored Alarm List : $_alarmGroups\n - System Alarm List : ${Alarm.getAlarms()}");
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

    lgr.d("$_tag deleteAlarm\n - Stored Alarm List : $_alarmGroups\n - System Alarm List : ${Alarm.getAlarms()}");
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
    lgr.d("$_tag _addAlarm\n - Stored Alarm List : $_alarmGroups\n - System Alarm List : ${Alarm.getAlarms()}");
  }
}
