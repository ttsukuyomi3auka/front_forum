import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front_forum/app/constants.dart';
import 'package:front_forum/app/models/area/area.dart';
import 'package:front_forum/app/models/comment/comment.dart';
import 'package:front_forum/app/models/post/post.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  factory User({
    required String username,
    required String password,
    required String name,
    required String surname,
    @Default("") String aboutMe,
    required Roles role,
    @Default([]) List<String> posts,
    @Default([]) List<String> comments,
    @Default([]) List<String> areas,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
