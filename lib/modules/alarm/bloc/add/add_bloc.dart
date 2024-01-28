import 'package:bloc/bloc.dart';
import 'package:easy_alarm/common/asset_path.dart';
import 'package:easy_alarm/common/tools.dart';
import 'package:easy_alarm/core/alarm_manager.dart';
import 'package:easy_alarm/modules/alarm/model/alarm_entity/alarm_entity.dart';
import 'package:easy_alarm/modules/alarm/model/alarm_group/alarm_group.dart';
import 'package:easy_localization/easy_localization.dart';

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
      emit(state.copyWith(alarmGroup: state.alarmGroup.copyWith(alarms: newAlarms)));
    });
  }

  void updateWeekdays(bool isRoutine, List<int> newWeekdays) {
    state.mapOrNull(loaded: (state) {
      final List<AlarmEntity> updatedAlarms = _updateWeekdays(isRoutine, state.alarmGroup, newWeekdays);

      lgr.d(updatedAlarms.map((e) => e.dateTime));

      emit(state.copyWith(
        alarmGroup: state.alarmGroup.copyWith(alarms: updatedAlarms, routine: isRoutine),
      ));
    });
  }

  List<AlarmEntity> _updateTime(AlarmGroup alarmGroup, DateTime dateTime) {
    final DateTime now = DateTime.now();
    final DateTime currentDateTime = DateTime(now.year, now.month, now.day, now.hour, now.minute, 0);

    return alarmGroup.alarms.toList().map((e) {
      final DateTime oldDate = DateTime.fromMillisecondsSinceEpoch(e.timestamp);

      late final DateTime newDate;
      if (currentDateTime.difference(oldDate).inDays > 0) {
        newDate = DateTime(
          currentDateTime.year,
          currentDateTime.month,
          currentDateTime.day,
          dateTime.hour,
          dateTime.minute,
        );
      } else {
        if (oldDate.isBefore(now)) {
          newDate = DateTime(
            oldDate.year,
            oldDate.month,
            oldDate.day + 1,
            dateTime.hour,
            dateTime.minute,
            0,
          );
        } else {
          newDate = DateTime(
            oldDate.year,
            oldDate.month,
            oldDate.day,
            dateTime.hour,
            dateTime.minute,
            0,
          );
        }
      }

      return e.copyWith(timestamp: newDate.millisecondsSinceEpoch);
    }).toList();
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
