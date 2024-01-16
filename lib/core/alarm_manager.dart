import 'dart:convert';

import 'package:easy_alarm/model/alarm_model/alarm_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlarmManager {
  static final AlarmManager _instance = AlarmManager._internal();
  factory AlarmManager() => _instance;
  AlarmManager._internal();

  final List<AlarmModel> _alarms = [];
  List<AlarmModel> get cachedAlarms => _alarms;

  final String alarms = "ALARMS";

  Future<void> loadAlarms() async {
    await SharedPreferences.getInstance().then((prefs) {
      _alarms.clear();
      final List<String> alarmStrings = prefs.getStringList(alarms) ?? [];
      if (alarmStrings.isNotEmpty) {
        _alarms.addAll(alarmStrings.map((e) => AlarmModel.fromJson(jsonDecode(e))));
      }
    });
  }

  Future<void> saveAlarm(AlarmModel alarm) async {
    await SharedPreferences.getInstance().then((prefs) async {
      _alarms.add(alarm);
      final List<String> alarmStrings = _alarms.map((e) => jsonEncode(e.toJson())).toList();
      await prefs.setStringList(alarms, alarmStrings);
    });
  }

  Future<void> replaceAlarm(AlarmModel alarm) async {
    await SharedPreferences.getInstance().then((prefs) async {
      final int idx = _alarms.indexWhere((element) => element.id == alarm.id);
      if (idx == -1) return;

      _alarms.replaceRange(idx, idx + 1, [alarm]);
      final List<String> alarmStrings = _alarms.map((e) => jsonEncode(e.toJson())).toList();
      await prefs.setStringList(alarms, alarmStrings);
    });
  }

  Future<void> deleteAlarm(String id) async {
    await SharedPreferences.getInstance().then((prefs) async {
      _alarms.removeWhere((element) => element.id == id);
      final List<String> alarmStrings = _alarms.map((e) => jsonEncode(e.toJson())).toList();
      await prefs.setStringList(alarms, alarmStrings);
    });
  }
}
