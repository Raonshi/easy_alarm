// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alarm_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AlarmModel _$AlarmModelFromJson(Map<String, dynamic> json) {
  return _AlarmModel.fromJson(json);
}

/// @nodoc
mixin _$AlarmModel {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  bool get isAm => throw _privateConstructorUsedError;
  TimeModel get time => throw _privateConstructorUsedError;
  List<Weekday> get weekdays => throw _privateConstructorUsedError;
  TimeModel? get snoozeTime => throw _privateConstructorUsedError;
  bool get isEnabled => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AlarmModelCopyWith<AlarmModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlarmModelCopyWith<$Res> {
  factory $AlarmModelCopyWith(
          AlarmModel value, $Res Function(AlarmModel) then) =
      _$AlarmModelCopyWithImpl<$Res, AlarmModel>;
  @useResult
  $Res call(
      {int id,
      String title,
      String content,
      bool isAm,
      TimeModel time,
      List<Weekday> weekdays,
      TimeModel? snoozeTime,
      bool isEnabled});

  $TimeModelCopyWith<$Res> get time;
  $TimeModelCopyWith<$Res>? get snoozeTime;
}

/// @nodoc
class _$AlarmModelCopyWithImpl<$Res, $Val extends AlarmModel>
    implements $AlarmModelCopyWith<$Res> {
  _$AlarmModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? isAm = null,
    Object? time = null,
    Object? weekdays = null,
    Object? snoozeTime = freezed,
    Object? isEnabled = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      isAm: null == isAm
          ? _value.isAm
          : isAm // ignore: cast_nullable_to_non_nullable
              as bool,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as TimeModel,
      weekdays: null == weekdays
          ? _value.weekdays
          : weekdays // ignore: cast_nullable_to_non_nullable
              as List<Weekday>,
      snoozeTime: freezed == snoozeTime
          ? _value.snoozeTime
          : snoozeTime // ignore: cast_nullable_to_non_nullable
              as TimeModel?,
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TimeModelCopyWith<$Res> get time {
    return $TimeModelCopyWith<$Res>(_value.time, (value) {
      return _then(_value.copyWith(time: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TimeModelCopyWith<$Res>? get snoozeTime {
    if (_value.snoozeTime == null) {
      return null;
    }

    return $TimeModelCopyWith<$Res>(_value.snoozeTime!, (value) {
      return _then(_value.copyWith(snoozeTime: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AlarmModelImplCopyWith<$Res>
    implements $AlarmModelCopyWith<$Res> {
  factory _$$AlarmModelImplCopyWith(
          _$AlarmModelImpl value, $Res Function(_$AlarmModelImpl) then) =
      __$$AlarmModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String content,
      bool isAm,
      TimeModel time,
      List<Weekday> weekdays,
      TimeModel? snoozeTime,
      bool isEnabled});

  @override
  $TimeModelCopyWith<$Res> get time;
  @override
  $TimeModelCopyWith<$Res>? get snoozeTime;
}

/// @nodoc
class __$$AlarmModelImplCopyWithImpl<$Res>
    extends _$AlarmModelCopyWithImpl<$Res, _$AlarmModelImpl>
    implements _$$AlarmModelImplCopyWith<$Res> {
  __$$AlarmModelImplCopyWithImpl(
      _$AlarmModelImpl _value, $Res Function(_$AlarmModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? isAm = null,
    Object? time = null,
    Object? weekdays = null,
    Object? snoozeTime = freezed,
    Object? isEnabled = null,
  }) {
    return _then(_$AlarmModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      isAm: null == isAm
          ? _value.isAm
          : isAm // ignore: cast_nullable_to_non_nullable
              as bool,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as TimeModel,
      weekdays: null == weekdays
          ? _value._weekdays
          : weekdays // ignore: cast_nullable_to_non_nullable
              as List<Weekday>,
      snoozeTime: freezed == snoozeTime
          ? _value.snoozeTime
          : snoozeTime // ignore: cast_nullable_to_non_nullable
              as TimeModel?,
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$AlarmModelImpl extends _AlarmModel {
  const _$AlarmModelImpl(
      {required this.id,
      this.title = "알람",
      this.content = "",
      required this.isAm,
      required this.time,
      final List<Weekday> weekdays = const [],
      this.snoozeTime,
      this.isEnabled = true})
      : _weekdays = weekdays,
        super._();

  factory _$AlarmModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AlarmModelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String content;
  @override
  final bool isAm;
  @override
  final TimeModel time;
  final List<Weekday> _weekdays;
  @override
  @JsonKey()
  List<Weekday> get weekdays {
    if (_weekdays is EqualUnmodifiableListView) return _weekdays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weekdays);
  }

  @override
  final TimeModel? snoozeTime;
  @override
  @JsonKey()
  final bool isEnabled;

  @override
  String toString() {
    return 'AlarmModel(id: $id, title: $title, content: $content, isAm: $isAm, time: $time, weekdays: $weekdays, snoozeTime: $snoozeTime, isEnabled: $isEnabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlarmModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.isAm, isAm) || other.isAm == isAm) &&
            (identical(other.time, time) || other.time == time) &&
            const DeepCollectionEquality().equals(other._weekdays, _weekdays) &&
            (identical(other.snoozeTime, snoozeTime) ||
                other.snoozeTime == snoozeTime) &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, content, isAm, time,
      const DeepCollectionEquality().hash(_weekdays), snoozeTime, isEnabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AlarmModelImplCopyWith<_$AlarmModelImpl> get copyWith =>
      __$$AlarmModelImplCopyWithImpl<_$AlarmModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AlarmModelImplToJson(
      this,
    );
  }
}

abstract class _AlarmModel extends AlarmModel {
  const factory _AlarmModel(
      {required final int id,
      final String title,
      final String content,
      required final bool isAm,
      required final TimeModel time,
      final List<Weekday> weekdays,
      final TimeModel? snoozeTime,
      final bool isEnabled}) = _$AlarmModelImpl;
  const _AlarmModel._() : super._();

  factory _AlarmModel.fromJson(Map<String, dynamic> json) =
      _$AlarmModelImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get content;
  @override
  bool get isAm;
  @override
  TimeModel get time;
  @override
  List<Weekday> get weekdays;
  @override
  TimeModel? get snoozeTime;
  @override
  bool get isEnabled;
  @override
  @JsonKey(ignore: true)
  _$$AlarmModelImplCopyWith<_$AlarmModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
