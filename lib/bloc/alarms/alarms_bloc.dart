import 'package:bloc/bloc.dart';
import 'package:easy_alarm/bloc/alarms/alarms_state.dart';
import 'package:easy_alarm/core/alarm_manager.dart';

class AlarmsBloc extends Cubit<AlarmsState> {
  final AlarmManager _alarmManager = AlarmManager();

  AlarmsBloc() : super(const AlarmsState.initial()) {
    _init();
  }

  void _init() async {
    state.mapOrNull(
      initial: (state) {
        emit(const AlarmsState.loading());
        _alarmManager.loadAlarms();
        emit(AlarmsState.loaded(alarmModels: _alarmManager.cachedAlarms));
      },
    );
  }
}
