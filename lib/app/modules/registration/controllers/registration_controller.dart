import 'package:flutter/material.dart';
import 'package:front_forum/app/constants.dart';
import 'package:front_forum/app/routes/app_pages.dart';
import 'package:front_forum/app/services/auth_service.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {
  AuthService authService = Get.find();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  ShortUser user = ShortUser(username: "", password: "", name: "", surname: "");
  Rx<bool> invisible = true.obs;
  Rx<Color> textColor = Colors.black.obs;


  void registration() async {
    user.username = username.text;
    user.password = password.text;
    user.name = name.text;
    user.surname = surname.text;
    if (await authService.registration(user)) {
      Get.offAndToNamed(Routes.LOGIN);
    } else {
      Get.snackbar("Ошибка", "Не удалось зарегестрироваться");
      
    }
  }

  @override
  void onClose() {
    username.dispose();
    password.dispose();
    name.dispose();
    surname.dispose();
    super.onClose();
  }
}
