import 'package:front_forum/app/repositories/user_repository.dart';
import 'package:front_forum/app/services/auth_service.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final UserRepository userRepository;
  final String userId;
  final Rx<UserResponse> user = UserResponse.loading().obs;

  ProfileController(this.userRepository, this.userId);

  @override
  void onInit() {
    fetchUser();
    super.onInit();
  }

  void fetchUser() async {
    user.value = UserResponse.loading();
    user.value = await userRepository.getUserById(userId);
  }
}
