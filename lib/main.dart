import 'package:flutter/material.dart';
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
    initialRoute: Routes.LOGIN,
    getPages: AppPages.routes,
  ));
}

Future<void> initServices() async {
  await Get.putAsync(() => StorageService().init());
  await Get.putAsync(() => AuthService().init());
  await Get.putAsync(() => NetworkService().init());
}
