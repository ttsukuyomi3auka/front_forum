import 'package:flutter/material.dart';
import 'package:front_forum/app/constants.dart';
import 'package:front_forum/app/models/area/area.dart';
import 'package:front_forum/app/repositories/area_repository.dart';
import 'package:front_forum/app/repositories/post_repository.dart';
import 'package:get/get.dart';

class CreatePostController extends GetxController {
  final PostRepository postRepository;
  final AreaRepository areaRepository;
  final String username;
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  var areas = <AreaOfActivity>[].obs;
  RxList<String> selectedAreas = <String>[].obs;

  CreatePostController(this.areaRepository, this.postRepository, this.username);

  @override
  void onInit() {
    getAreas();
    super.onInit();
  }

  void getAreas() async {
    var data = await areaRepository.getAllAreas();
    data.when(
        loading: () => {},
        success: (data) => areas.value = data,
        failed: (er, mes) => {});
  }

  void createPost() async {
    ShortPost data = ShortPost(
        title: title.text, description: description.text, areas: selectedAreas);
    if (await postRepository.createPost(data)) {
      Get.snackbar("Успешно", "Пост добавлен ожидайте результатов модерации");
      clearLocalData();
    } else {
      Get.snackbar("Ошибка",
          "Обратите внимание что, все поля должны быть заполнены в том числе и сферы деятельности");
    }
  }

  @override
  void onClose() {
    clearLocalData();
    super.onClose();
  }

  void clearLocalData() {
    title.clear();
    description.clear();
    selectedAreas.clear();
  }
}
