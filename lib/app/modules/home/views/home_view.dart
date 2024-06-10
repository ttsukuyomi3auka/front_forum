import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:front_forum/app/models/post/post.dart';
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
            bottom: const TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: 'Новое'),
                Tab(text: 'Для вас'),
                Tab(text: 'Популярное'),
              ],
            )),
        body: Column(
          children: [
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
                                      style: TextStyle(color: Colors.black, fontSize: 16),
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
        loading: () => const CircularProgressIndicator(),
        success: (List<Post> list) {
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              var item = list[index];
              var formattedDate =
                  DateFormat('yyyy-MM-dd HH:mm').format(item.date);
              return Card(
                elevation: 4.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
                  trailing: Text(formattedDate),
                ),
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
