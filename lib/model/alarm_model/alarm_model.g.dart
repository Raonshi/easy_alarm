// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AlarmModelImpl _$$AlarmModelImplFromJson(Map<String, dynamic> json) =>
    _$AlarmModelImpl(
      id: json['id'] as String,
      isAm: json['isAm'] as bool,
      time: TimeModel.fromJson(json['time'] as Map<String, dynamic>),
      weekdays: (json['weekdays'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$WeekdayEnumMap, e))
              .toList() ??
          const [],
      snoozeTime: json['snoozeTime'] == null
          ? null
          : TimeModel.fromJson(json['snoozeTime'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AlarmModelImplToJson(_$AlarmModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isAm': instance.isAm,
      'time': instance.time.toJson(),
      'weekdays': instance.weekdays.map((e) => _$WeekdayEnumMap[e]!).toList(),
      'snoozeTime': instance.snoozeTime?.toJson(),
    };

const _$WeekdayEnumMap = {
  Weekday.sunday: 'sunday',
  Weekday.monday: 'monday',
  Weekday.tuesday: 'tuesday',
  Weekday.wednesday: 'wednesday',
  Weekday.thursday: 'thursday',
  Weekday.friday: 'friday',
  Weekday.saturday: 'saturday',
};
