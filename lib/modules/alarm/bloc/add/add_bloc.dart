import 'package:bloc/bloc.dart';
import 'package:easy_alarm/common/asset_path.dart';
import 'package:easy_alarm/common/tools.dart';
import 'package:easy_alarm/core/alarm_manager.dart';
import 'package:easy_alarm/modules/alarm/model/alarm_entity/alarm_entity.dart';
import 'package:easy_alarm/modules/alarm/model/alarm_group/alarm_group.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'add_state.dart';

class AddBloc extends Cubit<AddState> {
  final AlarmManager _alarmManager = AlarmManager();

  AddBloc() : super(const AddState.initial()) {
    _init();
  }

  void _init() async {
    state.mapOrNull(initial: (state) {
      final int id = _alarmManager.firstEmptyId;
      final DateTime now = DateTime.now();
      final int timestamp = DateTime(now.year, now.month, now.day, now.hour, now.minute, 0).millisecondsSinceEpoch;

      final AlarmEntity newAlarmEntity = AlarmEntity(
        id: timestamp,
        timestamp: timestamp,
        sound: SoundAssetPath.defaultSound,
      );

      emit(AddState.loaded(alarmGroup: AlarmGroup(id: id, alarms: [newAlarmEntity])));
    });
  }

  void updateTime(DateTime updatedDate) {
    state.mapOrNull(loaded: (state) {
      final List<AlarmEntity> newAlarms = _updateTime(state.alarmGroup, updatedDate);
      lgr.d("INPUT:$updatedDate\nOUTPUT:${newAlarms.map((e) => e.dateTime)}");
      emit(state.copyWith(alarmGroup: state.alarmGroup.copyWith(alarms: newAlarms)));
    });
  }

  void updateWeekdays(bool isRoutine, List<int> newWeekdays) {
    state.mapOrNull(loaded: (state) {
      final List<AlarmEntity> newAlarms = _updateWeekdays(isRoutine, state.alarmGroup, newWeekdays);
      lgr.d("INPUT:$newWeekdays\nOUTPUT:${newAlarms.map((e) => e.dateTime)}");
      emit(state.copyWith(
        alarmGroup: state.alarmGroup.copyWith(alarms: newAlarms, routine: isRoutine),
      ));
    });
  }

