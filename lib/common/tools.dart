import 'package:easy_alarm/common/enums.dart';

List<DateTime> getThisWeekDateTime(List<Weekday> weekdays) {
  final DateTime now = DateTime.now();
  final List<DateTime> result = [];

  for (final weekday in weekdays) {
    switch (weekday) {
      case Weekday.monday:
        result.add(now.subtract(Duration(days: now.weekday - DateTime.monday)));
        break;
      case Weekday.tuesday:
        result.add(now.subtract(Duration(days: now.weekday - DateTime.tuesday)));
        break;
      case Weekday.wednesday:
        result.add(now.subtract(Duration(days: now.weekday - DateTime.wednesday)));
        break;
      case Weekday.thursday:
        result.add(now.subtract(Duration(days: now.weekday - DateTime.thursday)));
        break;
      case Weekday.friday:
        result.add(now.subtract(Duration(days: now.weekday - DateTime.friday)));
        break;
      case Weekday.saturday:
        result.add(now.subtract(Duration(days: now.weekday - DateTime.saturday)));
        break;
      case Weekday.sunday:
        result.add(now.subtract(Duration(days: now.weekday - DateTime.sunday)));
        break;
    }
  }
  return result;
}

bool isNextWeekdayContainsAlarm(List<Weekday> weekdays) {
  final DateTime nextDay = DateTime.now().add(const Duration(days: 1));

  final List<int> weekdayInts = weekdays.map((e) {
    switch (e) {
      case Weekday.monday:
        return DateTime.monday;
      case Weekday.tuesday:
        return DateTime.tuesday;
      case Weekday.wednesday:
        return DateTime.wednesday;
      case Weekday.thursday:
        return DateTime.thursday;
      case Weekday.friday:
        return DateTime.friday;
      case Weekday.saturday:
        return DateTime.saturday;
      case Weekday.sunday:
        return DateTime.sunday;
    }
  }).toList();

  return weekdayInts.contains(nextDay.weekday);
}
