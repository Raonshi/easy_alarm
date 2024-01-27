// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alarm_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AlarmEntity _$AlarmEntityFromJson(Map<String, dynamic> json) {
  return _AlarmEntity.fromJson(json);
}

/// @nodoc
mixin _$AlarmEntity {
  int get id => throw _privateConstructorUsedError;
  int get timestamp => throw _privateConstructorUsedError;
  List<int> get weekdays => throw _privateConstructorUsedError;
  bool get vibration => throw _privateConstructorUsedError;
  SoundAssetPath get sound => throw _privateConstructorUsedError;
  int? get snoozeDuration => throw _privateConstructorUsedError;
  bool get isEnabled => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AlarmEntityCopyWith<AlarmEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlarmEntityCopyWith<$Res> {
  factory $AlarmEntityCopyWith(
          AlarmEntity value, $Res Function(AlarmEntity) then) =
      _$AlarmEntityCopyWithImpl<$Res, AlarmEntity>;
  @useResult
  $Res call(
      {int id,
      int timestamp,
      List<int> weekdays,
      bool vibration,
      SoundAssetPath sound,
      int? snoozeDuration,
      bool isEnabled});
}

/// @nodoc
class _$AlarmEntityCopyWithImpl<$Res, $Val extends AlarmEntity>
    implements $AlarmEntityCopyWith<$Res> {
  _$AlarmEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timestamp = null,
    Object? weekdays = null,
    Object? vibration = null,
    Object? sound = null,
    Object? snoozeDuration = freezed,
    Object? isEnabled = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      weekdays: null == weekdays
          ? _value.weekdays
          : weekdays // ignore: cast_nullable_to_non_nullable
              as List<int>,
      vibration: null == vibration
          ? _value.vibration
          : vibration // ignore: cast_nullable_to_non_nullable
              as bool,
      sound: null == sound
          ? _value.sound
          : sound // ignore: cast_nullable_to_non_nullable
              as SoundAssetPath,
      snoozeDuration: freezed == snoozeDuration
          ? _value.snoozeDuration
          : snoozeDuration // ignore: cast_nullable_to_non_nullable
              as int?,
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AlarmEntityImplCopyWith<$Res>
    implements $AlarmEntityCopyWith<$Res> {
  factory _$$AlarmEntityImplCopyWith(
          _$AlarmEntityImpl value, $Res Function(_$AlarmEntityImpl) then) =
      __$$AlarmEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int timestamp,
      List<int> weekdays,
      bool vibration,
      SoundAssetPath sound,
      int? snoozeDuration,
      bool isEnabled});
}

/// @nodoc
class __$$AlarmEntityImplCopyWithImpl<$Res>
    extends _$AlarmEntityCopyWithImpl<$Res, _$AlarmEntityImpl>
    implements _$$AlarmEntityImplCopyWith<$Res> {
  __$$AlarmEntityImplCopyWithImpl(
      _$AlarmEntityImpl _value, $Res Function(_$AlarmEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timestamp = null,
    Object? weekdays = null,
    Object? vibration = null,
    Object? sound = null,
    Object? snoozeDuration = freezed,
    Object? isEnabled = null,
  }) {
    return _then(_$AlarmEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      weekdays: null == weekdays
          ? _value._weekdays
          : weekdays // ignore: cast_nullable_to_non_nullable
              as List<int>,
      vibration: null == vibration
          ? _value.vibration
          : vibration // ignore: cast_nullable_to_non_nullable
              as bool,
      sound: null == sound
          ? _value.sound
          : sound // ignore: cast_nullable_to_non_nullable
              as SoundAssetPath,
      snoozeDuration: freezed == snoozeDuration
          ? _value.snoozeDuration
          : snoozeDuration // ignore: cast_nullable_to_non_nullable
              as int?,
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$AlarmEntityImpl extends _AlarmEntity {
  const _$AlarmEntityImpl(
      {required this.id,
      required this.timestamp,
      required final List<int> weekdays,
      this.vibration = false,
      required this.sound,
      this.snoozeDuration,
      this.isEnabled = true})
      : _weekdays = weekdays,
        super._();

  factory _$AlarmEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$AlarmEntityImplFromJson(json);

  @override
  final int id;
  @override
  final int timestamp;
  final List<int> _weekdays;
  @override
  List<int> get weekdays {
    if (_weekdays is EqualUnmodifiableListView) return _weekdays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weekdays);
  }

  @override
  @JsonKey()
  final bool vibration;
  @override
  final SoundAssetPath sound;
  @override
  final int? snoozeDuration;
  @override
  @JsonKey()
  final bool isEnabled;

  @override
  String toString() {
    return 'AlarmEntity(id: $id, timestamp: $timestamp, weekdays: $weekdays, vibration: $vibration, sound: $sound, snoozeDuration: $snoozeDuration, isEnabled: $isEnabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlarmEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality().equals(other._weekdays, _weekdays) &&
            (identical(other.vibration, vibration) ||
                other.vibration == vibration) &&
            (identical(other.sound, sound) || other.sound == sound) &&
            (identical(other.snoozeDuration, snoozeDuration) ||
                other.snoozeDuration == snoozeDuration) &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      timestamp,
      const DeepCollectionEquality().hash(_weekdays),
      vibration,
      sound,
      snoozeDuration,
      isEnabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AlarmEntityImplCopyWith<_$AlarmEntityImpl> get copyWith =>
      __$$AlarmEntityImplCopyWithImpl<_$AlarmEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AlarmEntityImplToJson(
      this,
    );
  }
}

abstract class _AlarmEntity extends AlarmEntity {
  const factory _AlarmEntity(
      {required final int id,
      required final int timestamp,
      required final List<int> weekdays,
      final bool vibration,
      required final SoundAssetPath sound,
      final int? snoozeDuration,
      final bool isEnabled}) = _$AlarmEntityImpl;
  const _AlarmEntity._() : super._();

  factory _AlarmEntity.fromJson(Map<String, dynamic> json) =
      _$AlarmEntityImpl.fromJson;

  @override
  int get id;
  @override
  int get timestamp;
  @override
  List<int> get weekdays;
  @override
  bool get vibration;
  @override
  SoundAssetPath get sound;
  @override
  int? get snoozeDuration;
  @override
  bool get isEnabled;
  @override
  @JsonKey(ignore: true)
  _$$AlarmEntityImplCopyWith<_$AlarmEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
