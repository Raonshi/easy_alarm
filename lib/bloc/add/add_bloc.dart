import 'package:bloc/bloc.dart';
import 'package:easy_alarm/bloc/add/add_bloc_state.dart';
import 'package:easy_alarm/common/enums.dart';
import 'package:easy_alarm/core/alarm_manager.dart';
import 'package:easy_alarm/core/notification_manager.dart';
import 'package:easy_alarm/model/alarm_model/alarm_model.dart';
import 'package:easy_alarm/model/time_model/time_model.dart';
import 'package:flutter/material.dart';

class AddBloc extends Cubit<AddBlocState> {
  final AlarmManager _alarmManager = AlarmManager();
  final NotificationManager _notificationManager = NotificationManager();

  AddBloc() : super(const AddBlocState.initial()) {
    _init();
  }

  void _init() async {
    state.mapOrNull(initial: (state) {
      final int id = _alarmManager.firstEmptyId;
      final TimeOfDay time = TimeOfDay.now();

      final TimeModel timeModel = TimeModel(hour: time.hour, minute: time.minute);
      const TimeModel snoozeTimeModel = TimeModel(hour: 0, minute: 0);

      emit(
        AddBlocState.loaded(
          alarmModel: AlarmModel(
            id: id,
            isAm: time.hour < 12 ? true : false,
            time: timeModel,
            snoozeTime: snoozeTimeModel,
          ),
        ),
      );
    });
  }

  void updateTitle(String newTitle) {
    state.mapOrNull(loaded: (state) {
      final AlarmModel alarmModel = state.alarmModel.copyWith(title: newTitle);
      emit(AddBlocState.loaded(alarmModel: alarmModel));
    });
  }

  void updateContent(String newContent) {
    state.mapOrNull(loaded: (state) {
      final AlarmModel alarmModel = state.alarmModel.copyWith(content: newContent);
      emit(AddBlocState.loaded(alarmModel: alarmModel));
    });
  }

  void updateTime(TimeOfDay newTime) {
    state.mapOrNull(loaded: (state) {
      final AlarmModel alarmModel = state.alarmModel.copyWith(
        time: TimeModel(hour: newTime.hour, minute: newTime.minute),
      );

      emit(AddBlocState.loaded(alarmModel: alarmModel));
    });
  }

  void updateWeekdays(List<Weekday> weekDays) {
    state.mapOrNull(loaded: (state) {
      final AlarmModel alarmModel = state.alarmModel.copyWith(
        weekdays: weekDays,
      );

      emit(AddBlocState.loaded(alarmModel: alarmModel));
    });
  }

  void updateSnoozeTime([Duration? duration]) {
    state.mapOrNull(loaded: (state) {
      late final AlarmModel alarmModel;
      if (duration != null) {
        final int hour = duration.inMinutes ~/ 60;
        final int minute = duration.inMinutes % 60;
        alarmModel = state.alarmModel.copyWith(snoozeTime: TimeModel(hour: hour, minute: minute));
      } else {
        alarmModel = state.alarmModel.copyWith(snoozeTime: null);
      }

      emit(AddBlocState.loaded(alarmModel: alarmModel));
    });
  }

  Future<void> save() async {
    await state.mapOrNull(loaded: (state) async {
      await _alarmManager.saveAlarm(state.alarmModel).then((value) {});
      await _notificationManager.schedule(alarm: state.alarmModel);
    });
  }
}
