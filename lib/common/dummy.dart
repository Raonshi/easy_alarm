import 'dart:math';

import 'package:easy_alarm/common/enums.dart';
import 'package:easy_alarm/model/alarm_model/alarm_model.dart';
import 'package:easy_alarm/model/time_model/time_model.dart';
import 'package:flutter/widgets.dart';

List<AlarmModel> dummyAlarms = List.generate(
  Random().nextInt(30),
  (index) {
    final String id = UniqueKey().toString();
    final int weekdayLength = Random().nextInt(7);

    return AlarmModel(
      id: id,
      isAm: Random().nextBool(),
      time: TimeModel(
        hour: Random().nextInt(12),
        minute: Random().nextInt(60),
      ),
      weekdays: weekdayLength == 0 ? [] : List.generate(weekdayLength, (index) => Weekday.values[index]),
      snoozeTime: TimeModel(
        hour: Random().nextInt(12),
        minute: Random().nextInt(60),
      ),
    );
  },
);
