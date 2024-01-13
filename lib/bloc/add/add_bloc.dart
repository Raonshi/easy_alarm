import 'package:bloc/bloc.dart';
import 'package:easy_alarm/bloc/add/add_bloc_state.dart';
import 'package:easy_alarm/model/alarm_model/alarm_model.dart';
import 'package:easy_alarm/model/time_model/time_model.dart';

class AddBloc extends Cubit<AddBlocState> {
  AddBloc() : super(const AddBlocState.initial()) {
    _init();
  }

  void _init() async {
    emit(const AddBlocState.loading());
    await Future.delayed(const Duration(seconds: 1));
    emit(
      AddBlocState.loaded(
        alarmModel: AlarmModel(
          id: "test",
          isAm: true,
          time: TimeModel(hour: 8, minute: 0),
          snoozeTime: TimeModel(hour: 8, minute: 0),
        ),
      ),
    );
  }
}
