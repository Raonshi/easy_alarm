// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alarm_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AlarmGroup _$AlarmGroupFromJson(Map<String, dynamic> json) {
  return _AlarmGroup.fromJson(json);
}

/// @nodoc
mixin _$AlarmGroup {
  int get id => throw _privateConstructorUsedError;
  bool get routine => throw _privateConstructorUsedError;
  List<AlarmEntity> get alarms => throw _privateConstructorUsedError;
  bool get isEnabled => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AlarmGroupCopyWith<AlarmGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlarmGroupCopyWith<$Res> {
  factory $AlarmGroupCopyWith(
          AlarmGroup value, $Res Function(AlarmGroup) then) =
      _$AlarmGroupCopyWithImpl<$Res, AlarmGroup>;
  @useResult
  $Res call({int id, bool routine, List<AlarmEntity> alarms, bool isEnabled});
}

/// @nodoc
class _$AlarmGroupCopyWithImpl<$Res, $Val extends AlarmGroup>
    implements $AlarmGroupCopyWith<$Res> {
  _$AlarmGroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? routine = null,
    Object? alarms = null,
    Object? isEnabled = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      routine: null == routine
          ? _value.routine
          : routine // ignore: cast_nullable_to_non_nullable
              as bool,
      alarms: null == alarms
          ? _value.alarms
          : alarms // ignore: cast_nullable_to_non_nullable
              as List<AlarmEntity>,
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AlarmGroupImplCopyWith<$Res>
    implements $AlarmGroupCopyWith<$Res> {
  factory _$$AlarmGroupImplCopyWith(
          _$AlarmGroupImpl value, $Res Function(_$AlarmGroupImpl) then) =
      __$$AlarmGroupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, bool routine, List<AlarmEntity> alarms, bool isEnabled});
}

/// @nodoc
class __$$AlarmGroupImplCopyWithImpl<$Res>
    extends _$AlarmGroupCopyWithImpl<$Res, _$AlarmGroupImpl>
    implements _$$AlarmGroupImplCopyWith<$Res> {
  __$$AlarmGroupImplCopyWithImpl(
      _$AlarmGroupImpl _value, $Res Function(_$AlarmGroupImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? routine = null,
    Object? alarms = null,
    Object? isEnabled = null,
  }) {
    return _then(_$AlarmGroupImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      routine: null == routine
          ? _value.routine
          : routine // ignore: cast_nullable_to_non_nullable
              as bool,
      alarms: null == alarms
          ? _value._alarms
          : alarms // ignore: cast_nullable_to_non_nullable
              as List<AlarmEntity>,
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$AlarmGroupImpl extends _AlarmGroup {
  const _$AlarmGroupImpl(
      {required this.id,
      this.routine = false,
      final List<AlarmEntity> alarms = const [],
      this.isEnabled = true})
      : _alarms = alarms,
        super._();

  factory _$AlarmGroupImpl.fromJson(Map<String, dynamic> json) =>
      _$$AlarmGroupImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final bool routine;
  final List<AlarmEntity> _alarms;
  @override
  @JsonKey()
  List<AlarmEntity> get alarms {
    if (_alarms is EqualUnmodifiableListView) return _alarms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_alarms);
  }

  @override
  @JsonKey()
  final bool isEnabled;

  @override
  String toString() {
    return 'AlarmGroup(id: $id, routine: $routine, alarms: $alarms, isEnabled: $isEnabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlarmGroupImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.routine, routine) || other.routine == routine) &&
            const DeepCollectionEquality().equals(other._alarms, _alarms) &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, routine,
      const DeepCollectionEquality().hash(_alarms), isEnabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AlarmGroupImplCopyWith<_$AlarmGroupImpl> get copyWith =>
      __$$AlarmGroupImplCopyWithImpl<_$AlarmGroupImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AlarmGroupImplToJson(
      this,
    );
  }
}

abstract class _AlarmGroup extends AlarmGroup {
  const factory _AlarmGroup(
      {required final int id,
      final bool routine,
      final List<AlarmEntity> alarms,
      final bool isEnabled}) = _$AlarmGroupImpl;
  const _AlarmGroup._() : super._();

  factory _AlarmGroup.fromJson(Map<String, dynamic> json) =
      _$AlarmGroupImpl.fromJson;

  @override
  int get id;
  @override
  bool get routine;
  @override
  List<AlarmEntity> get alarms;
  @override
  bool get isEnabled;
  @override
  @JsonKey(ignore: true)
  _$$AlarmGroupImplCopyWith<_$AlarmGroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
