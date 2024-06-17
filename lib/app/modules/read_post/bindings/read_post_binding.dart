import 'package:front_forum/app/repositories/comment_repository.dart';
import 'package:front_forum/app/repositories/post_repository.dart';
import 'package:front_forum/app/repositories/user_repository.dart';
import 'package:get/get.dart';
import '../controllers/read_post_controller.dart';

class ReadPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReadPostController>(
      () => ReadPostController(
        UserRepository(Get.find()),
        CommentRepository(Get.find()),
        PostRepository(Get.find()),
        Get.parameters['postId']!,
      ),
    );
  }
}
