import 'package:flutter/material.dart';
import 'package:front_forum/app/modules/widgets/comments_moderation_list_widget.dart';
import 'package:front_forum/app/modules/widgets/moderation_app_bar.dart';
import 'package:front_forum/app/modules/widgets/post_list_widgets.dart';
import 'package:front_forum/app/modules/widgets/post_moderation_list.dart';
import 'package:get/get.dart';
import '../controllers/moderation_controller.dart';

class ModerationView extends GetView<ModerationController> {
  const ModerationView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const ModerationAppBar(),
        body: Column(
          children: [
            const TabBar(
              indicatorColor: Colors.orange,
              labelColor: Colors.black,
              tabs: [
                Tab(text: 'Посты'),
                Tab(text: 'Комментарии'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Obx(() => PostModerationList(post: controller.posts.value)),
                  Obx(() => CommentsModerationList(
                      comments: controller.comments.value)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
