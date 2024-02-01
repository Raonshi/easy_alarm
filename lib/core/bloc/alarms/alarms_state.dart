import 'package:easy_alarm/modules/alarm/model/alarm_group/alarm_group.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'alarms_state.freezed.dart';

@freezed
class AlarmsState with _$AlarmsState {
  const factory AlarmsState.initial() = _Initial;
  const factory AlarmsState.loading() = _Loading;
  const factory AlarmsState.error({
    required Exception exception,
  }) = _Error;

  const factory AlarmsState.loaded({
    required List<AlarmGroup> alarms,
  }) = _Loaded;
}
