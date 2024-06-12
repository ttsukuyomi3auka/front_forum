import 'package:front_forum/app/constants.dart';
import 'package:front_forum/app/models/post/post.dart';
import 'package:front_forum/app/models/user/user.dart';
import 'package:front_forum/app/repositories/post_repository.dart';
import 'package:front_forum/app/repositories/user_repository.dart';
import 'package:front_forum/app/routes/app_pages.dart';
import 'package:front_forum/app/services/auth_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final PostRepository postRepository;
  final UserRepository userRepository;
  final Rx<PostResponse> newPosts = PostResponse.loading().obs;
  final Rx<PostResponse> forYouPosts = PostResponse.loading().obs;
  final Rx<PostResponse> popularPosts = PostResponse.loading().obs;
  Rx<User> currentUser = AuthService.to.currentUser;
  HomeController(this.postRepository, this.userRepository);

  @override
  void onInit() {
    getUserData();
    getPosts();
    super.onInit();
  }

  void getUserData() async {
    if (AuthService.to.isLoggedIn()) {
      var response = await userRepository.getUserById(AuthService.to.userId);
      response.when(
          loading: () => {},
          success: (User data) => {currentUser.value = data},
          failed: (er, ex) => {});
    }
  }

  void getPosts() async {
    newPosts.value = PostResponse.loading();
    var response = await postRepository.getAll();

    response.when(
      loading: () {},
      success: (List<Post> list) {
        newPosts.value = PostResponse.success(list
            .where((post) => post.date
                .isAfter(DateTime.now().subtract(const Duration(days: 7))))
            .toList());
        forYouPosts.value = PostResponse.success(list
            .where((post) => post.author == AuthService.to.userId)
            .toList());
        popularPosts.value =
            PostResponse.success(list.where((post) => post.likes > 1).toList());
      },
      failed: (message, exception) {
        newPosts.value = PostResponse.failed(message, exception);
        forYouPosts.value = PostResponse.failed(message, exception);
        popularPosts.value = PostResponse.failed(message, exception);
      },
    );
  }

  // void goToCreatePost() {
  //   if (AuthService.to.currentUser.value.role == Roles.unknow) {
  //     Get.snackbar("Ошибка", "Войдите в аккаунт");
  //     return;
  //   }
  //   if (AuthService.to.currentUser.value.role == Roles.baned) {
  //     Get.snackbar("Вы забанены", "У вас не возможности написать пост");
  //     return;
  //   }
  //   Get.offAndToNamed(
  //     Routes.CREATE_POST,
  //   );
  // }
}
