import 'package:front_forum/app/repositories/area_repository.dart';
import 'package:front_forum/app/repositories/post_repository.dart';
import 'package:get/get.dart';

import '../controllers/create_post_controller.dart';

class CreatePostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatePostController>(
      () => CreatePostController(AreaRepository(Get.find()),
          PostRepository(Get.find()), Get.parameters["username"]!),
    );
  }
}
