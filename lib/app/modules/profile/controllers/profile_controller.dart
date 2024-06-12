import 'package:front_forum/app/repositories/post_repository.dart';
import 'package:front_forum/app/repositories/user_repository.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final UserRepository userRepository;
  final PostRepository postRepository;
  final String userId;
  final Rx<UserResponse> user = UserResponse.loading().obs;
  Rx<PostResponse> userPosts = PostResponse.loading().obs;
  RxBool isEditable = false.obs;

  ProfileController(this.userRepository, this.postRepository, this.userId);

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }

  void getUserData() async {
    user.value = UserResponse.loading();
    user.value = await userRepository.getUserById(userId);
    userPosts.value = await postRepository.getUserPosts(userId);
  }
}
