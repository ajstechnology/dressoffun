import 'package:get/get.dart';

class AppNavigation {
  static void userUnauthorized() {}

  static goBack() {
    Get.back(canPop: true);
  }
}
