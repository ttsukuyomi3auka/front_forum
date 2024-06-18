import 'package:front_forum/app/models/area/area.dart';
import 'package:front_forum/app/models/post/post.dart';
import 'package:front_forum/app/models/user/user.dart';
import 'package:front_forum/app/repositories/area_repository.dart';
import 'package:front_forum/app/repositories/post_repository.dart';
import 'package:front_forum/app/repositories/user_repository.dart';
import 'package:front_forum/app/services/auth_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final PostRepository postRepository;
  final UserRepository userRepository;
  final AreaRepository areaRepository;
  final Rx<PostResponse> newPosts = PostResponse.loading().obs;
  final Rx<PostResponse> forYouPosts = PostResponse.loading().obs;
  final Rx<PostResponse> popularPosts = PostResponse.loading().obs;
  RxList<String> selectedAreas = <String>[].obs;
  RxList<AreaOfActivity> areas = <AreaOfActivity>[].obs;
  RxBool hasAreas = false.obs;

  Rx<User> currentUser = AuthService.to.currentUser;
  HomeController(this.postRepository, this.userRepository, this.areaRepository);

  @override
  void onInit() {
    getUserData();
    getPosts();
    getAreas();
    super.onInit();
  }

  void getUserData() async {
    if (AuthService.to.isLoggedIn()) {
      var response = await userRepository.getUserById(AuthService.to.userId);
      response.when(
          loading: () => {},
          success: (User data) {
            currentUser.value = data;
            hasAreas.value = currentUser.value.areas.isNotEmpty;
            selectedAreas.clear();
            currentUser.value.areas.forEach((area) {
              selectedAreas.add(area.id);
            });
          },
          failed: (er, ex) => {});
    }
  }

  void getAreas() async {
    var data = await areaRepository.getAllAreas();
    data.when(
        loading: () => {},
        success: (data) => areas.value = data,
        failed: (er, mes) => {});
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

        List<Post> forYouFilteredPosts = list
            .where((post) => post.areas
                .any((area) => currentUser.value.areas.contains(area)))
            .toList();
        forYouPosts.value = PostResponse.success(forYouFilteredPosts);
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

  void toggleSelectedArea(String areaId) {
    if (selectedAreas.contains(areaId)) {
      selectedAreas.remove(areaId);
    } else {
      selectedAreas.add(areaId);
    }
  }

  void saveAreas() async {
    if (selectedAreas.isEmpty) {
      Get.snackbar("Ошибка", "Выберите хотя бы одну сферу");
    }
    if (await userRepository.addAreasToUser(selectedAreas)) {
      getUserData();
      getPosts();
      Get.back();
    } else {
      Get.snackbar("Ошибка", "Попробуйте позже");
    }
  }
}
