import 'dart:math';

import 'package:easy_alarm/modules/calendar/model/ez_calendar_model.dart';

class EzCalendarManager {
  static final EzCalendarManager _instance = EzCalendarManager._internal();
  factory EzCalendarManager() => _instance;
  EzCalendarManager._internal();

  final Map<DateTime, List<EzCalendarEvent>> events = {};

  Future<void> init() async {
    events.addAll(await _generateTestEvents());
  }

  Future<Map<DateTime, List<EzCalendarEvent>>> _generateTestEvents() async {
    final testEvents = Map<DateTime, List<EzCalendarEvent>>.fromEntries(List.generate(20, (index) {
      final DateTime date = DateTime.now().subtract(Duration(days: index));
      return MapEntry(
          date,
          List.generate(Random().nextInt(10), (index) {
            final int id = DateTime.now().subtract(const Duration(days: 30)).millisecondsSinceEpoch + index;
            return EzCalendarEvent(
              id: id,
              title: 'Event ${DateTime.now().subtract(const Duration(days: 30)).toString()}',
              subtitle: 'Subtitle ${DateTime.now().subtract(const Duration(days: 30)).toString()}',
              dateTime: DateTime.now().subtract(const Duration(days: 30)),
            );
          }));
    }));
    return testEvents;
  }
}
