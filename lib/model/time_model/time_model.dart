// This file is "main.dart"
import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_model.freezed.dart';
part 'time_model.g.dart';

@freezed
class TimeModel with _$TimeModel {
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory TimeModel({
    required int hour,
    required int minute,
  }) = _TimeModel;

  factory TimeModel.fromJson(Map<String, Object?> json)
      => _$TimeModelFromJson(json);
}