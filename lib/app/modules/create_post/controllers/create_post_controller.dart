import 'package:flutter/material.dart';
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
  List<String> idAreas = [];
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

  @override
  void onClose() {
    title.dispose();
    description.dispose();
    selectedAreas.clear();
    super.onClose();
  }
}
