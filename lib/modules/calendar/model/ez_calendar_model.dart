import 'package:freezed_annotation/freezed_annotation.dart';

part 'ez_calendar_model.freezed.dart';
part 'ez_calendar_model.g.dart';

@freezed
class EzCalendarEvent with _$EzCalendarEvent {
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory EzCalendarEvent({
    required int id,
    required String title,
    required String subtitle,
    required DateTime dateTime,
    @Default(false) bool allDay,
    @Default(false) bool done,
    @Default(false) bool archive,
  }) = _EzCalendarEvent;

  factory EzCalendarEvent.fromJson(Map<String, Object?> json) => _$EzCalendarEventFromJson(json);

  const EzCalendarEvent._();
}
