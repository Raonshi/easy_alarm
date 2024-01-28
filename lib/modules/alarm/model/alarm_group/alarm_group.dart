import 'package:easy_alarm/modules/alarm/model/alarm_entity/alarm_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'alarm_group.freezed.dart';
part 'alarm_group.g.dart';

@freezed
class AlarmGroup with _$AlarmGroup {
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory AlarmGroup({
    required int id,
    @Default(false) routine,
    @Default([]) List<AlarmEntity> alarms,
    @Default(true) bool isEnabled,
  }) = _AlarmGroup;

  factory AlarmGroup.fromJson(Map<String, Object?> json) => _$AlarmGroupFromJson(json);

  const AlarmGroup._();

  DateTime get dateTime => alarms.first.dateTime;
  List<int> get weekdays => routine ? alarms.map((p) => p.dateTime.weekday).toSet().toList() : [];

  int? get snoozeMinute => alarms.first.snoozeDuration;
}
