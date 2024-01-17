import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easy_alarm/bloc/alarms/alarms_state.dart';
import 'package:easy_alarm/core/alarm_manager.dart';
import 'package:easy_alarm/model/alarm_model/alarm_model.dart';

class AlarmsBloc extends Cubit<AlarmsState> {
  final AlarmManager _alarmManager = AlarmManager();
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
      loaded: (state) {
        _alarmManager.loadAlarms().then((value) => emit(state.copyWith(alarmModels: _alarmManager.cachedAlarms)));
        // emit(const AlarmsState.loading());
        // await _alarmManager.loadAlarms();
        // emit(AlarmsState.loaded(alarmModels: _alarmManager.cachedAlarms));
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
        alarms.replaceRange(idx, idx + 1, [newAlarm]);
        emit(state.copyWith(alarmModels: alarms));

        _alarmManager.replaceAlarm(newAlarm).then((value) {
          // _notificationManager.schedule(id: , title: title, body: body);
        });
      },
    );
  }

  void deleteAlarm(String id) {
    state.mapOrNull(
      loaded: (state) async {
        emit(const AlarmsState.loading());
        final List<AlarmModel> alarms = state.alarmModels.toList();
        final int idx = alarms.indexWhere((element) => element.id == id);
        if (idx == -1) return;

        alarms.removeAt(idx);
        emit(AlarmsState.loaded(alarmModels: alarms));
        await _alarmManager.deleteAlarm(id);
      },
    );
  }
}
