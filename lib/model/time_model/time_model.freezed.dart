// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TimeModel _$TimeModelFromJson(Map<String, dynamic> json) {
  return _TimeModel.fromJson(json);
}

/// @nodoc
mixin _$TimeModel {
  int get hour => throw _privateConstructorUsedError;
  int get minute => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimeModelCopyWith<TimeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeModelCopyWith<$Res> {
  factory $TimeModelCopyWith(TimeModel value, $Res Function(TimeModel) then) =
      _$TimeModelCopyWithImpl<$Res, TimeModel>;
  @useResult
  $Res call({int hour, int minute});
}

/// @nodoc
class _$TimeModelCopyWithImpl<$Res, $Val extends TimeModel>
    implements $TimeModelCopyWith<$Res> {
  _$TimeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hour = null,
    Object? minute = null,
  }) {
    return _then(_value.copyWith(
      hour: null == hour
          ? _value.hour
          : hour // ignore: cast_nullable_to_non_nullable
              as int,
      minute: null == minute
          ? _value.minute
          : minute // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimeModelImplCopyWith<$Res>
    implements $TimeModelCopyWith<$Res> {
  factory _$$TimeModelImplCopyWith(
          _$TimeModelImpl value, $Res Function(_$TimeModelImpl) then) =
      __$$TimeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int hour, int minute});
}

/// @nodoc
class __$$TimeModelImplCopyWithImpl<$Res>
    extends _$TimeModelCopyWithImpl<$Res, _$TimeModelImpl>
    implements _$$TimeModelImplCopyWith<$Res> {
  __$$TimeModelImplCopyWithImpl(
      _$TimeModelImpl _value, $Res Function(_$TimeModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hour = null,
    Object? minute = null,
  }) {
    return _then(_$TimeModelImpl(
      hour: null == hour
          ? _value.hour
          : hour // ignore: cast_nullable_to_non_nullable
              as int,
      minute: null == minute
          ? _value.minute
          : minute // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$TimeModelImpl implements _TimeModel {
  const _$TimeModelImpl({required this.hour, required this.minute});

  factory _$TimeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimeModelImplFromJson(json);

  @override
  final int hour;
  @override
  final int minute;

  @override
  String toString() {
    return 'TimeModel(hour: $hour, minute: $minute)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeModelImpl &&
            (identical(other.hour, hour) || other.hour == hour) &&
            (identical(other.minute, minute) || other.minute == minute));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, hour, minute);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeModelImplCopyWith<_$TimeModelImpl> get copyWith =>
      __$$TimeModelImplCopyWithImpl<_$TimeModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimeModelImplToJson(
      this,
    );
  }
}

abstract class _TimeModel implements TimeModel {
  const factory _TimeModel(
      {required final int hour, required final int minute}) = _$TimeModelImpl;

  factory _TimeModel.fromJson(Map<String, dynamic> json) =
      _$TimeModelImpl.fromJson;

  @override
  int get hour;
  @override
  int get minute;
  @override
  @JsonKey(ignore: true)
  _$$TimeModelImplCopyWith<_$TimeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
