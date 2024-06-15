// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return _Comment.fromJson(json);
}

/// @nodoc
mixin _$Comment {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get data => throw _privateConstructorUsedError;
  int get likes => throw _privateConstructorUsedError;
  ReviewStatus get status => throw _privateConstructorUsedError;
  Map<String, dynamic> get author => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String get post => throw _privateConstructorUsedError;
  List<String> get children => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommentCopyWith<Comment> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentCopyWith<$Res> {
  factory $CommentCopyWith(Comment value, $Res Function(Comment) then) =
      _$CommentCopyWithImpl<$Res, Comment>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String data,
      int likes,
      ReviewStatus status,
      Map<String, dynamic> author,
      DateTime date,
      String post,
      List<String> children});
}

/// @nodoc
class _$CommentCopyWithImpl<$Res, $Val extends Comment>
    implements $CommentCopyWith<$Res> {
  _$CommentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? data = null,
    Object? likes = null,
    Object? status = null,
    Object? author = null,
    Object? date = null,
    Object? post = null,
    Object? children = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
      likes: null == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ReviewStatus,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      post: null == post
          ? _value.post
          : post // ignore: cast_nullable_to_non_nullable
              as String,
      children: null == children
          ? _value.children
          : children // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CommentImplCopyWith<$Res> implements $CommentCopyWith<$Res> {
  factory _$$CommentImplCopyWith(
          _$CommentImpl value, $Res Function(_$CommentImpl) then) =
      __$$CommentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String data,
      int likes,
      ReviewStatus status,
      Map<String, dynamic> author,
      DateTime date,
      String post,
      List<String> children});
}

/// @nodoc
class __$$CommentImplCopyWithImpl<$Res>
    extends _$CommentCopyWithImpl<$Res, _$CommentImpl>
    implements _$$CommentImplCopyWith<$Res> {
  __$$CommentImplCopyWithImpl(
      _$CommentImpl _value, $Res Function(_$CommentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? data = null,
    Object? likes = null,
    Object? status = null,
    Object? author = null,
    Object? date = null,
    Object? post = null,
    Object? children = null,
  }) {
    return _then(_$CommentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
      likes: null == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ReviewStatus,
      author: null == author
          ? _value._author
          : author // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      post: null == post
          ? _value.post
          : post // ignore: cast_nullable_to_non_nullable
              as String,
      children: null == children
          ? _value._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CommentImpl implements _Comment {
  _$CommentImpl(
      {@JsonKey(name: '_id') required this.id,
      required this.data,
      required this.likes,
      required this.status,
      required final Map<String, dynamic> author,
      required this.date,
      required this.post,
      required final List<String> children})
      : _author = author,
        _children = children;

  factory _$CommentImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommentImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String data;
  @override
  final int likes;
  @override
  final ReviewStatus status;
  final Map<String, dynamic> _author;
  @override
  Map<String, dynamic> get author {
    if (_author is EqualUnmodifiableMapView) return _author;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_author);
  }

  @override
  final DateTime date;
  @override
  final String post;
  final List<String> _children;
  @override
  List<String> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  @override
  String toString() {
    return 'Comment(id: $id, data: $data, likes: $likes, status: $status, author: $author, date: $date, post: $post, children: $children)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.likes, likes) || other.likes == likes) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._author, _author) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.post, post) || other.post == post) &&
            const DeepCollectionEquality().equals(other._children, _children));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      data,
      likes,
      status,
      const DeepCollectionEquality().hash(_author),
      date,
      post,
      const DeepCollectionEquality().hash(_children));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentImplCopyWith<_$CommentImpl> get copyWith =>
      __$$CommentImplCopyWithImpl<_$CommentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommentImplToJson(
      this,
    );
  }
}

abstract class _Comment implements Comment {
  factory _Comment(
      {@JsonKey(name: '_id') required final String id,
      required final String data,
      required final int likes,
      required final ReviewStatus status,
      required final Map<String, dynamic> author,
      required final DateTime date,
      required final String post,
      required final List<String> children}) = _$CommentImpl;

  factory _Comment.fromJson(Map<String, dynamic> json) = _$CommentImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get data;
  @override
  int get likes;
  @override
  ReviewStatus get status;
  @override
  Map<String, dynamic> get author;
  @override
  DateTime get date;
  @override
  String get post;
  @override
  List<String> get children;
  @override
  @JsonKey(ignore: true)
  _$$CommentImplCopyWith<_$CommentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
