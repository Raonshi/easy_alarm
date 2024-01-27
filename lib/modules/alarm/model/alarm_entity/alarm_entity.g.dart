// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AlarmEntityImpl _$$AlarmEntityImplFromJson(Map<String, dynamic> json) =>
    _$AlarmEntityImpl(
      id: json['id'] as int,
      timestamp: json['timestamp'] as int,
      weekdays:
          (json['weekdays'] as List<dynamic>).map((e) => e as int).toList(),
      vibration: json['vibration'] as bool? ?? false,
      sound: $enumDecode(_$SoundAssetPathEnumMap, json['sound']),
      snoozeDuration: json['snoozeDuration'] as int?,
      isEnabled: json['isEnabled'] as bool? ?? true,
    );

Map<String, dynamic> _$$AlarmEntityImplToJson(_$AlarmEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timestamp': instance.timestamp,
      'weekdays': instance.weekdays,
      'vibration': instance.vibration,
      'sound': _$SoundAssetPathEnumMap[instance.sound]!,
      'snoozeDuration': instance.snoozeDuration,
      'isEnabled': instance.isEnabled,
    };

const _$SoundAssetPathEnumMap = {
  SoundAssetPath.defaultSound: 'defaultSound',
  SoundAssetPath.electronic: 'electronic',
  SoundAssetPath.marimbaShort: 'marimbaShort',
  SoundAssetPath.marimbaMedium: 'marimbaMedium',
  SoundAssetPath.marimbaLong: 'marimbaLong',
  SoundAssetPath.shortMelody: 'shortMelody',
  SoundAssetPath.ringtone: 'ringtone',
  SoundAssetPath.ringtoneIncomingPhone: 'ringtoneIncomingPhone',
};
