import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Al-Qur'an App",
      initialRoute: Routes.DETAIL_SURAH,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
