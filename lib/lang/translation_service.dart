import 'package:dress_the_fan/lang/en_US.dart';
import 'package:dress_the_fan/lang/ru_RU.dart';
import 'package:dress_the_fan/lang/zh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TranslationService extends Translations {
  static Locale get locale => Get.deviceLocale;
  static final fallbackLocale = Locale('en', 'US');

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en_US,
        'ru_RU': ru_RU,
        'zh': zh,
      };
}

enum TranslationServiceKeys {
  /// Intro screen
  Play,
  Settings,
  Language,
  Sound,
  Music,
  Vibro,
  Track,
  Done,
  Share,
  Restart,
  MainMenu,
}
