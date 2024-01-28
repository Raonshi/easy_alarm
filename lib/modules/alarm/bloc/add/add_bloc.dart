import 'package:bloc/bloc.dart';
import 'package:easy_alarm/common/asset_path.dart';
import 'package:easy_alarm/common/tools.dart';
import 'package:easy_alarm/core/alarm_manager.dart';
import 'package:easy_alarm/modules/alarm/model/alarm_entity/alarm_entity.dart';
import 'package:easy_alarm/modules/alarm/model/alarm_group/alarm_group.dart';

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
      final DateTime now = DateTime.now();
      final DateTime currentDateTime = DateTime(now.year, now.month, now.day, now.hour, now.minute, 0);

      final List<AlarmEntity> newAlarms = state.alarmGroup.alarms.toList().map((e) {
        final DateTime oldDate = DateTime.fromMillisecondsSinceEpoch(e.timestamp);

        late final DateTime newDate;
        if (currentDateTime.difference(oldDate).inDays > 0) {
          newDate = DateTime(
              currentDateTime.year, currentDateTime.month, currentDateTime.day, updatedDate.hour, updatedDate.minute);
        } else {
          newDate = DateTime(oldDate.year, oldDate.month, oldDate.day, updatedDate.hour, updatedDate.minute);
        }

        return e.copyWith(timestamp: newDate.millisecondsSinceEpoch);
      }).toList();

      final AlarmGroup newAlarmGroup = state.alarmGroup.copyWith(alarms: newAlarms);
      emit(state.copyWith(alarmGroup: newAlarmGroup));
    });
  }

  void updateWeekdays(List<int> newWeekdays) {
    state.mapOrNull(loaded: (state) {
      late final AlarmGroup newAlarmGroup;
      late final List<AlarmEntity> newAlarms;

      final int timestamp = state.alarmGroup.alarms.first.timestamp;
      final SoundAssetPath sound = state.alarmGroup.alarms.first.sound;
      final bool vibration = state.alarmGroup.alarms.first.vibration;
      final int? snoozeDuration = state.alarmGroup.alarms.first.snoozeDuration;

      if (newWeekdays.isEmpty) {
        newAlarmGroup = state.alarmGroup.copyWith(
          routine: false,
          alarms: [
            AlarmEntity(
              id: timestamp,
              timestamp: timestamp,
              sound: sound,
              vibration: vibration,
              snoozeDuration: snoozeDuration,
            ),
          ],
        );
      } else {
        final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
        newAlarms = newWeekdays.map((e) {
          late final DateTime newDateTime;
          if (e > dateTime.weekday) {
            newDateTime = dateTime.add(Duration(days: e - dateTime.weekday));
          } else if (e < dateTime.weekday) {
            newDateTime = dateTime.add(Duration(days: 7 - dateTime.weekday + e));
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

        newAlarmGroup = state.alarmGroup.copyWith(alarms: newAlarms, routine: true,);
      }
      emit(state.copyWith(alarmGroup: newAlarmGroup));
    });
  }

  void updateSnoozeTime([Duration? duration]) {
    state.mapOrNull(loaded: (state) {
      final List<AlarmEntity> newAlarms = state.alarmGroup.alarms.toList().map((e) {
        return e.copyWith(snoozeDuration: duration?.inMinutes);
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
}
