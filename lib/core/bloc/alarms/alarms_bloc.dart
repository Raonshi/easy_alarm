import 'package:bloc/bloc.dart';
import 'package:easy_alarm/core/alarm_manager.dart';
import 'package:easy_alarm/modules/alarm/model/alarm_group/alarm_group.dart';

import 'alarms_state.dart';

class AlarmsBloc extends Cubit<AlarmsState> {
  final AlarmManager _alarmManager = AlarmManager();
  AlarmsBloc() : super(const AlarmsState.initial()) {
    _init();
  }

  void _init() {
    state.mapOrNull(
      initial: (state) async {
        await _fetchAlarms();
      },
    );
  }

  void refreshAlarms() {
    state.mapOrNull(
      loaded: (state) async {
        _fetchAlarms();
      },
    );
  }

  Future<void> _fetchAlarms() async {
    emit(const AlarmsState.loading());
    await _alarmManager.loadAlarms();
    emit(AlarmsState.loaded(alarms: _alarmManager.cachedAlarmGroups));
  }

  void toggleAlarm(int id) {
    state.mapOrNull(
      loaded: (state) async {
        final List<AlarmGroup> alarms = state.alarms.toList();
        final int idx = alarms.indexWhere((element) => element.id == id);
        if (idx == -1) return;

        final AlarmGroup newAlarm = alarms[idx].copyWith(isEnabled: !alarms[idx].isEnabled);
        alarms.replaceRange(idx, idx + 1, [newAlarm]);
        emit(state.copyWith(alarms: alarms));

        _alarmManager.replaceAlarmGroup(newAlarm).then((value) async {
          if (newAlarm.isEnabled) {
            // await _notificationManager.schedule(alarm: newAlarm);
          } else {
            // await _notificationManager.cancelAlarmNotification(newAlarm.id);
          }
        });
      },
    );
  }

  void deleteAlarm(int id) {
    state.mapOrNull(
      loaded: (state) async {
        emit(const AlarmsState.loading());
        final List<AlarmGroup> alarms = state.alarms.toList();
        final int idx = alarms.indexWhere((element) => element.id == id);
        if (idx == -1) return;

        alarms.removeAt(idx);
        emit(AlarmsState.loaded(alarms: alarms));
        await _alarmManager.deleteAlarmGroup(id);
        // await _notificationManager.cancelAlarmNotification(id);
      },
    );
  }
}
