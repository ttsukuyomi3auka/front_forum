import 'package:flutter/material.dart';
import 'package:front_forum/app/models/user/user.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => Center(
                child: controller.user.value.when(
              loading: () => const CircularProgressIndicator(),
              success: (User data) {
                return Column(
                  children: [
                    Text(data.username),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(data.name),
                  ],
                );
              },
              failed: (er, obj) => Text(
                er.toString(),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                    color: Colors.red),
              ),
            ))));
  }
}
