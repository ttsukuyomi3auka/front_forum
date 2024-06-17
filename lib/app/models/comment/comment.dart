// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front_forum/app/constants.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
class Comment with _$Comment {
  factory Comment({
    @JsonKey(name: '_id') required String id,
    required String data,
    required int likes,
    required ReviewStatus status,
    required Map<String, dynamic> author,
    required DateTime date,
    required String post,
    required List<String> children,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}
