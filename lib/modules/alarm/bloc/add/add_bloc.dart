import 'package:bloc/bloc.dart';
import 'package:easy_alarm/core/alarm_manager.dart';
import 'package:easy_alarm/modules/alarm/model/alarm_entity/alarm_entity.dart';

import 'add_state.dart';

class AddBloc extends Cubit<AddState> {
  final AlarmManager _alarmManager = AlarmManager();

  AddBloc() : super(const AddState.initial()) {
    _init();
  }

  void _init() async {
    state.mapOrNull(initial: (state) {
      final int id = _alarmManager.firstEmptyId;
      final int timestamp = DateTime.now().millisecondsSinceEpoch;

      emit(
        AddState.loaded(
          alarm: AlarmEntity(
            id: id,
            isAm: DateTime.now().hour < 12 ? true : false,
            timestamp: timestamp,
            weekdays: [],
          ),
        ),
      );
    });
  }

  void updateTitle(String newTitle) {
    state.mapOrNull(loaded: (state) {
      final AlarmEntity newAlarm = state.alarm.copyWith(title: newTitle);
      emit(state.copyWith(alarm: newAlarm));
    });
  }

  void updateContent(String newContent) {
    state.mapOrNull(loaded: (state) {
      final AlarmEntity newAlarm = state.alarm.copyWith(content: newContent);
      emit(state.copyWith(alarm: newAlarm));
    });
  }

  void updateTime(DateTime newDate) {
    state.mapOrNull(loaded: (state) {
      final AlarmEntity newAlarm = state.alarm.copyWith(timestamp: newDate.millisecondsSinceEpoch);
      emit(state.copyWith(alarm: newAlarm));
    });
  }

  void updateWeekdays(List<int> newWeekdays) {
    state.mapOrNull(loaded: (state) {
      final AlarmEntity newAlarm = state.alarm.copyWith(weekdays: newWeekdays);
      emit(state.copyWith(alarm: newAlarm));
    });
  }

  void updateSnoozeTime([Duration? duration]) {
    state.mapOrNull(loaded: (state) {
      late final AlarmEntity newAlarm;
      if (duration != null) {
        newAlarm = state.alarm.copyWith(snoozeDuration: duration.inMinutes);
      } else {
        newAlarm = state.alarm.copyWith(snoozeDuration: null);
      }

      emit(state.copyWith(alarm: newAlarm));
    });
  }

  Future<void> save() async {
    await state.mapOrNull(loaded: (state) async {
      await _alarmManager.saveAlarm(state.alarm);
    });
  }
}
