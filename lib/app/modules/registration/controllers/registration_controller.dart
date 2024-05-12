import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:front_forum/app/constants.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {

  
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  ShortUser user = ShortUser(username: "", password: "");
  @override
  void onInit() {
    super.onInit();
  }
}
