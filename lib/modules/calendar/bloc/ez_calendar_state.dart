import 'package:easy_alarm/modules/calendar/model/ez_calendar_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ez_calendar_state.freezed.dart';

@freezed
class EzCalendarState with _$EzCalendarState {
  const factory EzCalendarState.initial() = _Initial;

  const factory EzCalendarState.loading() = _Loading;

  const factory EzCalendarState.error({
    required Exception exception,
  }) = _Error;

  const factory EzCalendarState.loaded({
    required List<EzCalendarEvent> events,
  }) = _Loaded;
}
