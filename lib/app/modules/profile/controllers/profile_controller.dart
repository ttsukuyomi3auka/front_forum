import 'package:flutter/material.dart';
import 'package:front_forum/app/constants.dart';
import 'package:front_forum/app/models/area/area.dart';
import 'package:front_forum/app/repositories/area_repository.dart';
import 'package:front_forum/app/repositories/post_repository.dart';
import 'package:front_forum/app/repositories/user_repository.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final UserRepository userRepository;
  final PostRepository postRepository;
  final AreaRepository areaRepository;
  final String userId;
  final Rx<UserResponse> user = UserResponse.loading().obs;
  Rx<PostResponse> userPosts = PostResponse.loading().obs;
  RxList<String> selectedAreas = <String>[].obs;
  RxList<AreaOfActivity> areas = <AreaOfActivity>[].obs;

  TextEditingController usernameController = TextEditingController();
  TextEditingController aboutMeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController areasController = TextEditingController();

  RxBool isEditable = false.obs;

  ProfileController(this.userRepository, this.postRepository,
      this.areaRepository, this.userId);

  @override
  void onInit() {
    getUserData();
    getAreas();
    super.onInit();
  }

  void getUserData() async {
    user.value = UserResponse.loading();
    user.value = await userRepository.getUserById(userId);
    userPosts.value = await postRepository.getUserPosts(userId);
  }

  void getAreas() async {
    var data = await areaRepository.getAllAreas();
    data.when(
        loading: () => {},
        success: (data) => areas.value = data,
        failed: (er, mes) => {});
  }

  void toggleSelectedArea(String areaId) {
    if (selectedAreas.contains(areaId)) {
      selectedAreas.remove(areaId);
    } else {
      selectedAreas.add(areaId);
    }
  }

  void saveAreas() async {
    print(selectedAreas);
    if (selectedAreas.isEmpty) {
      Get.snackbar("Ошибка", "Выберите хотя бы одну сферу");
    }
    if (await userRepository.addAreasToUser(selectedAreas)) {
      getUserData();
      Get.back();
    } else {
      Get.snackbar("Ошибка", "Попробуйте позже");
    }
  }

  void updateUser() async {
    UpdateUser user = UpdateUser(
        username: usernameController.text,
        name: nameController.text,
        surname: surnameController.text,
        aboutMe: aboutMeController.text);
    var response = await userRepository.updateUser(user);
    switch (response) {
      case 1:
        {
          getUserData();
          getAreas();
          break;
        }
      case 2:
        {
          Get.snackbar(
              "Ошибка", "Пользователь с таким никнеймом уже существует");
          break;
        }
      case 3:
        {
          Get.snackbar("Ошибка", "Попробуйте снова");
        }
        break;
      default:
    }
  }
}