  List<AlarmEntity> _updateTime(AlarmGroup alarmGroup, DateTime inputDate) {
    final DateTime now = DateTime.now();
    final DateTime currentDate = DateTime(now.year, now.month, now.day, now.hour, now.minute, 0);
    // 루틴이 있는 알람 -> 알람이 여러개 있을 때
    if (alarmGroup.routine) {
      inputDate = DateTime(now.year, now.month, now.day, inputDate.hour, inputDate.minute, 0);
      return alarmGroup.alarms.map((alarm) {
        final DateTime alarmDate = alarm.dateTime;

        DateTime newDate = DateTime(
          alarmDate.year,
          alarmDate.month,
          alarmDate.day,
          inputDate.hour,
          inputDate.minute,
        );

        // 알람 요일이 현재 요일보다 이전인 경우
        if (alarmDate.weekday < currentDate.weekday) {
          // 알람 날짜가 현재 날짜보다 이후인 경우 : 알람 날짜 유지
          if (alarmDate.isAfter(currentDate)) {
            newDate = newDate;
          }
          // 알람 날짜가 현재 날짜보다 이전 혹은 같은 경우 : 다음 주로 설정
          else {
            newDate = newDate.add(const Duration(days: 7));
          }
        }
        // 알람 요일이 현재 요일보다 이후인 경우
        else if (alarmDate.weekday < currentDate.weekday) {
          newDate = newDate.add(Duration(days: alarmDate.weekday - currentDate.weekday + 1));
        }
        // 알람 요일이 현재 요일과 동일한 경우
        else {
          // 알람 날짜가 현재 날짜보다 이후인 경우 : 입력 날짜로 설정
          if (alarmDate.isAfter(currentDate)) {
            newDate = inputDate;
          }
          // 알람 날짜가 현재 날짜보다 이전 혹은 같은 경우 : 다음 주로 설정
          else {
            newDate = newDate.add(const Duration(days: 7));
          }
        }

        // // 알람 날짜가 현재 날짜보다 이전인 경우 : 다음 주로 설정
        // if (alarmDate.isBefore(inputDate)) {
        //   newDate = newDate.add(const Duration(days: 7));
        // }
        // // 알람 날짜가 현재 날짜보다 이후인 경우
        // else if (alarmDate.isAfter(inputDate)) {
        //   final int alarmDateInMinutes = alarmDate.hour * 60 + alarmDate.minute;
        //   final int inputDateInMinutes = inputDate.hour * 60 + inputDate.minute;

        //   lgr.d("alarmDateInMinutes: $alarmDateInMinutes\n"
        //       "inputDateInMinutes: $inputDateInMinutes");
        //   // 알람 시간이 현재 시간보다 이전인 경우: 오늘로 설정
        //   if (alarmDateInMinutes < inputDateInMinutes) {
        //     if (alarmDate.weekday == inputDate.weekday) {
        //       newDate = newDate.subtract(const Duration(days: 7));
        //     } else {
        //       newDate = newDate;
        //     }
        //   }
        //   // 알람 시간이 현재 시간보다 이후인 경우: 알람 날짜 유지
        //   else if (alarmDateInMinutes > inputDateInMinutes) {
        //     newDate = newDate;
        //   }
        //   // 알람 시간이 현재 시간과 같은 경우: 알람 날짜 유지
        //   else {
        //     newDate = newDate;
        //   }
        // }
        // // 알람 날짜가 현재 날짜인 경우 : 다음 주로 설정
        // else {
        //   newDate = newDate.add(const Duration(days: 7));
        // }

        final DateTime nextAlarmDate = newDate.add(
          Duration(minutes: alarm.snoozeDuration == null ? 0 : alarm.snoozeDuration!),
        );

        return alarm.copyWith(
          id: newDate.millisecondsSinceEpoch,
          timestamp: newDate.millisecondsSinceEpoch,
          nextTimstamp: nextAlarmDate.millisecondsSinceEpoch,
        );
      }).toList();
    }
    // 루틴이 없는 알람 -> 알람이 하나만 있을 때
    else {
      return alarmGroup.alarms.map((alarm) {
        final DateTime alarmDate = alarm.dateTime;
        final int alarmDateInMinutes = alarmDate.hour * 60 + alarmDate.minute;
        final int inputDateInMinutes = inputDate.hour * 60 + inputDate.minute;

        DateTime newDate = DateTime(now.year, now.month, now.day, inputDate.hour, inputDate.minute);
        // 알람 시간이 현재 입력 시간보다 이전인 경우 : 다음 날로 설정
        if (alarmDateInMinutes >= inputDateInMinutes) {
          newDate = newDate.add(const Duration(days: 1));
        }

        final DateTime nextAlarmDate = newDate.add(
          Duration(minutes: alarm.snoozeDuration == null ? 0 : alarm.snoozeDuration!),
        );

        return alarm.copyWith(
          id: newDate.millisecondsSinceEpoch,
          timestamp: newDate.millisecondsSinceEpoch,
          nextTimstamp: nextAlarmDate.millisecondsSinceEpoch,
        );
      }).toList();
      // late final DateTime newDate;
      // final DateTime currentDate = DateTime(now.year, now.month, now.day, now.hour, now.minute, 0);
      // if (inputDate.isAfter(currentDate)) {
      //   newDate = DateTime(currentDate.year, currentDate.month, currentDate.day, inputDate.hour, inputDate.minute, 0);
      // }
      // // 오늘이 아니면 내일로 설정
      // else {
      //   final DateTime tomorrow = currentDate.add(const Duration(days: 1));
      //   newDate = DateTime(tomorrow.year, tomorrow.month, tomorrow.day, inputDate.hour, inputDate.minute, 0);
      // }

      // return alarmGroup.alarms.map((e) {
      //   final DateTime nextAlarmDate = newDate.add(
      //     Duration(minutes: e.snoozeDuration == null ? 0 : e.snoozeDuration!),
      //   );
      //   return e.copyWith(
      //     id: newDate.millisecondsSinceEpoch,
      //     timestamp: newDate.millisecondsSinceEpoch,
      //     nextTimstamp: nextAlarmDate.millisecondsSinceEpoch,
      //   );
      // }).toList();
    }
  }

