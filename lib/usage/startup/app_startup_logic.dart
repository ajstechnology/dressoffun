import 'dart:async';
import 'dart:developer';

import 'package:dress_the_fan/screens/home_screen.dart';
import 'package:dress_the_fan/usage/app_audio_player.dart';
import 'package:dress_the_fan/usage/app_common.dart';
import 'package:dress_the_fan/usage/app_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppStartupLogic {
  static StreamSubscription _intentDataStreamSubscription;

  static Widget getStartupLogic() {
    // setupStartupControllers();
    return HomeScreen();
    // return IntroScreen();
    // return UsernameSelectionScreen();
  }

  static setupStartupControllers() {
    // Get.put<SocialController>(SocialController());
    AppAudioPlayer.initAudioPlayer();

    AppCommon.vnMusicState.addListener(() {
      if(AppCommon.vnMusicState.value == EnumSoundState.On){
        AppAudioPlayer.startPlaying();
      } else {
        AppAudioPlayer.stopPlaying();
      }
    });

    log("Device Locale = ${Get.deviceLocale.toLanguageTag()}");
    switch (Get.deviceLocale.toLanguageTag()) {
      case "en-US":
        AppCommon.updateLocale(EnumLanguage.English);
        break;
      case "ru-RU":
        AppCommon.updateLocale(EnumLanguage.Russian);
        break;
      case "zh":
        AppCommon.updateLocale(EnumLanguage.Chines);
        break;
      default:
        AppCommon.updateLocale(EnumLanguage.English);
        break;
    }
  }
}
