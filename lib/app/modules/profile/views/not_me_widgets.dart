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
              loading: () => const Center(child: CircularProgressIndicator()),
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
                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.offAndToNamed(Routes.READ_POST,
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
              loading: () => const Center(child: CircularProgressIndicator()),
              success: (user) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Никнейм: ${user.username}',
                          style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 8),
                      const SizedBox(height: 8),
                      Text('Обо мне: ${user.aboutMe}',
                          style: const TextStyle(fontSize: 18)),
                    ],
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
