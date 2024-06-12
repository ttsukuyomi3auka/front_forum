import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:front_forum/app/models/user/user.dart';
import 'package:front_forum/app/modules/profile/views/its_me_widgets.dart';
import 'package:front_forum/app/modules/profile/views/not_me_widgets.dart';
import 'package:front_forum/app/routes/app_pages.dart';
import 'package:front_forum/app/services/auth_service.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Профиль'),
        ),
        body: Column(
          children: [
            const TabBar(
              indicatorColor: Colors.orange,
              labelColor: Colors.black,
              tabs: [
                Tab(text: 'Посты'),
                Tab(text: 'Обо мне'),
              ],
            ),
            (controller.userId == AuthService.to.userId)
                ? ItsMeWidget(controller)
                : NotMeWidget(controller)
          ],
        ),
      ),
    );
  }
}
