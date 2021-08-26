import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppPrefs {
  static final String _keyIntro = "introSeen";

  static bool get isIntroAlreadySeen => GetStorage().read<bool>(_keyIntro) ?? false;

  static Future<void> setIntroSeen() async {
    return await GetStorage().write(_keyIntro, true);
  }
}
