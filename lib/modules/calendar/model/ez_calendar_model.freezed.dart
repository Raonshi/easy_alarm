// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ez_calendar_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EzCalendarEvent _$EzCalendarEventFromJson(Map<String, dynamic> json) {
  return _EzCalendarEvent.fromJson(json);
}

/// @nodoc
mixin _$EzCalendarEvent {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get subtitle => throw _privateConstructorUsedError;
  DateTime get dateTime => throw _privateConstructorUsedError;
  bool get allDay => throw _privateConstructorUsedError;
  bool get done => throw _privateConstructorUsedError;
  bool get archive => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EzCalendarEventCopyWith<EzCalendarEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EzCalendarEventCopyWith<$Res> {
  factory $EzCalendarEventCopyWith(
          EzCalendarEvent value, $Res Function(EzCalendarEvent) then) =
      _$EzCalendarEventCopyWithImpl<$Res, EzCalendarEvent>;
  @useResult
  $Res call(
      {int id,
      String title,
      String subtitle,
      DateTime dateTime,
      bool allDay,
      bool done,
      bool archive});
}

/// @nodoc
class _$EzCalendarEventCopyWithImpl<$Res, $Val extends EzCalendarEvent>
    implements $EzCalendarEventCopyWith<$Res> {
  _$EzCalendarEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subtitle = null,
    Object? dateTime = null,
    Object? allDay = null,
    Object? done = null,
    Object? archive = null,
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
      subtitle: null == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      allDay: null == allDay
          ? _value.allDay
          : allDay // ignore: cast_nullable_to_non_nullable
              as bool,
      done: null == done
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as bool,
      archive: null == archive
          ? _value.archive
          : archive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EzCalendarEventImplCopyWith<$Res>
    implements $EzCalendarEventCopyWith<$Res> {
  factory _$$EzCalendarEventImplCopyWith(_$EzCalendarEventImpl value,
          $Res Function(_$EzCalendarEventImpl) then) =
      __$$EzCalendarEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String subtitle,
      DateTime dateTime,
      bool allDay,
      bool done,
      bool archive});
}

/// @nodoc
class __$$EzCalendarEventImplCopyWithImpl<$Res>
    extends _$EzCalendarEventCopyWithImpl<$Res, _$EzCalendarEventImpl>
    implements _$$EzCalendarEventImplCopyWith<$Res> {
  __$$EzCalendarEventImplCopyWithImpl(
      _$EzCalendarEventImpl _value, $Res Function(_$EzCalendarEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subtitle = null,
    Object? dateTime = null,
    Object? allDay = null,
    Object? done = null,
    Object? archive = null,
  }) {
    return _then(_$EzCalendarEventImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: null == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      allDay: null == allDay
          ? _value.allDay
          : allDay // ignore: cast_nullable_to_non_nullable
              as bool,
      done: null == done
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as bool,
      archive: null == archive
          ? _value.archive
          : archive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$EzCalendarEventImpl extends _EzCalendarEvent {
  const _$EzCalendarEventImpl(
      {required this.id,
      required this.title,
      required this.subtitle,
      required this.dateTime,
      this.allDay = false,
      this.done = false,
      this.archive = false})
      : super._();

  factory _$EzCalendarEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$EzCalendarEventImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String subtitle;
  @override
  final DateTime dateTime;
  @override
  @JsonKey()
  final bool allDay;
  @override
  @JsonKey()
  final bool done;
  @override
  @JsonKey()
  final bool archive;

  @override
  String toString() {
    return 'EzCalendarEvent(id: $id, title: $title, subtitle: $subtitle, dateTime: $dateTime, allDay: $allDay, done: $done, archive: $archive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EzCalendarEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.allDay, allDay) || other.allDay == allDay) &&
            (identical(other.done, done) || other.done == done) &&
            (identical(other.archive, archive) || other.archive == archive));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, subtitle, dateTime, allDay, done, archive);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EzCalendarEventImplCopyWith<_$EzCalendarEventImpl> get copyWith =>
      __$$EzCalendarEventImplCopyWithImpl<_$EzCalendarEventImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EzCalendarEventImplToJson(
      this,
    );
  }
}

abstract class _EzCalendarEvent extends EzCalendarEvent {
  const factory _EzCalendarEvent(
      {required final int id,
      required final String title,
      required final String subtitle,
      required final DateTime dateTime,
      final bool allDay,
      final bool done,
      final bool archive}) = _$EzCalendarEventImpl;
  const _EzCalendarEvent._() : super._();

  factory _EzCalendarEvent.fromJson(Map<String, dynamic> json) =
      _$EzCalendarEventImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get subtitle;
  @override
  DateTime get dateTime;
  @override
  bool get allDay;
  @override
  bool get done;
  @override
  bool get archive;
  @override
  @JsonKey(ignore: true)
  _$$EzCalendarEventImplCopyWith<_$EzCalendarEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
