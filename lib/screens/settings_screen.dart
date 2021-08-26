import 'package:dress_the_fan/usage/app_assets.dart';
import 'package:dress_the_fan/usage/app_audio_player.dart';
import 'package:dress_the_fan/usage/app_colors.dart';
import 'package:dress_the_fan/usage/app_common.dart';
import 'package:dress_the_fan/usage/app_enum.dart';
import 'package:dress_the_fan/usage/app_strings.dart';
import 'package:dress_the_fan/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:outlined_text/outlined_text.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key key}) : super(key: key);

  List listOfMusics = [
    AppAssets.bgSound1,
    AppAssets.bgSound2,
    AppAssets.bgSound3,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MyAppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.background),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /*SettingControl(
                    title: AppStrings.language,
                    vnImage: AppCommon.vnSoundState,
                  ),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedText(
                        text: Text(
                          AppStrings.language,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        strokes: [
                          OutlinedTextStroke(
                              color: AppColors.textBorderBlue, width: 2),
                        ],
                      ),
                      SizedBox(width: 15),
                      ValueListenableBuilder(
                        valueListenable: AppCommon.vnFlagState,
                        builder: (context, value, child) => Container(
                          height: 30,
                          width: 50,
                          child: GestureDetector(
                            onTap: () {
                              changeLanguage(value);
                              AppCommon.updateLocale(
                                  AppCommon.vnFlagState.value);
                            },
                            child: Image.asset(getFlagImage(value)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SettingControl(
                    title: AppStrings.sound,
                    valueNotifier: AppCommon.vnSoundState,
                  ),
                  SizedBox(height: 20),
                  SettingControl(
                    title: AppStrings.music,
                    valueNotifier: AppCommon.vnMusicState,
                    onTap: () {},
                  ),
                  SizedBox(height: 20),
                  SettingControl(
                    title: AppStrings.vibro,
                    valueNotifier: AppCommon.vnVibroState,
                  ),
                  SizedBox(height: 20),
                  OutlinedText(
                    text: Text(
                      AppStrings.track,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    strokes: [
                      OutlinedTextStroke(
                          color: AppColors.textBorderBlue, width: 2),
                    ],
                  ),
                  SizedBox(height: 15),
                  Container(
                    height: 40,
                    child: ValueListenableBuilder(
                      valueListenable: AppCommon.vnCurrentMusicTrack,
                      builder: (context, value, child) => Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          listOfMusics.length,
                              (index) => MusicTrackButton(
                            text: "${index + 1}",
                            onTap: () => changeMusic(listOfMusics[index]),
                            isSelected: AppCommon.vnCurrentMusicTrack.value == listOfMusics[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  EnumLanguage changeLanguage(EnumLanguage value) {
    switch (value) {
      case EnumLanguage.Chines:
        AppCommon.vnFlagState.value = EnumLanguage.English;
        return AppCommon.vnFlagState.value;
        break;
      case EnumLanguage.English:
        AppCommon.vnFlagState.value = EnumLanguage.Russian;
        return AppCommon.vnFlagState.value;
        break;
      case EnumLanguage.Russian:
        AppCommon.vnFlagState.value = EnumLanguage.Chines;
        return AppCommon.vnFlagState.value;
        break;
      default:
        AppCommon.vnFlagState.value = EnumLanguage.English;
        return AppCommon.vnFlagState.value;
        break;
    }
  }

  String getFlagImage(EnumLanguage value) {
    switch (value) {
      case EnumLanguage.Chines:
        return "assets/images/flag_china.png";
        break;
      case EnumLanguage.English:
        return "assets/images/flag_usa.png";
        break;
      case EnumLanguage.Russian:
        return "assets/images/flag_russia.png";
        break;
      default:
        return "assets/images/flag_usa.png";
        break;
    }
  }

  changeMusic(String musicTrack) async {
    AppCommon.vnCurrentMusicTrack.value = musicTrack;
    AppAudioPlayer.changeMusicTrack(musicTrack);
  }
}

class SettingControl extends StatelessWidget {
  const SettingControl({
    Key key,
    this.title,
    this.valueNotifier,
    this.onTap,
  }) : super(key: key);

  final String title;
  final ValueNotifier valueNotifier;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedText(
          text: Text(
            title,
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          strokes: [
            OutlinedTextStroke(color: AppColors.textBorderBlue, width: 2),
          ],
        ),
        SizedBox(width: 15),
        ValueListenableBuilder(
          valueListenable: valueNotifier,
          builder: (context, value, child) => GestureDetector(
            onTap: () {
              valueNotifier.value == EnumSoundState.On
                  ? valueNotifier.value = EnumSoundState.Off
                  : valueNotifier.value = EnumSoundState.On;
              onTap != null ? onTap() : "";
            },
            child: Container(
              height: 30,
              width: 50,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(value == EnumSoundState.On
                      ? AppAssets.switchOn
                      : AppAssets.switchOff),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MusicTrackButton extends StatelessWidget {
  const MusicTrackButton({Key key, this.onTap, this.text, this.isSelected})
      : super(key: key);
  final Function() onTap;
  final String text;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 8),
        GestureDetector(
          onTap: () => onTap != null ? onTap() : "",
          child: Container(
            height: 40,
            width: 70,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(isSelected ? AppAssets.bgTrackSelected : AppAssets.bgTrackUnselected),
                    fit: BoxFit.fill)),
            child: Center(
                child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.blueBackground,
                fontWeight: FontWeight.bold,
              ),
            )),
          ),
        ),
        SizedBox(width: 8),
      ],
    );
  }
}
