import 'package:get/get.dart';

import '../controllers/moderation_controller.dart';

class ModerationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ModerationController>(
      () => ModerationController(),
    );
  }
}
