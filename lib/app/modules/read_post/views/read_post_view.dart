import 'package:flutter/material.dart';
import 'package:front_forum/app/models/post/post.dart';
import 'package:front_forum/app/models/user/user.dart';
import 'package:front_forum/app/modules/widgets/custom_app_bar.dart';
import 'package:front_forum/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/read_post_controller.dart';

class ReadPostView extends GetView<ReadPostController> {
  const ReadPostView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      endDrawer: Drawer(
        child: CommentsPanel(controller: controller),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            right: MediaQuery.of(context).size.width / 4,
            left: MediaQuery.of(context).size.width / 4),
        child: Obx(
          () => Center(
            child: controller.post.value.when(
              loading: () => const CircularProgressIndicator(
                color: Colors.orange,
              ),
              success: (Post post) {
                var formattedDate =
                    DateFormat('yyyy-MM-dd HH:mm').format(post.date);
                return FutureBuilder<User?>(
                  future: post.getAuthor,
                  builder: (context, authorSnapshot) {
                    if (!authorSnapshot.hasData) {
                      return const SizedBox();
                    }
                    var author = authorSnapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.title,
                          style: const TextStyle(
                              fontSize: 28,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.PROFILE,
                                      parameters: {"userId": post.author});
                                  Get.delete<ReadPostController>(force: true);
                                },
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          author.surname,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          author.name,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Text(
                          formattedDate,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w300),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                controller.addLike();
                              },
                              icon: const Icon(
                                Icons.thumb_up,
                                color: Colors.orange,
                                size: 16.0,
                              ),
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              post.likes.toString(),
                              style: const TextStyle(fontSize: 14.0),
                            ),
                            const SizedBox(width: 16.0),
                            Builder(
                              builder: (context) => IconButton(
                                  onPressed: () {
                                    Scaffold.of(context).openEndDrawer();
                                  },
                                  icon: const Icon(
                                    Icons.comment,
                                    color: Colors.orange,
                                    size: 16.0,
                                  )),
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              post.comments.length.toString(),
                              style: const TextStyle(fontSize: 14.0),
                            ),
                          ],
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                              child: Text(
                            post.description,
                            textAlign: TextAlign.justify,
                          )),
                        )
                      ],
                    );
                  },
                );
              },
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
      ),
    );
  }
}

class CommentsPanel extends StatelessWidget {
  final ReadPostController controller;

  const CommentsPanel({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Комментарии',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Obx(() {
              return controller.commentsResponse.value.when(
                loading: () => const Center(
                    child: CircularProgressIndicator(
                  color: Colors.orange,
                )),
                success: (comments) => ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    var comment = comments[index];
                    var formattedDate =
                        DateFormat('yyyy-MM-dd HH:mm').format(comment.date);
                    return ListTile(
                      title: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.PROFILE,
                                parameters: {"userId": comment.author["_id"]});
                            Get.delete<ReadPostController>(force: true);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      comment.author['username'],
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    formattedDate,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(comment.data),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  //TODO логика нажатия лайка
                                },
                                icon: const Icon(
                                  Icons.thumb_up,
                                  color: Colors.orange,
                                  size: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                failed: (message, exception) => Center(
                  child: Text(
                    'Error: $message',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    cursorColor: Colors.orange,
                    controller: controller.commentController,
                    decoration: InputDecoration(
                      labelText: 'Ваш комментарий',
                      labelStyle: const TextStyle(color: Colors.green),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.orange),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (controller.canICreateComment()) {
                      controller.createComment();
                    }
                  },
                  icon: const Icon(Icons.send, color: Colors.orange),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