  List<AlarmEntity> _updateWeekdays(bool isRoutine, AlarmGroup alarmGroup, List<int> weekdays) {
    final List<AlarmEntity> currentAlarms = alarmGroup.alarms.toList();
    currentAlarms.sort((a, b) => a.timestamp.compareTo(b.timestamp));

    final int timestamp = currentAlarms.first.timestamp;
    final SoundAssetPath sound = currentAlarms.first.sound;
    final bool vibration = currentAlarms.first.vibration;
    final int? snoozeDuration = currentAlarms.first.snoozeDuration;
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

    // If it is a routine, it is a weekly alarm.
    if (isRoutine) {
      return weekdays.map((e) {
        final DateTime now = DateTime.now();
        late final DateTime newDateTime;

        if (e > dateTime.weekday) {
          if (e == now.weekday) {
            newDateTime = DateTime(now.year, now.month, now.day, dateTime.hour, dateTime.minute, 0);
            if (dateTime.isBefore(now)) newDateTime.add(const Duration(days: 7));
          } else {
            newDateTime = dateTime.add(Duration(days: e - dateTime.weekday));
          }
        } else if (e < dateTime.weekday) {
          newDateTime = dateTime.add(Duration(days: 7 - dateTime.weekday + e));
        } else {
          newDateTime = DateTime(now.year, now.month, now.day, dateTime.hour, dateTime.minute, 0);
          if (dateTime.isBefore(now)) newDateTime.add(const Duration(days: 7));
        }

        return AlarmEntity(
          id: newDateTime.millisecondsSinceEpoch,
          timestamp: newDateTime.millisecondsSinceEpoch,
          sound: sound,
          vibration: vibration,
          snoozeDuration: snoozeDuration,
        );
      }).toList();
    }
    // If it is not a routine, it is a one-time alarm.
    else {
      return weekdays.map((e) {
        final DateTime now = DateTime.now();
        late final DateTime newDateTime;
        if (dateTime.isBefore(now)) {
          newDateTime = DateTime(now.year, now.month, now.day + 1, dateTime.hour, dateTime.minute, 0);
        } else {
          newDateTime = dateTime;
        }

        return AlarmEntity(
          id: newDateTime.millisecondsSinceEpoch,
          timestamp: newDateTime.millisecondsSinceEpoch,
          sound: sound,
          vibration: vibration,
          snoozeDuration: snoozeDuration,
        );
      }).toList();
    }
  }

  void updateSnoozeTime([Duration? duration]) {
    state.mapOrNull(loaded: (state) {
      final List<AlarmEntity> newAlarms = state.alarmGroup.alarms.toList().map((e) {
        return e.copyWith(
          snoozeDuration: duration?.inMinutes,
          nextTimstamp: duration == null ? null : e.timestamp + duration.inMilliseconds,
        );
      }).toList();

      final AlarmGroup newAlarmGroup = state.alarmGroup.copyWith(alarms: newAlarms);
      emit(state.copyWith(alarmGroup: newAlarmGroup));
    });
  }

  void updateSound(SoundAssetPath newSound) {
    state.mapOrNull(loaded: (state) {
      final List<AlarmEntity> newAlarms = state.alarmGroup.alarms.toList().map((e) {
        return e.copyWith(sound: newSound);
      }).toList();

      final AlarmGroup newAlarmGroup = state.alarmGroup.copyWith(alarms: newAlarms);
      emit(state.copyWith(alarmGroup: newAlarmGroup));
    });
  }

  void updateVibration(bool newVibration) {
    state.mapOrNull(loaded: (state) {
      final List<AlarmEntity> newAlarms = state.alarmGroup.alarms.toList().map((e) {
        return e.copyWith(vibration: newVibration);
      }).toList();

      final AlarmGroup newAlarmGroup = state.alarmGroup.copyWith(alarms: newAlarms);
      emit(state.copyWith(alarmGroup: newAlarmGroup));
    });
  }

  Future<void> save() async {
    await state.mapOrNull(loaded: (state) async {
      await _alarmManager.saveAlarm(state.alarmGroup);
    });
  }

  Future<String?> validate() async {
    return state.maybeMap(
      loaded: (value) {
        if (value.alarmGroup.alarms.isEmpty) return "exception.emptyAlarm".tr();

        for (AlarmEntity alarm in value.alarmGroup.alarms) {
          if (alarm.dateTime.isBefore(DateTime.now())) return "exception.canNotMakeAlarmAtCurrentDateTime".tr();
          if (alarm.snoozeDuration != null && alarm.snoozeDuration! < 1) return "exception.invalidSnoozeDuration".tr();
        }

        return null;
      },
      orElse: () => "exception.unknown".tr(),
    );
  }
}
