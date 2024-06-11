import 'package:flutter/material.dart';
import 'package:front_forum/app/constants.dart';
import 'package:front_forum/app/routes/app_pages.dart';
import 'package:front_forum/app/services/auth_service.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  AuthService authService = Get.find();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  ShortUser user = ShortUser(username: "", password: "", name: "", surname: "");
  Rx<bool> invisible = true.obs;


  void login() async {
    user.username = username.text;
    user.password = password.text;
    if (await authService.login(user)) {
      Get.offAndToNamed(Routes.HOME);
    }
    else {
      Get.snackbar("Ошибка", "Не удалось войти");
    }
  }
}
