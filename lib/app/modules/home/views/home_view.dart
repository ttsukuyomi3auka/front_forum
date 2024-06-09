import 'package:flutter/material.dart';
import 'package:front_forum/app/models/post/post.dart';
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
          Obx(
            () => Center(
              child: controller.posts.value.when(
                loading: () => const CircularProgressIndicator(),
                success: (List<Post> list) => ListView.builder(
                  itemCount: list.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    var item = list[index];
                    return Card(
                      elevation: 4.0,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Text(
                          item.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.description,
                              style: const TextStyle(fontSize: 14.0),
                            ),
                            const SizedBox(height: 8.0),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                failed: (er, obj) => Text(
                  er.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0,
                      color: Colors.red),
                ),
              ),
            ),
          ),
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
