import 'package:easy_alarm/common/asset_path.dart';
import 'package:easy_alarm/common/tools.dart';
import 'package:easy_alarm/modules/alarm/model/alarm_entity/alarm_entity.dart';
import 'package:easy_alarm/modules/alarm/model/alarm_group/alarm_group.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("날짜 계산 테스트", () {
    final alarmGroup = AlarmGroup(
      id: 999,
      alarms: [
        DateTime(2024, 1, 29, 20, 33, 0),
        DateTime(2024, 1, 30, 20, 33, 0),
        DateTime(2024, 1, 31, 20, 33, 0),
        DateTime(2024, 2, 1, 20, 33, 0),
        DateTime(2024, 2, 2, 20, 33, 0),
      ]
          .map((e) => AlarmEntity(
                id: e.millisecondsSinceEpoch,
                timestamp: e.millisecondsSinceEpoch,
                sound: SoundAssetPath.defaultSound,
              ))
          .toList(),
    );

    test("Test 1 : 1 Minute Before", () {
      final testDateTime2 = DateTime(2024, 1, 30, 20, 32, 0);
      final List<AlarmEntity> alarms = _updateTime(alarmGroup, testDateTime2);
      expect(alarms.map((e) => e.dateTime).toList(), [
        DateTime(2024, 2, 5, 20, 32, 0),
        DateTime(2024, 2, 6, 20, 32, 0),
        DateTime(2024, 1, 31, 20, 32, 0),
        DateTime(2024, 2, 1, 20, 32, 0),
        DateTime(2024, 2, 2, 20, 32, 0),
      ]);
    });

    test("Test 2 : Same Time", () {
      final testDateTime1 = DateTime(2024, 1, 30, 20, 33, 0);
      final List<AlarmEntity> alarms = _updateTime(alarmGroup, testDateTime1);
      expect(alarms.map((e) => e.dateTime).toList(), [
        DateTime(2024, 2, 5, 20, 33, 0),
        DateTime(2024, 2, 6, 20, 33, 0),
        DateTime(2024, 1, 31, 20, 33, 0),
        DateTime(2024, 2, 1, 20, 33, 0),
        DateTime(2024, 2, 2, 20, 33, 0),
      ]);
    });

    test("Test 3 : 1 Minute later", () {
      final testDateTime3 = DateTime(2024, 1, 30, 20, 34, 0);
      final List<AlarmEntity> alarms = _updateTime(alarmGroup, testDateTime3);
      expect(alarms.map((e) => e.dateTime).toList(), [
        DateTime(2024, 2, 5, 20, 34, 0),
        DateTime(2024, 1, 30, 20, 34, 0),
        DateTime(2024, 1, 31, 20, 34, 0),
        DateTime(2024, 2, 1, 20, 34, 0),
        DateTime(2024, 2, 2, 20, 34, 0),
      ]);
    });

    test("Test 4 - 2024.01.30 07:12", () {
      final testDateTime3 = DateTime(2024, 1, 30, 07, 12, 0);
      final List<AlarmEntity> alarms = _updateTime(alarmGroup, testDateTime3);
      expect(alarms.map((e) => e.dateTime).toList(), [
        DateTime(2024, 2, 5, 7, 12, 0),
        DateTime(2024, 2, 6, 7, 12, 0),
        DateTime(2024, 1, 31, 7, 12, 0),
        DateTime(2024, 2, 1, 7, 12, 0),
        DateTime(2024, 2, 2, 7, 12, 0),
      ]);
    });

    test("Test 5 - 2024.01.30 23:45", () {
      final testDateTime3 = DateTime(2024, 1, 30, 23, 45, 0);
      final List<AlarmEntity> alarms = _updateTime(alarmGroup, testDateTime3);
      expect(alarms.map((e) => e.dateTime).toList(), [
        DateTime(2024, 2, 5, 23, 45, 0),
        DateTime(2024, 1, 30, 23, 45, 0),
        DateTime(2024, 1, 31, 23, 45, 0),
        DateTime(2024, 2, 1, 23, 45, 0),
        DateTime(2024, 2, 2, 23, 45, 0),
      ]);
    });
  });
}

List<AlarmEntity> _updateTime(AlarmGroup alarmGroup, DateTime dateTime) {
  final DateTime now = DateTime.now();
  DateTime inputDate = DateTime(now.year, now.month, now.day, dateTime.hour, dateTime.minute);

  return alarmGroup.alarms.map((alarm) {
    final DateTime alarmDate = alarm.dateTime;
    final int alarmWeekday = alarmDate.weekday;
    final int currentWeekday = inputDate.weekday;

    DateTime updatedDate = DateTime(alarmDate.year, alarmDate.month, alarmDate.day, dateTime.hour, dateTime.minute);
    if (alarmWeekday < currentWeekday) {
      updatedDate = updatedDate.add(const Duration(days: 7));
    } else if (alarmWeekday == currentWeekday) {
      if (inputDate.isAfter(alarmDate)) {
        updatedDate = inputDate;
      } else {
        updatedDate = updatedDate.add(const Duration(days: 7));
      }
    }
    return alarm.copyWith(
      id: updatedDate.millisecondsSinceEpoch,
      timestamp: updatedDate.millisecondsSinceEpoch,
      nextTimstamp: updatedDate.add(Duration(minutes: alarm.snoozeDuration ?? 0)).millisecondsSinceEpoch,
    );
  }).toList();
}
