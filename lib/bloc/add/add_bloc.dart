import 'package:bloc/bloc.dart';
import 'package:easy_alarm/bloc/add/add_bloc_state.dart';
import 'package:easy_alarm/model/alarm_model/alarm_model.dart';
import 'package:easy_alarm/model/time_model/time_model.dart';
import 'package:flutter/material.dart';

class AddBloc extends Cubit<AddBlocState> {
  AddBloc() : super(const AddBlocState.initial()) {
    _init();
  }

  void _init() async {
    state.mapOrNull(initial: (state) {
      const String id = "";
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

  void updateTime(TimeOfDay newTime) {
    state.mapOrNull(loaded: (state) {
      final AlarmModel alarmModel = state.alarmModel.copyWith(
        time: TimeModel(hour: newTime.hour, minute: newTime.minute),
      );

      emit(AddBlocState.loaded(alarmModel: alarmModel));
    });
  }
}
