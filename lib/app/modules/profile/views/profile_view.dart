import 'package:flutter/material.dart';
import 'package:front_forum/app/models/user/user.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ProfileView'),
          centerTitle: true,
        ),
        body: Obx(() => Center(
                child: controller.user.value.when(
              loading: () => const CircularProgressIndicator(),
              success: (User data) {
                return Text(data.name);
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
