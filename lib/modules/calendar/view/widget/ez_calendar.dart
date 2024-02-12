import 'package:easy_alarm/modules/calendar/model/ez_calendar_model.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class EzCalendar extends StatefulWidget {
  const EzCalendar({
    super.key,
    this.events = const {},
    required this.onAddEvent,
    required this.onDaySelected,
  });

  final Map<DateTime, List<EzCalendarEvent>> events;
  final ValueChanged<DateTime> onAddEvent;
  final ValueChanged<List<EzCalendarEvent>> onDaySelected;

  @override
  State<EzCalendar> createState() => _EzCalendarState();
}

class _EzCalendarState extends State<EzCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime? _selectedDay;

  final TextStyle _titleTextStyle =
      const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, height: 1.0, letterSpacing: -0.5);

  final TextStyle _formatButtonTextStyle =
      const TextStyle(fontSize: 14.0, height: 1.0, letterSpacing: -0.5, fontWeight: FontWeight.w500);

  final TextStyle _todayTextStyle =
      const TextStyle(fontSize: 14.0, height: 1.0, letterSpacing: -0.5, fontWeight: FontWeight.w500);

  final TextStyle _weekendTextStyle =
      const TextStyle(fontSize: 14.0, height: 1.0, letterSpacing: -0.5, fontWeight: FontWeight.w700);

  final TextStyle _defaultTextStyle =
      const TextStyle(fontSize: 14.0, height: 1.0, letterSpacing: -0.5, fontWeight: FontWeight.w700);

  final TextStyle _weekdayStyle =
      const TextStyle(fontSize: 14.0, height: 1.0, letterSpacing: -0.5, fontWeight: FontWeight.w700);

  final TextStyle _weekendStyle =
      const TextStyle(fontSize: 14.0, height: 1.0, letterSpacing: -0.5, fontWeight: FontWeight.w700);

  @override
  void initState() {
    final DateTime today = DateTime.now();
    final List<MapEntry<DateTime, List<EzCalendarEvent>>> events = widget.events.entries.toList();
    final int idx = events.indexWhere((element) => isSameDay(element.key, today));
    widget.onDaySelected(idx == -1 ? [] : events[idx].value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    // final ThemeBloc themeBloc = context.read<ThemeBloc>();

    return TableCalendar(
      calendarFormat: _calendarFormat,
      headerStyle: HeaderStyle(
        titleCentered: false,
        titleTextStyle: _titleTextStyle.copyWith(color: colors.onBackground),
        leftChevronVisible: false,
        rightChevronVisible: false,
        headerPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        formatButtonTextStyle: _formatButtonTextStyle.copyWith(color: colors.onBackground),
      ),
      calendarStyle: CalendarStyle(
        markerSize: 8.0,
        todayDecoration: BoxDecoration(color: colors.secondary, shape: BoxShape.circle),
        todayTextStyle: _todayTextStyle.copyWith(color: colors.onSecondary),
        weekendTextStyle: _weekendTextStyle.copyWith(color: colors.secondary),
        defaultTextStyle: _defaultTextStyle.copyWith(color: colors.onBackground),
        selectedDecoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
        markerSizeScale: 8.0,
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: _weekdayStyle.copyWith(color: colors.onBackground),
        weekendStyle: _weekendStyle.copyWith(color: colors.secondary),
      ),
      focusedDay: _selectedDay ?? DateTime.now(),
      firstDay: DateTime(1900),
      lastDay: DateTime(2099),
      onFormatChanged: (format) => setState(() {
        _calendarFormat = format;
      }),
      eventLoader: _getEventsByDay,
      onDaySelected: (selectedDay, focusedDay) {
        widget.onDaySelected(_getEventsByDay(selectedDay));
        setState(() => _selectedDay = selectedDay);
      },
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDayLongPressed: (selectedDay, focusedDay) => {
        widget.onAddEvent(selectedDay),
        widget.onDaySelected(_getEventsByDay(selectedDay)),
        setState(() => _selectedDay = selectedDay),
      },
    );
  }

  List<EzCalendarEvent> _getEventsByDay(DateTime day) {
    final List<MapEntry<DateTime, List<EzCalendarEvent>>> events = widget.events.entries.toList();
    final int idx = events.indexWhere((element) => isSameDay(element.key, day));

    return idx == -1 ? [] : events[idx].value;
  }
}
