import 'package:bloc/bloc.dart';
import 'package:easy_alarm/bloc/alarms/alarms_state.dart';

class AlarmsCubit extends Cubit<AlarmsState> {
  AlarmsCubit() : super(const AlarmsState.initial());
}
