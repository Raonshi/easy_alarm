import 'package:freezed_annotation/freezed_annotation.dart';

part 'alarm_entity.freezed.dart';
part 'alarm_entity.g.dart';

@freezed
class AlarmEntity with _$AlarmEntity {
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory AlarmEntity({
    required int id,
    @Default("알람") String title,
    @Default("") String content,
    required bool isAm,
    required int timestamp,
    required List<int> weekdays,
    int? snoozeDuration,
    @Default(true) bool isEnabled,
  }) = _AlarmEntity;

  factory AlarmEntity.fromJson(Map<String, Object?> json) => _$AlarmEntityFromJson(json);

  const AlarmEntity._();

  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(timestamp);

  String get timeString {
    final String hour = dateTime.hour.toString().padLeft(2, "0");
    final String minute = dateTime.minute.toString().padLeft(2, "0");
    return "$hour:$minute";
  }

  String get snoozeString {
    if (snoozeDuration == null) {
      return "안 함";
    } else {
      final String minute = (snoozeDuration! ~/ 60).toString().padLeft(2, "0");
      final String second = (snoozeDuration! % 60).toString().padLeft(2, "0");
      return "$minute:$second";
    }
  }
}