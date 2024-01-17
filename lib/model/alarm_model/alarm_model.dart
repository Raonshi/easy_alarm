// This file is "main.dart"
import 'package:easy_alarm/common/enums.dart';
import 'package:easy_alarm/model/time_model/time_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'alarm_model.freezed.dart';
part 'alarm_model.g.dart';

@freezed
class AlarmModel with _$AlarmModel {
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory AlarmModel({
    required int id,
    @Default("알람") String title,
    @Default("") String content,
    required bool isAm,
    required TimeModel time,
    @Default([]) List<Weekday> weekdays,
    TimeModel? snoozeTime,
    @Default(true) bool isEnabled,
  }) = _AlarmModel;

  factory AlarmModel.fromJson(Map<String, Object?> json) => _$AlarmModelFromJson(json);

  const AlarmModel._();

  String get timeText =>
      "${time.hour % 12}:${time.minute.toString().padLeft(2, '0')}${isAm ? "alarm.am".tr() : "alarm.pm".tr()}";

  String get snoozeTimeText {
    if (snoozeTime == null) {
      return "alarm.snoozeNone".tr();
    }

    if (snoozeTime!.hour == 0 && snoozeTime!.minute == 0) {
      return "alarm.snoozeNone".tr();
    }

    if (snoozeTime!.hour == 0 && snoozeTime!.minute != 0) {
      return "alarm.snoozeMinute".tr(args: [snoozeTime!.minute.toString()]);
    }

    if (snoozeTime!.hour != 0 && snoozeTime!.minute == 0) {
      return "alarm.snoozeHour".tr(args: [snoozeTime!.hour.toString()]);
    }

    return "alarm.snoozeHourAndMinute".tr(args: [snoozeTime!.hour.toString(), snoozeTime!.minute.toString()]);
  }
}
