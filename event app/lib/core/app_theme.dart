import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static Color lightBackgroundColor = Colors.white;
  static Color lightPrimaryColor = const Color.fromRGBO(0, 0, 0, 1);
  static Color lightAccentColor = Colors.white;

  static Color darkBackgroundColor = const Color.fromRGBO(34, 36, 39, 1);
  static Color darkPrimaryColor = Colors.black;
  static Color darkAccentColor = Colors.black;
  static String light_logo = "assets/main_light.png";
  static String dark_logo = "assets/main.png";
  static String ava = "assets/ava.png";
  static String ava_dark = "assets/ava_dark.png";
  static Color indicator_color = Color.fromRGBO(90, 90, 94, 1);

  const AppTheme._();

  static final lightTheme = ThemeData(
    textTheme: GoogleFonts.ralewayTextTheme(),
    // fontFamily: 'raleway',
    brightness: Brightness.light,
    primaryColor: lightPrimaryColor,
    backgroundColor: lightBackgroundColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: darkPrimaryColor,
    backgroundColor: darkBackgroundColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static Brightness get currentSystemBrightness =>
      SchedulerBinding.instance!.window.platformBrightness;

  static setStatusBarAndNavigationBarColors(ThemeMode themeMode) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
      systemNavigationBarIconBrightness:
          themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: themeMode == ThemeMode.light
          ? lightBackgroundColor
          : darkBackgroundColor,
      systemNavigationBarDividerColor: Colors.black,
    ));
  }
}

extension ThemeExtras on ThemeData {
  bool get dark_mode => this.brightness == Brightness.light ? false : true;
  String get logo => this.brightness == Brightness.light
      ? AppTheme.light_logo
      : AppTheme.dark_logo;

  Color get indicator_color => this.brightness == Brightness.light
      ? AppTheme.indicator_color.withOpacity(0.5)
      : AppTheme.indicator_color;

  Color get activeColor => Color.fromRGBO(135, 207, 217, 1);

  Color get switchColor =>
      this.brightness == Brightness.light ? Colors.white : Colors.black;

  Color get textPrimaryColor =>
      this.brightness == Brightness.light ? Colors.black : Colors.white;

  Color get textSecondaryColor =>
      this.brightness == Brightness.light ? Colors.white : Colors.black;

  Color get primaryBgColor =>
      this.brightness == Brightness.light ? Colors.white : Colors.black;

  Color get textFieldColor => this.brightness == Brightness.light
      ? const Color.fromRGBO(239, 239, 239, 1)
      : const Color.fromRGBO(50, 50, 53, 1);
  Color get iconColor => this.brightness == Brightness.light
      ? const Color.fromRGBO(0, 0, 0, 0.1)
      : const Color.fromRGBO(78, 80, 82, 1);

  Color get sheetColor => this.brightness == Brightness.light
      ? const Color.fromRGBO(199, 199, 199, 0.69)
      : const Color.fromRGBO(53, 56, 61, 1);

  Color get feedTextSecondaryColor => this.brightness == Brightness.light
      ? const Color.fromRGBO(34, 36, 39, 1)
      : const Color.fromRGBO(174, 174, 174, 1);

  Color get bottomNavigationBarColor => this.brightness == Brightness.light
      ? const Color.fromRGBO(0, 0, 0, 0.05)
      : const Color.fromRGBO(225, 225, 225, 0.05);

  Color get appBarIconColor => this.brightness == Brightness.light
      ? const Color.fromRGBO(50, 50, 53, 1)
      : const Color.fromRGBO(225, 225, 225, 1);

  Color get notificationListTileColor => this.brightness == Brightness.light
      ? const Color.fromRGBO(245, 245, 245, 1)
      : const Color.fromRGBO(53, 56, 61, 1);

  Color get secondaryBackgroundColor => this.brightness == Brightness.light
      ? const Color.fromRGBO(239, 239, 239, 1)
      : const Color.fromRGBO(53, 56, 61, 1);
  Color get popUpIconBackgroundColor => this.brightness == Brightness.light
      ? const Color.fromRGBO(50, 50, 53, 1)
      : const Color.fromRGBO(45, 47, 50, 1);

  Color get cardBackGroundColor => Color.fromRGBO(34, 36, 39, 1);
  Color get redColor => Color.fromRGBO(255, 0, 0, 1);

  Color get profileBottomSheetColor => this.brightness == Brightness.light
      ? const Color.fromRGBO(199, 199, 199, 0.69)
      : Color.fromRGBO(255, 255, 255, 0.05);

  String get displayProfilePicture =>
      this.brightness == Brightness.light ? AppTheme.ava : AppTheme.ava_dark;

  Color get toggleColor => this.brightness == Brightness.light
      ? Colors.black.withOpacity(0.2)
      : Color.fromRGBO(42, 45, 49, 1);
}
