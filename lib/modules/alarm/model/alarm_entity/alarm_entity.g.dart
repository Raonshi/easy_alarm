// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AlarmEntityImpl _$$AlarmEntityImplFromJson(Map<String, dynamic> json) =>
    _$AlarmEntityImpl(
      id: json['id'] as int,
      title: json['title'] as String? ?? "알람",
      content: json['content'] as String? ?? "",
      isAm: json['isAm'] as bool,
      timestamp: json['timestamp'] as int,
      weekdays:
          (json['weekdays'] as List<dynamic>).map((e) => e as int).toList(),
      snoozeDuration: json['snoozeDuration'] as int?,
      isEnabled: json['isEnabled'] as bool? ?? true,
    );

Map<String, dynamic> _$$AlarmEntityImplToJson(_$AlarmEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'isAm': instance.isAm,
      'timestamp': instance.timestamp,
      'weekdays': instance.weekdays,
      'snoozeDuration': instance.snoozeDuration,
      'isEnabled': instance.isEnabled,
    };
