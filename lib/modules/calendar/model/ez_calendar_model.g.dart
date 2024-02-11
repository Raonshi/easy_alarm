// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ez_calendar_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EzCalendarEventImpl _$$EzCalendarEventImplFromJson(
        Map<String, dynamic> json) =>
    _$EzCalendarEventImpl(
      id: json['id'] as int,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      allDay: json['allDay'] as bool? ?? false,
      done: json['done'] as bool? ?? false,
      archive: json['archive'] as bool? ?? false,
    );

Map<String, dynamic> _$$EzCalendarEventImplToJson(
        _$EzCalendarEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'dateTime': instance.dateTime.toIso8601String(),
      'allDay': instance.allDay,
      'done': instance.done,
      'archive': instance.archive,
    };
