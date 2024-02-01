import 'package:easy_alarm/modules/alarm/model/alarm_entity/alarm_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ringing_state.freezed.dart';

@freezed
class RingingState with _$RingingState {
  const factory RingingState.initial() = _Initial;

  const factory RingingState.loading() = _Loading;

  const factory RingingState.error({
    required Exception exception,
  }) = _Error;

  const factory RingingState.loaded({
    required AlarmEntity alarm,
  }) = _Loaded;
}
