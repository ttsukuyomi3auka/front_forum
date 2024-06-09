import 'package:front_forum/app/repositories/post_repository.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(PostRepository(Get.find())),
    );
  }
}
