import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front_forum/app/constants.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  factory Post({
    required String title,
    required String description,
    required ReviewStatus status,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
