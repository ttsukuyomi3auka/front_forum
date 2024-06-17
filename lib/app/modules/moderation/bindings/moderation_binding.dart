import 'package:front_forum/app/repositories/comment_repository.dart';
import 'package:front_forum/app/repositories/post_repository.dart';
import 'package:get/get.dart';

import '../controllers/moderation_controller.dart';

class ModerationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ModerationController>(
      () => ModerationController(
          CommentRepository(Get.find()), PostRepository(Get.find())),
    );
  }
}
