import 'package:easy_alarm/modules/alarm/model/alarm_entity/alarm_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_bloc_state.freezed.dart';

@freezed
class AddBlocState with _$AddBlocState {
  const factory AddBlocState.initial() = _Initial;

  const factory AddBlocState.loading() = _Loading;

  const factory AddBlocState.error({
    required Exception exception,
  }) = _Error;

  const factory AddBlocState.loaded({
    required AlarmEntity alarm,
  }) = _Loaded;
}
