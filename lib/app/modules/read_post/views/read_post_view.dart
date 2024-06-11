import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/read_post_controller.dart';

class ReadPostView extends GetView<ReadPostController> {
  const ReadPostView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReadPostView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          controller.postId,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
