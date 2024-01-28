// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AlarmGroupImpl _$$AlarmGroupImplFromJson(Map<String, dynamic> json) =>
    _$AlarmGroupImpl(
      id: json['id'] as int,
      alarms: (json['alarms'] as List<dynamic>?)
              ?.map((e) => AlarmEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isEnabled: json['isEnabled'] as bool? ?? true,
    );

Map<String, dynamic> _$$AlarmGroupImplToJson(_$AlarmGroupImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'alarms': instance.alarms.map((e) => e.toJson()).toList(),
      'isEnabled': instance.isEnabled,
    };
