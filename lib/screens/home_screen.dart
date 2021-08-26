import 'dart:developer';

import 'package:dress_the_fan/screens/play_screen.dart';
import 'package:dress_the_fan/screens/settings_screen.dart';
import 'package:dress_the_fan/usage/app_assets.dart';
import 'package:dress_the_fan/usage/app_audio_player.dart';
import 'package:dress_the_fan/usage/app_common.dart';
import 'package:dress_the_fan/usage/app_enum.dart';
import 'package:dress_the_fan/usage/app_strings.dart';
import 'package:dress_the_fan/usage/startup/app_startup_logic.dart';
import 'package:dress_the_fan/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log("App Lifecycle changed to = ${state.toString()}");
    if (state == AppLifecycleState.paused)
      AppAudioPlayer.stopPlaying();
    else {
      if(AppCommon.vnMusicState.value == EnumSoundState.On)
        AppAudioPlayer.startPlaying();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.backgroundWithBoy),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppButton(
              text: AppStrings.play,
              onTap: () => Get.to(() => PlayScreen()),
            ),
            SizedBox(height: 30),
            AppButton(
              text: AppStrings.settings,
              onTap: () => Get.to(() => SettingScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
