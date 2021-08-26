import 'dart:developer';
import 'dart:io';

import 'package:dress_the_fan/usage/app_assets.dart';
import 'package:dress_the_fan/usage/app_audio_player.dart';
import 'package:dress_the_fan/usage/app_enum.dart';
import 'package:dress_the_fan/usage/app_form_validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

class AppCommon {
  static get generalPadding => Get.width * 0.1;

  static ValueNotifier<EnumLanguage> vnFlagState = ValueNotifier(EnumLanguage.English);
  static ValueNotifier<EnumSoundState> vnSoundState = ValueNotifier(EnumSoundState.On);
  static ValueNotifier<EnumSoundState> vnMusicState = ValueNotifier(EnumSoundState.On);
  static ValueNotifier<EnumSoundState> vnVibroState = ValueNotifier(EnumSoundState.On);
  static ValueNotifier<String> vnCurrentMusicTrack = ValueNotifier(AppAssets.bgSound1);

  static updateLocale(EnumLanguage language){
    switch (language) {
      case EnumLanguage.English:
        AppCommon.vnFlagState.value = language;
        Get.updateLocale(Locale('en', 'US'));
        break;
      case EnumLanguage.Russian:
        AppCommon.vnFlagState.value = language;
        Get.updateLocale(Locale('ru', 'RU'));
        break;
      case EnumLanguage.Chines:
        AppCommon.vnFlagState.value = language;
        Get.updateLocale(Locale('zh'));
        break;
      default:
        AppCommon.vnFlagState.value = EnumLanguage.English;
        Get.updateLocale(Locale('en', 'US'));
        break;
    }
  }

  static showLoadingDialog() {
    Get.dialog(
        Container(
          height: 50,
          width: 50,
          child: Center(child: CircularProgressIndicator()),
        ),
        barrierDismissible: false);
  }

  static hideDialog() {
    Get.until((route) => !Get.isDialogOpen);
    /*if(Get.isDialogOpen){
      Get.back(canPop: false);
    }*/
  }

  /*static apiCallHandler(Function() apiCallBody) async {
    showLoadingDialog();
    try {
      await apiCallBody();
    } catch (e) {
      Fluttertoast.showToast(msg: e);
    } finally {
      hideLoadingDialog();
    }
  }*/

  static apiCallHandler(Function() apiCallBody,
      {Function() onApiCallSuccess, Function() onApiCallFail}) async {
    bool res = false;
    showLoadingDialog();
    try {
      await apiCallBody();
      res = true;
    } catch (e) {
      // Fluttertoast.showToast(msg: e.toString());
      log("apiCallHandler error - $e");
      res = false;
    } finally {
      hideDialog();
      // return res;
    }
    res ? onApiCallSuccess() : onApiCallFail();
  }

  // TODO: Modify method as per the `apiCallHandler`'s `onApiCallSuccess` & `onApiCallFail` methods
  static formButtonClick(BuildContext context, GlobalKey<FormState> _formKey,
      Function() onClickAction) {
    AppFormValidators.validateAndSave(_formKey, () {
      AppCommon.apiCallHandler(() async {
        return await onClickAction();
      });
    });
  }

  static double get screenHeight =>
      Get.height - Get.statusBarHeight - Get.bottomBarHeight;

  static textFieldKeyboardSetup() {
    print("textFieldKeyboardSetup called");
    KeyboardVisibilityNotification().addNewListener(
        /*onChange: (bool visible) {
        print("textFieldKeyboardSetup visible = $visible");
        if(!visible)
          Get.focusScope.unfocus();
      },*/
        onHide: () {
      print("textFieldKeyboardSetup onHide");
      Get.focusScope.unfocus();
    });
  }

  static vibrate(){
    if(vnVibroState.value == EnumSoundState.On)
      Vibrate.feedback(FeedbackType.success);
  }

  static playClickSound(){
    log("playClickSound state = ${vnSoundState.value}");
    if(vnSoundState.value == EnumSoundState.On) {
      AppAudioPlayer.clickSoundPlayer.seek(Duration.zero);
      AppAudioPlayer.clickSoundPlayer.play();
    }
  }
}
