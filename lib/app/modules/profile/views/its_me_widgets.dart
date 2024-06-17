import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:front_forum/app/models/user/user.dart';
import 'package:front_forum/app/modules/profile/controllers/profile_controller.dart';
import 'package:front_forum/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ItsMeWidget extends StatelessWidget {
  final ProfileController controller;

  const ItsMeWidget(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final aboutMeController = TextEditingController();
    final nameController = TextEditingController();
    final surnameController = TextEditingController();
    final areasController = TextEditingController();

    return Expanded(
      child: TabBarView(
        children: [
          Obx(() {
            return controller.userPosts.value.when(
              loading: () => const Center(
                  child: CircularProgressIndicator(
                color: Colors.orange,
              )),
              success: (posts) {
                if (posts.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "Вы не написали ещё ни одного поста.",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    var post = posts[index];
                    var formattedDate =
                        DateFormat('yyyy-MM-dd HH:mm').format(post.date);
                    return FutureBuilder<User?>(
                      future: post.getAuthor,
                      builder: (context, authorSnapshot) {
                        if (!authorSnapshot.hasData) {
                          return const SizedBox();
                        }
                        var author = authorSnapshot.data!;
                        return Padding(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width / 2),
                          child: Card(
                            elevation: 4,
                            margin: const EdgeInsets.all(10),
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(Routes.READ_POST,
                                          parameters: {"postId": post.id});
                                    },
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Row(
                                        children: [
                                          Text(
                                            post.title,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            formattedDate,
                                            style: const TextStyle(
                                                color: Colors.black54,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    post.description.length > 100
                                        ? '${post.description.substring(0, 100)}...'
                                        : post.description,
                                    style: const TextStyle(fontSize: 14.0),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.thumb_up,
                                        color: Colors.orange,
                                        size: 16.0,
                                      ),
                                      const SizedBox(width: 4.0),
                                      Text(
                                        post.likes.toString(),
                                        style: const TextStyle(fontSize: 14.0),
                                      ),
                                      const SizedBox(width: 16.0),
                                      const Icon(
                                        Icons.comment,
                                        color: Colors.orange,
                                        size: 16.0,
                                      ),
                                      const SizedBox(width: 4.0),
                                      Text(
                                        post.comments.length.toString(),
                                        style: const TextStyle(fontSize: 14.0),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
              failed: (error, stackTrace) => Center(
                child: Text(
                  error.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.red),
                ),
              ),
            );
          }),
          Obx(() {
            return controller.user.value.when(
              loading: () => const Center(
                  child: CircularProgressIndicator(
                color: Colors.orange,
              )),
              success: (user) {
                usernameController.text = user.username;
                nameController.text = user.name;
                surnameController.text = user.surname;
                aboutMeController.text = user.aboutMe;
                areasController.text =
                    user.areas.map((area) => area.title).join(', ');

                return Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 2),
                  child: Obx(
                    () {
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ProfileItem(
                                title: "Никнейм",
                                content: user.username,
                                controller: usernameController,
                                isEditable: controller.isEditable.value),
                            ProfileItem(
                                title: "Имя",
                                content: user.name,
                                controller: nameController,
                                isEditable: controller.isEditable.value),
                            ProfileItem(
                                title: "Фамилия",
                                content: user.surname,
                                controller: surnameController,
                                isEditable: controller.isEditable.value),
                            ProfileItem(
                                title: "Обо мне",
                                content: user.aboutMe,
                                controller: aboutMeController,
                                isEditable: controller.isEditable.value),
                            ProfileItem(
                              title: "Выбранные сферы",
                              content: areasController.text,
                              controller: areasController,
                              isEditable: controller.isEditable.value,
                            ),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.isEditable.toggle();
                                  //TODO Логика изменения данных юзера
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: const EdgeInsets.all(5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3),
                                    side:
                                        const BorderSide(color: Colors.orange),
                                  ),
                                ),
                                child: Text(
                                  controller.isEditable.value
                                      ? 'Сохранить'
                                      : 'Редактировать',
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
              failed: (error, stackTrace) => Center(
                child: Text(
                  error.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.red),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  final String title;
  final String content;
  final bool isEditable;
  final TextEditingController controller;

  const ProfileItem({
    super.key,
    required this.title,
    required this.content,
    required this.isEditable,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    controller.text = content;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              enabled: isEditable,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
