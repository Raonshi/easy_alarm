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

  get firstEmptyId {
    if (_alarms.isEmpty) return 0;

    final List<int> ids = _alarms.map((e) => e.id).toList();
    ids.sort();
    for (int i = 0; i < ids.length; i++) {
      if (ids[i] != i) return i;
    }

    return ids.length;
  }

  Future<void> loadAlarms() async {
    await SharedPreferences.getInstance().then((prefs) {
      _alarms.clear();
      final List<String> alarmStrings = prefs.getStringList(alarms) ?? [];
      if (alarmStrings.isNotEmpty) {
        _alarms.addAll(alarmStrings.map((e) => AlarmModel.fromJson(jsonDecode(e))));
      }
    });
  }

  Future<void> resetAlarms() async {
    await SharedPreferences.getInstance().then((prefs) async {
      _alarms.clear();
      await prefs.remove(alarms);
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

  Future<void> deleteAlarm(int id) async {
    await SharedPreferences.getInstance().then((prefs) async {
      _alarms.removeWhere((element) => element.id == id);
      final List<String> alarmStrings = _alarms.map((e) => jsonEncode(e.toJson())).toList();
      await prefs.setStringList(alarms, alarmStrings);
    });
  }
}
