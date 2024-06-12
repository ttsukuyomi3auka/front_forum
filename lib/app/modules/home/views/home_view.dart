import 'package:flutter/material.dart';
import 'package:front_forum/app/constants.dart';
import 'package:front_forum/app/models/post/post.dart';
import 'package:front_forum/app/models/user/user.dart';
import 'package:front_forum/app/repositories/post_repository.dart';
import 'package:front_forum/app/routes/app_pages.dart';
import 'package:front_forum/app/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Смысл'),
          actions: [
            Row(
              children: [
                Obx(() {
                  if (AuthService.to.isLoggedIn() &&
                          controller.currentUser.value?.role == Roles.admin ||
                      controller.currentUser.value?.role == Roles.moderator) {
                    return ElevatedButton(
                        onPressed: () {
                          Get.offAndToNamed(Routes.MODERATION);
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
                          "Модерация",
                          style: TextStyle(
                              color: Colors.orange[400], fontSize: 14),
                        ));
                  } else {
                    return const SizedBox();
                  }
                }),
                const SizedBox(
                  width: 20,
                ),
                const Icon(
                  Icons.edit_document,
                  size: 16,
                ),
                const SizedBox(
                  width: 3,
                ),
                GestureDetector(
                  onTap: () {
                    controller.goToCreatePost();
                  },
                  child: const MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Text(
                      "Написать пост",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              width: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: AuthService.to.isLoggedIn()
                  ? Obx(() {
                      var user = controller.currentUser.value;

                      if (user != null) {
                        return ElevatedButton(
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
                            user.username,
                            style: TextStyle(
                                color: Colors.orange[400], fontSize: 14),
                          ),
                        );
                      } else {
                        return const CircularProgressIndicator(
                          color: Colors.orange,
                        );
                      }
                    })
                  : ElevatedButton(
                      onPressed: () {
                        Get.offAndToNamed(Routes.LOGIN);
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
                        "Войти",
                        style:
                            TextStyle(color: Colors.orange[400], fontSize: 14),
                      ),
                    ),
            ),
          ],
        ),
        body: Column(
          children: [
            const Center(
              child: TabBar(
                padding: EdgeInsets.only(left: 100),
                indicatorColor: Colors.orange,
                labelColor: Colors.black,
                isScrollable: true,
                tabs: [
                  Tab(text: 'Новое'),
                  Tab(text: 'Для вас'),
                  Tab(text: 'Популярное'),
                ],
              ),
            ),
            Expanded(
              child: Obx(() => TabBarView(
                    children: [
                      PostList(
                        post: controller.newPosts.value,
                      ),
                      (AuthService.to.isLoggedIn())
                          ? PostList(
                              post: controller.forYouPosts.value,
                            )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Пожалуйста зарегистируйтесь и выбирете что вас интересует",
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                  const SizedBox(height: 16.0),
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.toNamed(Routes.LOGIN);
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
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      PostList(
                        post: controller.popularPosts.value,
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class PostList extends StatelessWidget {
  final PostResponse post;

  PostList({required this.post});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: post.when(
        loading: () => const CircularProgressIndicator(
          color: Colors.orange,
        ),
        success: (List<Post> list) {
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              var item = list[index];
              var formattedDate =
                  DateFormat('yyyy-MM-dd HH:mm').format(item.date);
              return FutureBuilder<User?>(
                future: item.getAuthor,
                builder: (context, authorSnapshot) {
                  if (!authorSnapshot.hasData) {
                    return const SizedBox();
                  }
                  var author = authorSnapshot.data!;
                  var areas = item.getAreas;
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.only(
                        right: 400, left: 100, top: 8, bottom: 8),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.PROFILE,
                                  parameters: {"userId": item.author});
                            },
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Row(
                                children: [
                                  Text(
                                    "${author.surname} ${author.name}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    formattedDate,
                                    style: const TextStyle(
                                        color: Colors.black54, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.READ_POST,
                                  parameters: {"postId": item.id});
                            },
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Text(
                                item.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.description.length > 100
                                ? '${item.description.substring(0, 100)}...'
                                : item.description,
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
                                item.likes.toString(),
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
                                item.comments.length.toString(),
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
        failed: (er, obj) => Text(
          er.toString(),
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 40.0, color: Colors.red),
        ),
      ),
    );
  }
}
