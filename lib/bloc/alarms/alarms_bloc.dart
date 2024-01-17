import 'package:bloc/bloc.dart';
import 'package:easy_alarm/bloc/alarms/alarms_state.dart';
import 'package:easy_alarm/core/alarm_manager.dart';
import 'package:easy_alarm/core/notification_manager.dart';
import 'package:easy_alarm/model/alarm_model/alarm_model.dart';

class AlarmsBloc extends Cubit<AlarmsState> {
  final AlarmManager _alarmManager = AlarmManager();
  final NotificationManager _notificationManager = NotificationManager();
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
    emit(AlarmsState.loaded(alarmModels: _alarmManager.cachedAlarms));
  }

  void toggleAlarm(int id) {
    state.mapOrNull(
      loaded: (state) async {
        final List<AlarmModel> alarms = state.alarmModels.toList();
        final int idx = alarms.indexWhere((element) => element.id == id);
        if (idx == -1) return;

        final AlarmModel newAlarm = alarms[idx].copyWith(isEnabled: !alarms[idx].isEnabled);
        alarms.replaceRange(idx, idx + 1, [newAlarm]);
        emit(state.copyWith(alarmModels: alarms));

        _alarmManager.replaceAlarm(newAlarm).then((value) async {
          if (newAlarm.isEnabled) {
            await _notificationManager.schedule(alarm: newAlarm);
          } else {
            await _notificationManager.cancelAlarmNotification(newAlarm.id);
          }
        });
      },
    );
  }

  void deleteAlarm(int id) {
    state.mapOrNull(
      loaded: (state) async {
        emit(const AlarmsState.loading());
        final List<AlarmModel> alarms = state.alarmModels.toList();
        final int idx = alarms.indexWhere((element) => element.id == id);
        if (idx == -1) return;

        alarms.removeAt(idx);
        emit(AlarmsState.loaded(alarmModels: alarms));
        await _alarmManager.deleteAlarm(id);
        await _notificationManager.cancelAlarmNotification(id);
      },
    );
  }
}
