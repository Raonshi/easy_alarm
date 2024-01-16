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
  late final SharedPreferences _localStorage;

  bool _isInitialized = false;

  void init() async {
    _localStorage = await SharedPreferences.getInstance();
    _isInitialized = true;
  }

  void loadAlarms() {
    if (!_isInitialized) throw Exception("AlarmManager is not initialized");

    _alarms.clear();
    final List<String> alarmStrings = _localStorage.getStringList(alarms) ?? [];
    if (alarmStrings.isNotEmpty) {
      _alarms.addAll(alarmStrings.map((e) => AlarmModel.fromJson(jsonDecode(e))));
    }
  }

  void saveAlarm(AlarmModel alarm) {
    if (!_isInitialized) throw Exception("AlarmManager is not initialized");

    _alarms.add(alarm);
    final List<String> alarmStrings = _alarms.map((e) => jsonEncode(e.toJson())).toList();
    _localStorage.setStringList(alarms, alarmStrings);
  }

  void deleteAlarm(String id) {
    if (!_isInitialized) throw Exception("AlarmManager is not initialized");

    _alarms.removeWhere((element) => element.id == id);
    final List<String> alarmStrings = _alarms.map((e) => jsonEncode(e.toJson())).toList();
    _localStorage.setStringList(alarms, alarmStrings);
  }
}
