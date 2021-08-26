import 'package:flutter/material.dart';

class AppFonts {
  static final testingFont = "TestingFont";

  static final poppins = "Poppins";
  static final americanCaptain = "AmericanCaptain";
}

class AppFontWeight {
  /// Thin, the least thick
  static get thin => FontWeight.w100;

  /// Extra-light
  static get extraLight => FontWeight.w200;

  /// Light
  static get light => FontWeight.w300;

  /// Normal / regular / plain
  static get regular => FontWeight.w400;

  /// Medium
  static get medium => FontWeight.w500;

  /// Semi-bold
  static get semiBold => FontWeight.w600;

  /// Bold
  static get bold => FontWeight.w700;

  /// Extra-bold
  static get extraBold => FontWeight.w800;

  /// Black, the most thick
  static get black => FontWeight.w900;
}
