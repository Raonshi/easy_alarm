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
    return {
      DateTime.now().subtract(const Duration(days: 30)): [
        EzCalendarEvent(
          id: 1,
          title: 'Event 1',
          subtitle: 'Subtitle 1',
          dateTime: DateTime.now().subtract(const Duration(days: 30)),
        ),
      ],
      DateTime.now().subtract(const Duration(days: 27)): [
        EzCalendarEvent(
          id: 2,
          title: 'Event 2',
          subtitle: 'Subtitle 2',
          dateTime: DateTime.now().subtract(const Duration(days: 27)),
        )
      ],
      DateTime.now().subtract(const Duration(days: 20)): [
        EzCalendarEvent(
          id: 3,
          title: 'Event 3',
          subtitle: 'Subtitle 3',
          dateTime: DateTime.now().subtract(const Duration(days: 20)),
        )
      ],
      DateTime.now().subtract(const Duration(days: 16)): [
        EzCalendarEvent(
          id: 4,
          title: 'Event 4',
          subtitle: 'Subtitle 4',
          dateTime: DateTime.now().subtract(const Duration(days: 16)),
        )
      ],
      DateTime.now().subtract(const Duration(days: 10)): [
        EzCalendarEvent(
          id: 5,
          title: 'Event 5',
          subtitle: 'Subtitle 5',
          dateTime: DateTime.now().subtract(const Duration(days: 10)),
        )
      ],
      DateTime.now().subtract(const Duration(days: 5)): [
        EzCalendarEvent(
          id: 6,
          title: 'Event 6',
          subtitle: 'Subtitle 6',
          dateTime: DateTime.now().subtract(const Duration(days: 5)),
        )
      ],
      DateTime.now().subtract(const Duration(days: 2)): [
        EzCalendarEvent(
          id: 7,
          title: 'Event 7',
          subtitle: 'Subtitle 7',
          dateTime: DateTime.now().subtract(const Duration(days: 2)),
        )
      ],
      DateTime.now().subtract(const Duration(days: 1)): [
        EzCalendarEvent(
          id: 8,
          title: 'Event 8',
          subtitle: 'Subtitle 8',
          dateTime: DateTime.now().subtract(const Duration(days: 1)),
        )
      ],
      DateTime.now(): [
        EzCalendarEvent(
          id: 9,
          title: 'Event 9',
          subtitle: 'Subtitle 9',
          dateTime: DateTime.now(),
        )
      ],
    };
  }
}
