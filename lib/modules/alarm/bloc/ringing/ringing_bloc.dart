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
      final int idx = _alarmManager.cachedAlarms.indexWhere((element) => element.id == settings.id);
      final AlarmEntity alarm = _alarmManager.cachedAlarms[idx];

      emit(RingingState.loaded(alarm: alarm));
    });
  }

  Future<int> waitForNextAlarm() async {
    return await state.mapOrNull(loaded: (state) async {
          final Duration duration = Duration(minutes: state.alarm.snoozeDuration ?? 10);
          final DateTime nextDateTime = DateTime.fromMillisecondsSinceEpoch(state.alarm.timestamp).add(duration);
          final AlarmEntity newAlarm = state.alarm.copyWith(timestamp: nextDateTime.millisecondsSinceEpoch);
          await _alarmManager.replaceAlarm(newAlarm);
          return duration.inMinutes;
        }) ??
        -1;
  }

  Future<void> stopAlarm() async {
    await state.mapOrNull(loaded: (state) async {
      final DateTime nextDay = DateTime.now().add(const Duration(days: 1));

      if (state.alarm.weekdays.isEmpty) {
        await _alarmManager.deleteAlarm(state.alarm.id);
      }

      if (state.alarm.weekdays.contains(nextDay.weekday)) {
        final DateTime alarmDateTime = DateTime.fromMillisecondsSinceEpoch(state.alarm.timestamp);
        final DateTime newAlarmDateTime =
            DateTime(nextDay.year, nextDay.month, nextDay.day, alarmDateTime.hour, alarmDateTime.minute);
        final AlarmEntity newAlarm = state.alarm.copyWith(timestamp: newAlarmDateTime.millisecondsSinceEpoch);
        await _alarmManager.replaceAlarm(newAlarm);
      }
    });
  }
}
