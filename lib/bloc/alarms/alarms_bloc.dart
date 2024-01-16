import 'dart:developer';

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
        emit(const AlarmsState.loading());
        await _alarmManager.loadAlarms();
        emit(AlarmsState.loaded(alarmModels: _alarmManager.cachedAlarms));
      },
    );
  }

  void refreshAlarms() {
    state.mapOrNull(
      loaded: (state) async {
        emit(const AlarmsState.loading());
        await _alarmManager.loadAlarms();
        emit(AlarmsState.loaded(alarmModels: _alarmManager.cachedAlarms));
      },
    );
  }

  void toggleAlarm(String id) {
    state.mapOrNull(
      loaded: (state) async {
        final List<AlarmModel> alarms = state.alarmModels.toList();
        final int idx = alarms.indexWhere((element) => element.id == id);
        if (idx == -1) return;

        final AlarmModel newAlarm = alarms[idx].copyWith(isEnabled: !alarms[idx].isEnabled);
        await _alarmManager.replaceAlarm(newAlarm);

        // _notificationManager.schedule(id: , title: title, body: body)

        alarms.replaceRange(idx, idx + 1, [newAlarm]);
        emit(state.copyWith(alarmModels: alarms));
      },
    );
  }

  void deleteAlarm(String id) {
    state.mapOrNull(
      loaded: (state) async {
        final List<AlarmModel> alarms = state.alarmModels.toList();
        final int idx = alarms.indexWhere((element) => element.id == id);
        if (idx == -1) return;

        await _alarmManager.deleteAlarm(id);

        alarms.removeAt(idx);
        emit(state.copyWith(alarmModels: alarms));
      },
    );
  }
}
