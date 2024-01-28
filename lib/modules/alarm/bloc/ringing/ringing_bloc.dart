import 'package:alarm/alarm.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_alarm/core/alarm_manager.dart';
import 'package:easy_alarm/modules/alarm/bloc/ringing/ringing_state.dart';
import 'package:easy_alarm/modules/alarm/model/alarm_entity/alarm_entity.dart';
import 'package:easy_alarm/modules/alarm/model/alarm_group/alarm_group.dart';

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

  Future<int> waitForNextAlarm() async {
    return await state.mapOrNull(loaded: (state) async {
          final Duration duration = Duration(minutes: state.alarm.snoozeDuration ?? 10);
          final DateTime nextDateTime = DateTime.fromMillisecondsSinceEpoch(state.alarm.timestamp).add(duration);
          final AlarmEntity newAlarm = state.alarm.copyWith(
            id: nextDateTime.millisecondsSinceEpoch,
            timestamp: nextDateTime.millisecondsSinceEpoch,
          );
          await _alarmManager.waitForNextAlarm(newAlarm);
          return duration.inMinutes;
        }) ??
        -1;
  }

  Future<void> stopAlarm() async {
    await state.mapOrNull(loaded: (state) async {
      final int groupIdx = _alarmManager.cachedAlarmGroups.indexWhere((group) {
        final int entityIdx = group.alarms.indexWhere((entity) => entity.id == state.alarm.id);
        if (entityIdx == -1) return false;
        return true;
      });

      if (groupIdx == -1) return;

      final AlarmGroup group = _alarmManager.cachedAlarmGroups[groupIdx];
      final List<AlarmEntity> groupAlarms = group.alarms.toList();

      final int entityIdx = groupAlarms.indexWhere((entity) => entity.id == state.alarm.id);
      if (entityIdx == -1) return;

      final AlarmEntity prevAlarm = groupAlarms[entityIdx];
      final DateTime prevDateTime = DateTime.fromMillisecondsSinceEpoch(prevAlarm.timestamp);
      final DateTime nextDateTime = prevDateTime.add(const Duration(days: 7));

      final AlarmEntity newAlarm = prevAlarm.copyWith(
        id: nextDateTime.millisecondsSinceEpoch,
        timestamp: nextDateTime.millisecondsSinceEpoch,
      );

      await _alarmManager.deleteAlarmEntity(state.alarm.id);
      groupAlarms.add(newAlarm);
      await _alarmManager.replaceAlarmGroup(group.copyWith(alarms: groupAlarms));
    });
  }
}
