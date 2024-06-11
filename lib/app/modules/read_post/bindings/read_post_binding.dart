import 'package:get/get.dart';

import '../controllers/read_post_controller.dart';

class ReadPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReadPostController>(
      () => ReadPostController(Get.parameters["postId"]!),
    );
  }
}
