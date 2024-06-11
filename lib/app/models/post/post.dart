import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:front_forum/app/constants.dart';
import 'package:front_forum/app/models/area/area.dart';
import 'package:front_forum/app/models/user/user.dart';
import 'package:front_forum/app/repositories/area_repository.dart';
import 'package:front_forum/app/repositories/user_repository.dart';
import 'package:get/get.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  Post._();
  factory Post({
    @JsonKey(name: '_id') required String id,
    required String title,
    required String description,
    required ReviewStatus status,
    required String author,
    required DateTime date,
    required int likes,
    required List<String> comments,
    required List<String> areas,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Future<User?> get getAuthor async {
    final userRepository = Get.find<UserRepository>();
    final response = await userRepository.getUserById(author);
    return response.when(
      loading: () => null,
      success: (user) => user,
      failed: (message, exception) => null,
    );
  }

  List<AreaOfActivity> get getAreas {
    final areaRepository = Get.find<AreaRepository>();
    List<AreaOfActivity> temp = [];
    // ignore: avoid_function_literals_in_foreach_calls
    areas.forEach((element) async {
      var response = await areaRepository.getAreaById(element);
      response.when(
        loading: () => [],
        success: (area) => temp.add(area),
        failed: (message, exception) => [],
      );
    });
    return temp;
  }
}
