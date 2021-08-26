import 'package:dress_the_fan/lang/translation_service.dart';
import 'package:get/get.dart';

class AppStrings {
  static final String testUserId = "459954";
  static final String appName = "Dress the Fan";
  static final String appFolderName = "Dress the Fan/";

  /// Intro screen
  static String get play => TranslationServiceKeys.Play.toString().tr;
  static String get settings => TranslationServiceKeys.Settings.toString().tr;
  static String get language => TranslationServiceKeys.Language.toString().tr;
  static String get sound => TranslationServiceKeys.Sound.toString().tr;
  static String get music => TranslationServiceKeys.Music.toString().tr;
  static String get vibro => TranslationServiceKeys.Vibro.toString().tr;
  static String get track => TranslationServiceKeys.Track.toString().tr;
  static String get done => TranslationServiceKeys.Done.toString().tr;
  static String get share => TranslationServiceKeys.Share.toString().tr;
  static String get restart => TranslationServiceKeys.Restart.toString().tr;
  static String get mainMenu => TranslationServiceKeys.MainMenu.toString().tr;

  static String storagePermissionIsRequired = "Storage permission is required to use this feature";
  static String somethingWentWrong = "Oops... Something went wrong";
  static String savedToGallery = "Image saved to gallery";
}
