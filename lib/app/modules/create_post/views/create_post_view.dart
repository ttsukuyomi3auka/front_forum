import 'package:flutter/material.dart';
import 'package:front_forum/app/routes/app_pages.dart';
import 'package:front_forum/app/services/auth_service.dart';
import 'package:get/get.dart';
import '../controllers/create_post_controller.dart';

class CreatePostView extends GetView<CreatePostController> {
  const CreatePostView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.offAndToNamed(Routes.HOME);
          },
        ),
        title: const Text(
          'Поделись со всеми',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () {
              controller.createPost();
            },
            child: const Text(
              "Опубликовать",
              style: TextStyle(color: Colors.green, fontSize: 16),
            ),
          ),
          const SizedBox(width: 32),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.PROFILE,
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
                controller.username,
                style: TextStyle(color: Colors.orange[400], fontSize: 14),
              ),
            ),
          ),
        ],
      ),
      body: Expanded(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: controller.title,
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    hintText: 'Название',
                    border: InputBorder.none,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: controller.description,
                  maxLines: null,
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(
                    hintText: 'Расскажи свою историю...',
                    border: InputBorder.none,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Obx(() => Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: controller.areas.map((area) {
                        return GestureDetector(
                          onTap: () {
                            if (controller.selectedAreas.contains(area.id)) {
                              controller.selectedAreas.remove(area.id);
                            } else {
                              controller.selectedAreas.add(area.id);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: controller.selectedAreas.contains(area.id)
                                  ? Colors.orange
                                  : Colors.grey[400],
                            ),
                            child: Text(
                              area.title,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
