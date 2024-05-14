import 'package:flutter/material.dart';
import 'package:front_forum/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.orange[50],
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: 500,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(60),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Добро пожаловать.",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: controller.username,
                      decoration: InputDecoration(
                        hintText: 'Имя пользователя',
                        hintStyle: const TextStyle(fontSize: 13),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 14),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(color: Colors.orange),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() => TextFormField(
                          controller: controller.password,
                          decoration: InputDecoration(
                            hintText: 'Пароль',
                            hintStyle: const TextStyle(fontSize: 13),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 14),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide:
                                  const BorderSide(color: Colors.orange),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.invisible.value =
                                    !controller.invisible.value;
                              },
                              icon: Icon(controller.invisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                          ),
                          obscureText: controller.invisible.value,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.login();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[50],
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: const Text(
                        "Войти",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Ещё нет аккаунта?"),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: TextButton(
                            style: ButtonStyle(
                              enableFeedback: false,
                              foregroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                if (states.contains(MaterialState.hovered)) {
                                  return Colors.orangeAccent[700]!;
                                }
                                return Colors.orangeAccent;
                              }),
                            ),
                            onPressed: () {
                              Get.offAndToNamed(Routes.REGISTRATION);
                            },
                            child: const Text('Зарегистрироваться'),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
