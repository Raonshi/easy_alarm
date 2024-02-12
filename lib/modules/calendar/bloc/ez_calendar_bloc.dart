import 'package:easy_alarm/modules/calendar/bloc/ez_calendar_state.dart';
import 'package:easy_alarm/modules/calendar/model/ez_calendar_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EzCalendarBloc extends Cubit<EzCalendarState> {
  EzCalendarBloc() : super(const EzCalendarState.initial());

  void updateEvents(List<EzCalendarEvent> events) {
    emit(EzCalendarState.loaded(events: events));
  }


  void archive(int idx){
    
  }
}
