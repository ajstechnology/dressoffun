import 'package:dress_the_fan/usage/app_assets.dart';
import 'package:dress_the_fan/usage/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key key, this.onTap, this.text,
  }) : super(key: key);

  final Function() onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap != null ? onTap() : "",
      child: Container(
        width: Get.width / 1.5,
        height: Get.width / 6,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppAssets.buttonBackground))),
        child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )),
      ),
    );
  }
}