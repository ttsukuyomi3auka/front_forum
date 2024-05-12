import 'package:flutter/material.dart';
import 'package:front_forum/app/routes/app_pages.dart';
import 'package:get/get.dart';

void main() {
  initServices();
  runApp(
    GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.HOME,
        getPages: AppPages.routes,
    )
  );
}

void initServices() async{
  
}