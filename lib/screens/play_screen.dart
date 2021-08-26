import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dress_the_fan/usage/app_assets.dart';
import 'package:dress_the_fan/usage/app_audio_player.dart';
import 'package:dress_the_fan/usage/app_colors.dart';
import 'package:dress_the_fan/usage/app_common.dart';
import 'package:dress_the_fan/usage/app_permission_handler.dart';
import 'package:dress_the_fan/usage/app_strings.dart';
import 'package:dress_the_fan/widgets/app_button.dart';
import 'package:dress_the_fan/widgets/my_app_bar.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

class PlayScreen extends StatefulWidget {
  PlayScreen({Key key}) : super(key: key);

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen>{
  ValueNotifier vnCap = ValueNotifier("");
  ValueNotifier vnTShirt = ValueNotifier("");
  ValueNotifier vnShorts = ValueNotifier("");
  ValueNotifier vnShoes = ValueNotifier("");
  ValueNotifier vnIsGameOver = ValueNotifier(false);

  ValueNotifier vnOnShareClicked = ValueNotifier(false);
  ValueNotifier vnOnDoneClicked = ValueNotifier(false);
  ValueNotifier vnIsCaptureImageClicked = ValueNotifier(false);

  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    vnCap.addListener(() => checkGameFinishedOrNot());
    vnTShirt.addListener(() => checkGameFinishedOrNot());
    vnShorts.addListener(() => checkGameFinishedOrNot());
    vnShoes.addListener(() => checkGameFinishedOrNot());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MyAppBar(),
      body: Screenshot(
        controller: screenshotController,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.background),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onDoubleTap: () => unClothModel(),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset("assets/images/naked_model.png"),
                          ValueListenableBuilder(
                            valueListenable: vnCap,
                            builder: (context, value, child) {
                              if (value != "")
                                return Container(child: Image.asset(value));
                              else
                                return Container();
                            },
                          ),
                          ValueListenableBuilder(
                            valueListenable: vnTShirt,
                            builder: (context, value, child) {
                              if (value != "")
                                return Image.asset(value);
                              else
                                return Container();
                            },
                          ),
                          ValueListenableBuilder(
                            valueListenable: vnShorts,
                            builder: (context, value, child) {
                              if (value != "")
                                return Image.asset(value);
                              else
                                return Container();
                            },
                          ),
                          ValueListenableBuilder(
                            valueListenable: vnShoes,
                            builder: (context, value, child) {
                              if (value != "")
                                return Image.asset(value);
                              else
                                return Container();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: vnIsCaptureImageClicked,
                    builder: (context, value, child) => Opacity(opacity: value ? 0 : 1, child: child),
                    child: ValueListenableBuilder(
                      valueListenable: vnOnShareClicked,
                      builder: (context, value, child) => Visibility(
                        visible: value,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                AppPermissionHandler.checkAndRequestPermission(
                                        Permission.storage)
                                    .then((value) async {
                                  if (!value) {
                                    Fluttertoast.showToast(
                                        msg:
                                            AppStrings.storagePermissionIsRequired);
                                    return;
                                  }
                                  try {
                                    vnIsCaptureImageClicked.value = true;

                                    await screenshotController
                                        .capture(
                                            delay: const Duration(milliseconds: 10))
                                        .then((Uint8List image) async {
                                      vnIsCaptureImageClicked.value = false;
                                      if (image != null) {
                                        final directory = await getApplicationDocumentsDirectory();
                                        final imagePath = await File('${directory.path}/image.png').create();
                                        await imagePath.writeAsBytes(image);

                                        /// Share Plugin
                                        await Share.shareFiles([imagePath.path]);
                                      }
                                    }).whenComplete(() => vnIsCaptureImageClicked.value = false);
                                  } on Exception catch (e) {
                                    Fluttertoast.showToast(msg: AppStrings.somethingWentWrong);
                                  }
                                });
                              },
                              child: Container(
                                height: Get.width * 0.3,
                                width: Get.width * 0.3,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(AppAssets.buttonShare))),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                AppPermissionHandler.checkAndRequestPermission(
                                        Permission.storage)
                                    .then((value) async {
                                  if (!value) {
                                    Fluttertoast.showToast(
                                        msg:
                                            AppStrings.storagePermissionIsRequired);
                                    return;
                                  }
                                  try {
                                    String directory =
                                        await ExtStorage.getExternalStorageDirectory();
                                    String fileName = DateTime.now()
                                        .microsecondsSinceEpoch
                                        .toString();

                                    vnIsCaptureImageClicked.value = true;

                                    await screenshotController.captureAndSave(
                                        "$directory/${AppStrings.appFolderName}",
                                        fileName: "$fileName.jpg");

                                    await ImageGallerySaver.saveFile("$directory/${AppStrings.appFolderName}$fileName.jpg");

                                    vnIsCaptureImageClicked.value = false;

                                    Fluttertoast.showToast(msg: AppStrings.savedToGallery);
                                    log("Picture path = $directory/${AppStrings.appFolderName}");
                                  } on Exception catch (e) {
                                    Fluttertoast.showToast(msg: AppStrings.somethingWentWrong);
                                  }
                                });
                              },
                              child: Container(
                                height: Get.width * 0.3,
                                width: Get.width * 0.3,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage(AppAssets.buttonDownload))),
                              ),
                            ),
                          ],
                        ),
                        replacement: Column(
                          children: [
                            GameControls(
                              vnOnDoneClicked: vnOnDoneClicked,
                              vnTShirt: vnTShirt,
                              vnShorts: vnShorts,
                              vnShoes: vnShoes,
                              vnCap: vnCap,
                            ),
                            ValueListenableBuilder(
                              valueListenable: vnIsGameOver,
                              builder: (context, isGameOver, child) => Opacity(
                                opacity: isGameOver ? 1 : 0.3,
                                child: ValueListenableBuilder(
                                  valueListenable: vnOnDoneClicked,
                                  builder: (context, value, child) => Visibility(
                                    visible: value,
                                    replacement: AppButton(
                                      text: AppStrings.done,
                                      onTap: () {
                                        if (isGameOver)
                                          vnOnDoneClicked.value = true;
                                      },
                                    ),
                                    child: Column(
                                      children: [
                                        AppButton(
                                          text: AppStrings.share,
                                          onTap: () =>
                                              vnOnShareClicked.value = true,
                                        ),
                                        SizedBox(height: 5),
                                        AppButton(
                                          text: AppStrings.restart,
                                          onTap: () => unClothModel(),
                                        ),
                                        SizedBox(height: 5),
                                        AppButton(
                                          text: AppStrings.mainMenu,
                                          onTap: () => Get.back(),
                                        ),
                                      ],
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  unClothModel() {
    vnCap.value = "";
    vnTShirt.value = "";
    vnShorts.value = "";
    vnShoes.value = "";
    vnIsGameOver.value = false;
    vnOnDoneClicked.value = false;
    vnOnShareClicked.value = false;
  }

  void checkGameFinishedOrNot() {
    if (vnCap.value == "") return;
    if (vnTShirt.value == "") return;
    if (vnShorts.value == "") return;
    if (vnShoes.value == "") return;
    log("Game over");
    vnIsGameOver.value = true;
    AppCommon.vibrate();
  }
}

class GameControls extends StatelessWidget {
  const GameControls({
    Key key,
    @required this.vnOnDoneClicked,
    @required this.vnTShirt,
    @required this.vnShorts,
    @required this.vnShoes,
    @required this.vnCap,
  }) : super(key: key);

  final ValueNotifier vnOnDoneClicked;
  final ValueNotifier vnTShirt;
  final ValueNotifier vnShorts;
  final ValueNotifier vnShoes;
  final ValueNotifier vnCap;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: vnOnDoneClicked,
      builder: (context, value, child) => Visibility(
        visible: value,
        child: Container(height: 20),
        replacement: Container(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => Get.dialog(ClothDialog(
                  valueNotifier: vnTShirt,
                  clothes: [
                    "assets/images/s_tshirt1.png",
                    "assets/images/s_tshirt2.png",
                    "assets/images/s_tshirt3.png",
                    "assets/images/s_tshirt4.png",
                    "assets/images/s_tshirt5.png",
                  ],
                  clothesToSet: [
                    "assets/images/tshirt1.png",
                    "assets/images/tshirt2.png",
                    "assets/images/tshirt3.png",
                    "assets/images/tshirt4.png",
                    "assets/images/tshirt5.png",
                  ],
                )),
                child: Container(
                  height: Get.width / 5,
                  width: Get.width / 5,
                  child: Image.asset(AppAssets.buttonTShirt),
                ),
              ),
              GestureDetector(
                onTap: () => Get.dialog(ClothDialog(
                  valueNotifier: vnShorts,
                  clothes: [
                    "assets/images/s_shorts1.png",
                    "assets/images/s_shorts2.png",
                    "assets/images/s_shorts5.png",
                    "assets/images/s_shorts4.png",
                    "assets/images/s_shorts3.png",
                  ],
                  clothesToSet: [
                    "assets/images/shorts1.png",
                    "assets/images/shorts2.png",
                    "assets/images/shorts3.png",
                    "assets/images/shorts4.png",
                    "assets/images/shorts5.png",
                  ],
                )),
                child: Container(
                  height: Get.width / 5,
                  width: Get.width / 5,
                  child: Image.asset(AppAssets.buttonPant),
                ),
              ),
              GestureDetector(
                onTap: () => Get.dialog(ClothDialog(
                  valueNotifier: vnShoes,
                  clothes: [
                    "assets/images/s_shoes1.png",
                    "assets/images/s_shoes2.png",
                    "assets/images/s_shoes3.png",
                    "assets/images/s_shoes4.png",
                    "assets/images/s_shoes5.png",
                  ],
                  clothesToSet: [
                    "assets/images/shoes1.png",
                    "assets/images/shoes2.png",
                    "assets/images/shoes3.png",
                    "assets/images/shoes4.png",
                    "assets/images/shoes5.png",
                  ],
                )),
                child: Container(
                  height: Get.width / 5,
                  width: Get.width / 5,
                  child: Image.asset(AppAssets.buttonShoes),
                ),
              ),
              GestureDetector(
                onTap: () => Get.dialog(ClothDialog(
                  valueNotifier: vnCap,
                  clothes: [
                    "assets/images/s_cap1.png",
                    "assets/images/s_cap2.png",
                    "assets/images/s_cap5.png",
                    "assets/images/s_cap4.png",
                    "assets/images/s_cap3.png",
                  ],
                  clothesToSet: [
                    "assets/images/cap1.png",
                    "assets/images/cap2.png",
                    "assets/images/cap3.png",
                    "assets/images/cap4.png",
                    "assets/images/cap5.png",
                  ],
                )),
                child: Container(
                  height: Get.width / 5,
                  width: Get.width / 5,
                  child: Image.asset(AppAssets.buttonHat),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ClothDialog extends StatelessWidget {
  const ClothDialog(
      {Key key, this.clothes, this.valueNotifier, this.clothesToSet})
      : super(key: key);

  final List<String> clothes;
  final List<String> clothesToSet;
  final ValueNotifier valueNotifier;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: [
            Container(
              color: AppColors.blueBackground,
              child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  padding: EdgeInsets.all(constraints.maxWidth * 0.1),
                  mainAxisSpacing: constraints.maxWidth * 0.1,
                  crossAxisSpacing: constraints.maxWidth * 0.1,
                  children: clothes.map((String string) {
                    return GestureDetector(
                      onTap: () {
                        AppCommon.playClickSound();
                        Get.until((route) => !Get.isDialogOpen);
                        valueNotifier.value = clothesToSet[clothes.indexOf(string)];
                      },
                      child: Image.asset(string),
                    );
                  }).toList()),
            ),
            Positioned(
              right: 0,
              child: GestureDetector(
                onTap: () => Get.until((route) => !Get.isDialogOpen),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.close, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
