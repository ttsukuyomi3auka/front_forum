import 'package:flutter/material.dart';
import 'package:front_forum/app/constants.dart';
import 'package:front_forum/app/routes/app_pages.dart';
import 'package:front_forum/app/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
        Row(
          children: [
            Obx(() {
              if (AuthService.to.isLoggedIn() &&
                      AuthService.to.currentUser.value.role == Roles.admin ||
                  AuthService.to.currentUser.value.role == Roles.moderator) {
                return ElevatedButton(
                    onPressed: () {
                      Get.offAndToNamed(Routes.MODERATION);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.all(5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                        side: const BorderSide(color: Colors.orange),
                      ),
                    ),
                    child: Text(
                      "Модерация",
                      style: TextStyle(color: Colors.orange[400], fontSize: 14),
                    ));
              } else {
                return const SizedBox();
              }
            }),
            const SizedBox(
              width: 20,
            ),
            const Icon(
              Icons.edit_document,
              size: 16,
            ),
            const SizedBox(
              width: 3,
            ),
            GestureDetector(
              onTap: () {
                if (AuthService.to.currentUser.value.role == Roles.unknow) {
                  Get.snackbar("Ошибка", "Войдите в аккаунт");
                  return;
                }
                if (AuthService.to.currentUser.value.role == Roles.baned) {
                  Get.snackbar(
                      "Вы забанены", "У вас не возможности написать пост");
                  return;
                }
                Get.offAndToNamed(
                  Routes.CREATE_POST,
                );
              },
              child: const MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Text(
                  "Написать пост",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          width: 50,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: AuthService.to.isLoggedIn()
              ? Obx(() {
                  var user = AuthService.to.currentUser.value;

                  return ElevatedButton(
                    onPressed: () {
                      Get.offAndToNamed(Routes.PROFILE,
                          parameters: {"userId": AuthService.to.userId});
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.all(5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                        side: const BorderSide(color: Colors.orange),
                      ),
                    ),
                    child: Text(
                      user.username,
                      style: TextStyle(color: Colors.orange[400], fontSize: 14),
                    ),
                  );
                })
              : ElevatedButton(
                  onPressed: () {
                    Get.offAndToNamed(Routes.LOGIN);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.all(5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                      side: const BorderSide(color: Colors.orange),
                    ),
                  ),
                  child: Text(
                    "Войти",
                    style: TextStyle(color: Colors.orange[400], fontSize: 14),
                  ),
                ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
