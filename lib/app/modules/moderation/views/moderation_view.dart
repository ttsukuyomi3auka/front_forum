import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/moderation_controller.dart';

class ModerationView extends GetView<ModerationController> {
  const ModerationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ModerationView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ModerationView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
