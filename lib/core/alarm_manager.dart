import 'dart:convert';
import 'package:alarm/alarm.dart';
import 'package:easy_alarm/common/tools.dart';
import 'package:easy_alarm/core/route.dart';
import 'package:easy_alarm/modules/alarm/model/alarm_entity/alarm_entity.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlarmManager {
  final String _tag = "[AlarmManager]";

  static final AlarmManager _instance = AlarmManager._internal();
  factory AlarmManager() => _instance;
  AlarmManager._internal();

  final List<AlarmEntity> _alarms = [];
  List<AlarmEntity> get cachedAlarms => _alarms;

  final String alarms = "ALARMS";

  get firstEmptyId {
    if (_alarms.isEmpty) return 0;

    final List<int> ids = _alarms.map((e) => e.id).toList();
    ids.sort();
    for (int i = 0; i < ids.length; i++) {
      if (ids[i] != i) return i;
    }

    return ids.length;
  }

  Future<void> init() async {
    await Future.wait([loadAlarms(), initAlarm()]);
    lgr.d("$_tag initialized\n - Stored Alarm List : $_alarms\n - System Alarm List : ${Alarm.getAlarms()}");
  }

  Future<void> loadAlarms() async {
    await SharedPreferences.getInstance().then((prefs) {
      _alarms.clear();
      final List<String> alarmStrings = prefs.getStringList(alarms) ?? [];
      if (alarmStrings.isNotEmpty) {
        _alarms.addAll(alarmStrings.map((e) => AlarmEntity.fromJson(jsonDecode(e))));
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
      _alarms.clear();
      await Future.wait([
        prefs.remove(alarms),
        Alarm.stopAll(),
      ]);
    });
    lgr.d("$_tag resetAlarms\n - Stored Alarm List : $_alarms\n - System Alarm List : ${Alarm.getAlarms()}");
  }

  /// Save an alarm to the storage and the system.
  Future<void> saveAlarm(AlarmEntity alarm) async {
    await SharedPreferences.getInstance().then((prefs) async {
      _alarms.add(alarm);
      final List<String> alarmStrings = _alarms.map((e) => jsonEncode(e.toJson())).toList();
      await Future.wait([
        prefs.setStringList(alarms, alarmStrings),
        _addAlarm(alarm),
      ]);
    });
    lgr.d("$_tag saveAlarm\n - Stored Alarm List : $_alarms\n - System Alarm List : ${Alarm.getAlarms()}");
  }

  /// Replace an alarm to the storage and the system.
  Future<void> replaceAlarm(AlarmEntity alarm) async {
    await SharedPreferences.getInstance().then((prefs) async {
      final int idx = _alarms.indexWhere((element) => element.id == alarm.id);
      if (idx == -1) return;

      await Alarm.stop(alarm.id);
      _alarms.replaceRange(idx, idx + 1, [alarm]);
      final List<String> alarmStrings = _alarms.map((e) => jsonEncode(e.toJson())).toList();
      await Future.wait([
        prefs.setStringList(alarms, alarmStrings),
        _addAlarm(alarm),
      ]);
    });
    lgr.d("$_tag replaceAlarm\n - Stored Alarm List : $_alarms\n - System Alarm List : ${Alarm.getAlarms()}");
  }

  /// Delete an alarm from the storage and the system.
  Future<void> deleteAlarm(int id) async {
    await SharedPreferences.getInstance().then((prefs) async {
      _alarms.removeWhere((element) => element.id == id);
      final List<String> alarmStrings = _alarms.map((e) => jsonEncode(e.toJson())).toList();
      await Future.wait([prefs.setStringList(alarms, alarmStrings), Alarm.stop(id)]);
    });
    lgr.d("$_tag deleteAlarm\n - Stored Alarm List : $_alarms\n - System Alarm List : ${Alarm.getAlarms()}");
  }

  /// Add an alarm to the system.
  Future<void> _addAlarm(AlarmEntity alarm) async {
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(alarm.timestamp);

    final AlarmSettings setting = AlarmSettings(
      id: alarm.id,
      dateTime: dateTime,
      assetAudioPath: "assets/sound/0.mp3",
      notificationTitle: alarm.title,
      notificationBody: alarm.content,
    );
    await Alarm.set(alarmSettings: setting);
    lgr.d("$_tag _addAlarm\n - Stored Alarm List : $_alarms\n - System Alarm List : ${Alarm.getAlarms()}");
  }
}
