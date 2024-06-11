import 'package:front_forum/app/repositories/user_repository.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(
      () => ProfileController(
        UserRepository(Get.find()),
        Get.parameters['userId']!,
      ),
    );
  }
}
