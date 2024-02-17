import 'package:easy_alarm/modules/calendar/model/ez_calendar_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final ThemeData theme = Theme.of(context);

    return TableCalendar(
      calendarFormat: _calendarFormat,
      // Header Style
      headerStyle: HeaderStyle(
        titleCentered: false,
        titleTextStyle:
            theme.textTheme.titleSmall?.copyWith(color: theme.colorScheme.onBackground) ?? TextStyle(fontSize: 14.0.sp),
        leftChevronVisible: false,
        rightChevronVisible: false,
        headerPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        formatButtonTextStyle: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onBackground) ??
            TextStyle(fontSize: 14.0.sp),
      ),
      // Calendar Style
      calendarStyle: CalendarStyle(
        markerSize: 6.0.w,
        markerSizeScale: 6.0.w,
        markersAnchor: 0.1,
        markersMaxCount: 4,
        markerMargin: EdgeInsets.all(2.0.w),
        markerDecoration: BoxDecoration(
          color: theme.colorScheme.error,
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: theme.colorScheme.primary,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(12.0.r),
        ),
        todayTextStyle:
            theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onPrimary) ?? TextStyle(fontSize: 14.0.sp),
        selectedDecoration: BoxDecoration(
          color: theme.colorScheme.tertiary,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(12.0.r),
        ),
        defaultDecoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(12.0.r)),
        rowDecoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(12.0.r)),
        weekendDecoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(12.0.r)),
        outsideDecoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(12.0.r)),
        disabledDecoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(12.0.r)),
        selectedTextStyle:
            theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onTertiary) ?? TextStyle(fontSize: 14.0.sp),
        weekendTextStyle:
            theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.primary) ?? TextStyle(fontSize: 14.0.sp),
        defaultTextStyle:
            theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onBackground) ?? TextStyle(fontSize: 14.0.sp),
      ),
      // DayOfWeek Style
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onBackground) ??
            TextStyle(fontSize: 14.0.sp),
        weekendStyle:
            theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.primary) ?? TextStyle(fontSize: 14.0.sp),
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
