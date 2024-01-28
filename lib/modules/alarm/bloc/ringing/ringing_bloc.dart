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

  Future<int> waitForSnooze() async {
    return await state.mapOrNull(loaded: (state) async {
          final Duration duration = Duration(minutes: state.alarm.snoozeDuration ?? 10);
          final DateTime nextDateTime = DateTime.fromMillisecondsSinceEpoch(state.alarm.timestamp).add(duration);
          final AlarmEntity newAlarm = state.alarm.copyWith(
            id: nextDateTime.millisecondsSinceEpoch,
            timestamp: nextDateTime.millisecondsSinceEpoch,
          );
          await _alarmManager.waitForSnooze(newAlarm);
          return duration.inMinutes;
        }) ??
        -1;
  }

  Future<void> stopAlarm() async {
    state.mapOrNull(loaded: (state) {
      _alarmManager.addNextRoutine(state.alarm);
    });
  }
}
