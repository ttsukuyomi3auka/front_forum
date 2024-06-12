import 'package:flutter/material.dart';
import 'package:front_forum/app/modules/widgets/custom_app_bar.dart';

import 'package:get/get.dart';

import '../controllers/read_post_controller.dart';

class ReadPostView extends GetView<ReadPostController> {
  const ReadPostView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        child: Text(
          controller.postId,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
