import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class EzCalendar extends StatefulWidget {
  const EzCalendar({super.key});

  @override
  State<EzCalendar> createState() => _EzCalendarState();
}

class _EzCalendarState extends State<EzCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime? _selectedDay;

  @override
  void initState() {
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
        titleTextStyle: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w700,
          height: 1.0,
          letterSpacing: -0.5,
          color: colors.onBackground,
        ),
        leftChevronVisible: false,
        rightChevronVisible: false,
        headerPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        formatButtonTextStyle: TextStyle(
          fontSize: 14.0,
          height: 1.0,
          letterSpacing: -0.5,
          fontWeight: FontWeight.w500,
          color: colors.onBackground,
        ),
      ),
      calendarStyle: CalendarStyle(
        markerSize: 12.0,
        todayDecoration: BoxDecoration(
          color: colors.secondary,
          shape: BoxShape.circle,
        ),
        todayTextStyle: TextStyle(
          fontSize: 14.0,
          height: 1.0,
          letterSpacing: -0.5,
          fontWeight: FontWeight.w500,
          color: colors.onSecondary,
        ),
        weekendTextStyle: TextStyle(
          fontSize: 14.0,
          height: 1.0,
          letterSpacing: -0.5,
          fontWeight: FontWeight.w700,
          color: colors.secondary,
        ),
        defaultTextStyle: TextStyle(
          fontSize: 14.0,
          height: 1.0,
          letterSpacing: -0.5,
          fontWeight: FontWeight.w700,
          color: colors.onBackground,
        ),
        selectedDecoration: const BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
        markerSizeScale: 8.0,
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          fontSize: 14.0,
          height: 1.0,
          letterSpacing: -0.5,
          fontWeight: FontWeight.w700,
          color: colors.onBackground,
        ),
        weekendStyle: TextStyle(
          fontSize: 14.0,
          height: 1.0,
          letterSpacing: -0.5,
          fontWeight: FontWeight.w700,
          color: colors.secondary,
        ),
      ),
      focusedDay: _selectedDay ?? DateTime.now(),
      firstDay: DateTime(1900),
      lastDay: DateTime(2099),
      onFormatChanged: (format) => setState(() {
        _calendarFormat = format;
      }),
      onDaySelected: (selectedDay, focusedDay) => setState(() {
        _selectedDay = selectedDay;
      }),
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDayLongPressed: (selectedDay, focusedDay) => {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: colors.background,
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Event add widget"),
                  Text("Event add widget"),
                  Text("Event add widget"),
                  Text("Event add widget"),
                  Text("Event add widget"),
                  Text("Event add widget"),
                ],
              ),
            ),
          ),
        ),
        setState(() => _selectedDay = selectedDay),
      },
    );
  }
}
