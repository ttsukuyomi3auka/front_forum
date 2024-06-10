import 'package:front_forum/app/repositories/user_repository.dart';
import 'package:front_forum/app/services/auth_service.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final UserRepository userRepository;
  final Rx<UserResponse> user = UserResponse.loading().obs;

  ProfileController(this.userRepository);

  @override
  void onInit() {
    fetchUser();
    super.onInit();
  }

  void fetchUser() async {
    user.value = UserResponse.loading();
    user.value = await userRepository.getUserById(AuthService.to.userId);
  }
}
