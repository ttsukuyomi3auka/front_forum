// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'area.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AreaOfActivity _$AreaOfActivityFromJson(Map<String, dynamic> json) {
  return _AreaOfActivity.fromJson(json);
}

/// @nodoc
mixin _$AreaOfActivity {
  @JsonKey(name: "_id")
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AreaOfActivityCopyWith<AreaOfActivity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AreaOfActivityCopyWith<$Res> {
  factory $AreaOfActivityCopyWith(
          AreaOfActivity value, $Res Function(AreaOfActivity) then) =
      _$AreaOfActivityCopyWithImpl<$Res, AreaOfActivity>;
  @useResult
  $Res call({@JsonKey(name: "_id") String id, String title});
}

/// @nodoc
class _$AreaOfActivityCopyWithImpl<$Res, $Val extends AreaOfActivity>
    implements $AreaOfActivityCopyWith<$Res> {
  _$AreaOfActivityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AreaOfActivityImplCopyWith<$Res>
    implements $AreaOfActivityCopyWith<$Res> {
  factory _$$AreaOfActivityImplCopyWith(_$AreaOfActivityImpl value,
          $Res Function(_$AreaOfActivityImpl) then) =
      __$$AreaOfActivityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: "_id") String id, String title});
}

/// @nodoc
class __$$AreaOfActivityImplCopyWithImpl<$Res>
    extends _$AreaOfActivityCopyWithImpl<$Res, _$AreaOfActivityImpl>
    implements _$$AreaOfActivityImplCopyWith<$Res> {
  __$$AreaOfActivityImplCopyWithImpl(
      _$AreaOfActivityImpl _value, $Res Function(_$AreaOfActivityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
  }) {
    return _then(_$AreaOfActivityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AreaOfActivityImpl implements _AreaOfActivity {
  _$AreaOfActivityImpl(
      {@JsonKey(name: "_id") required this.id, required this.title});

  factory _$AreaOfActivityImpl.fromJson(Map<String, dynamic> json) =>
      _$$AreaOfActivityImplFromJson(json);

  @override
  @JsonKey(name: "_id")
  final String id;
  @override
  final String title;

  @override
  String toString() {
    return 'AreaOfActivity(id: $id, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AreaOfActivityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AreaOfActivityImplCopyWith<_$AreaOfActivityImpl> get copyWith =>
      __$$AreaOfActivityImplCopyWithImpl<_$AreaOfActivityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AreaOfActivityImplToJson(
      this,
    );
  }
}

abstract class _AreaOfActivity implements AreaOfActivity {
  factory _AreaOfActivity(
      {@JsonKey(name: "_id") required final String id,
      required final String title}) = _$AreaOfActivityImpl;

  factory _AreaOfActivity.fromJson(Map<String, dynamic> json) =
      _$AreaOfActivityImpl.fromJson;

  @override
  @JsonKey(name: "_id")
  String get id;
  @override
  String get title;
  @override
  @JsonKey(ignore: true)
  _$$AreaOfActivityImplCopyWith<_$AreaOfActivityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
