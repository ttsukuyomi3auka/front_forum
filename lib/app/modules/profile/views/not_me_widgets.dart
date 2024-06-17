import 'package:flutter/material.dart';
import 'package:front_forum/app/models/user/user.dart';
import 'package:front_forum/app/modules/profile/controllers/profile_controller.dart';
import 'package:front_forum/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotMeWidget extends StatelessWidget {
  final ProfileController controller;

  const NotMeWidget(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
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
                                          arguments: [post, author]);
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
                return Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 2),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ProfileItem(
                          title: "Никнейм",
                          content: user.username,
                        ),
                        ProfileItem(
                          title: "Имя",
                          content: user.name,
                        ),
                        ProfileItem(
                          title: "Фамилия",
                          content: user.surname,
                        ),
                        ProfileItem(
                          title: "Обо мне",
                          content: user.aboutMe,
                        ),
                      ],
                    ),
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

  const ProfileItem({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
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
            child: Text(
              content,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
