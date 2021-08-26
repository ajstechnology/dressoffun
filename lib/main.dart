import 'package:dress_the_fan/lang/translation_service.dart';
import 'package:dress_the_fan/screens/home_screen.dart';
import 'package:dress_the_fan/usage/app_strings.dart';
import 'package:dress_the_fan/usage/startup/app_startup_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      locale: TranslationService.locale,
      fallbackLocale: TranslationService.fallbackLocale,
      translations: TranslationService(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        )
      ),
      onInit: () {
        AppStartupLogic.setupStartupControllers();
      },
      home: AppStartupLogic.getStartupLogic(),
    );
  }
}
