import 'package:flutter/material.dart';
import 'package:front_forum/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Get.offAndToNamed(Routes.LOGIN);
              },
              child: const Text("back")),
          ElevatedButton(
              onPressed: () {
                Get.offAndToNamed(Routes.PROFILE);
              },
              child: const Text("PROFILE"))
        ],
      )),
    );
  }
}
