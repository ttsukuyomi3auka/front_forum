import 'package:flutter/material.dart';
import 'package:front_forum/app/repositories/area_repository.dart';
import 'package:front_forum/app/repositories/post_repository.dart';
import 'package:front_forum/app/repositories/user_repository.dart';
import 'package:front_forum/app/routes/app_pages.dart';
import 'package:front_forum/app/services/auth_service.dart';
import 'package:front_forum/app/services/network_service.dart';
import 'package:front_forum/app/services/storage_service.dart';
import 'package:get/get.dart';

void main() async {
  await initServices();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.orange,
      textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.black,
          selectionColor: Colors.orange[50],
          selectionHandleColor: Colors.orange[50]),
    ),
    initialRoute: Routes.HOME,
    getPages: AppPages.routes,
  ));
}

Future<void> initServices() async {
  await Get.putAsync(() => StorageService().init());
  await Get.putAsync(() => AuthService().init());
  await Get.putAsync(() => NetworkService().init());
  Get.put(UserRepository(NetworkService.to));
  Get.put(AreaRepository(NetworkService.to));
  Get.put(PostRepository(NetworkService.to));
}
