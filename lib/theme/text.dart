import 'package:flutter/material.dart';
import 'colors.dart';


const String fontFamily = 'CabinetGrotesk';
class AppTextStyles {

  static const TextStyle headlineLarge = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: ColorPalette.black,
    fontFamily: fontFamily
  );
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 16.0,
    color: ColorPalette.secondary,
    fontFamily: fontFamily,
  );

  static const TextStyle bannerLarge = TextStyle(
    fontSize: 64.0,
    fontWeight: FontWeight.w900,
    color: ColorPalette.orange
  );

  static const TextStyle bannerMedium = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.w300,
    color: ColorPalette.orange
  );

  static const TextStyle signInLarge = TextStyle(
    fontSize: 48.0,
    fontWeight: FontWeight.w900,
    color: ColorPalette.orange,
    height: 1.15
  );

  static const TextStyle signInSmall = TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w400,
      color: ColorPalette.orange,
  );

  static const TextStyle signInSmallReverse = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w300,
      color: ColorPalette.white
  );

  static const TextStyle textSmall = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600
  );

  static const TextStyle greetings = TextStyle(
    fontSize: 14.0,
    color: ColorPalette.secondary
  );

  static const TextStyle productDetailName = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold
  );

  static const TextStyle productDetailDesc = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: ColorPalette.secondary
  );

}