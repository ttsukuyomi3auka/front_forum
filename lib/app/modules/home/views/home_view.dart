import 'package:flutter/material.dart';
import 'package:front_forum/app/modules/widgets/custom_app_bar.dart';
import 'package:front_forum/app/modules/widgets/post_list_widgets.dart';
import 'package:front_forum/app/modules/widgets/select_areas_widget.dart';
import 'package:front_forum/app/routes/app_pages.dart';
import 'package:front_forum/app/services/auth_service.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: Column(
          children: [
            Center(
              child: TabBar(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 10),
                indicatorColor: Colors.orange,
                labelColor: Colors.black,
                isScrollable: true,
                tabs: const [
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
                      (AuthService.to.isLoggedIn() && controller.hasAreas.value)
                          ? PostList(
                              post: controller.forYouPosts.value,
                            )
                          : (!AuthService.to.isLoggedIn())
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Пожалуйста зарегистрируйтесь и выбирете что вас интересует",
                                        style: TextStyle(fontSize: 18.0),
                                      ),
                                      const SizedBox(height: 16.0),
                                      ElevatedButton(
                                        onPressed: () {
                                          Get.offAndToNamed(Routes.LOGIN);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.orange[50],
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16, horizontal: 24),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                        ),
                                        child: const Text(
                                          "Войти",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Пожалуйста выберите интересующие вас сферы",
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    const SizedBox(height: 16.0),
                                    ElevatedButton(
                                      onPressed: () {
                                        _openSelectAreasDialog(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.orange[50],
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16, horizontal: 24),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      ),
                                      child: const Text(
                                        "Выбрать сферы",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                    ),
                                  ],
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

  void _openSelectAreasDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SelectAreas(controller.areas, controller),
        );
      },
    );
  }
}
