import 'package:alarm/alarm.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_alarm/core/alarm_manager.dart';
import 'package:easy_alarm/modules/alarm/bloc/ringing/ringing_state.dart';
import 'package:easy_alarm/modules/alarm/model/alarm_entity/alarm_entity.dart';

class RingingBloc extends Cubit<RingingState> {
  final AlarmManager _alarmManager = AlarmManager();

  RingingBloc(AlarmSettings settings) : super(const RingingState.initial()) {
    _init(settings);
  }

  void _init(AlarmSettings settings) async {
    state.mapOrNull(initial: (state) {
      final List<AlarmEntity> alarms =
          _alarmManager.cachedAlarmGroups.fold([], (previousValue, element) => [...previousValue, ...element.alarms]);

      final int idx = alarms.indexWhere((element) => element.id == settings.id);
      if (idx == -1) {
        emit(RingingState.error(exception: Exception("Alarm not found")));
        return;
      }

      final AlarmEntity alarm = alarms[idx];
      emit(RingingState.loaded(alarm: alarm));
    });
  }

  Future<void> waitForSnooze() async {
    await state.mapOrNull(loaded: (state) async {
      await _alarmManager.waitForSnooze(state.alarm);
    });
  }

  Future<void> stopAlarm() async {
    await state.mapOrNull(loaded: (state) async {
      await _alarmManager.prepareNextRoutine(state.alarm);
    });
  }
}
