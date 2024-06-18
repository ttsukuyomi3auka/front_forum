import 'package:flutter/material.dart';
import 'package:front_forum/app/modules/profile/views/its_me_widgets.dart';
import 'package:front_forum/app/modules/profile/views/not_me_widgets.dart';
import 'package:front_forum/app/routes/app_pages.dart';
import 'package:front_forum/app/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: GestureDetector(
            onTap: () {
              Get.offAndToNamed(Routes.HOME);
            },
            child: GradientText(
              'Смысл',
              style: const TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
              colors: const [
                Colors.orange,
                Colors.red,
                Colors.teal,
              ],
            ),
          ),
          actions: [
            (controller.userId == AuthService.to.userId)
                ? Padding(
                    padding: const EdgeInsets.only(right: 18),
                    child: ElevatedButton(
                        onPressed: () {
                          AuthService.to.logout();
                          Get.offAllNamed(Routes.HOME);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.all(5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                            side: const BorderSide(color: Colors.red),
                          ),
                        ),
                        child: const Text(
                          "Выйти",
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        )),
                  )
                : const SizedBox()
          ],
        ),
        body: Column(
          children: [
            const TabBar(
              indicatorColor: Colors.orange,
              labelColor: Colors.black,
              tabs: [
                Tab(text: 'Посты'),
                Tab(text: 'Обо мне'),
              ],
            ),
            (controller.userId == AuthService.to.userId)
                ? ItsMeWidget(controller)
                : NotMeWidget(controller)
          ],
        ),
      ),
    );
  }
}
