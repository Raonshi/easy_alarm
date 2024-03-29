import 'package:easy_alarm/modules/alarm/model/alarm_group/alarm_group.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_state.freezed.dart';

@freezed
class AddState with _$AddState {
  const factory AddState.initial() = _Initial;

  const factory AddState.loading() = _Loading;

  const factory AddState.error({
    required Exception exception,
  }) = _Error;

  const factory AddState.loaded({
    required AlarmGroup alarmGroup,
    @Default([]) List<int> selectedWeekdays,
  }) = _Loaded;
}
