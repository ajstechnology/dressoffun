import 'package:dress_the_fan/usage/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    Key key,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () => Get.back(canPop: false),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(AppAssets.backArrow))
          ),
        ),
      ),

    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}
