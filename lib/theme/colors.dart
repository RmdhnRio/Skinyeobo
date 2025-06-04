import 'package:flutter/material.dart';

class AppColorScheme {
  static const ColorScheme lightColorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: ColorPalette.orange,
      onPrimary: ColorPalette.white,
      secondary: ColorPalette.salmon,
      onSecondary: ColorPalette.white,
      error: ColorPalette.red,
      onError: ColorPalette.onError,
      surface: ColorPalette.cream,
      onSurface: ColorPalette.black
  );

}

class ColorPalette {
  static const Color cream = Color(0xFFFCF9F1);
  static const Color orange = Color(0xFFF59C1A);
  static const Color salmon =  Color(0xFFF2907E);
  static const Color pink = Color(0xFFFFD3CB);
  static const Color white = Color(0xFFFFFFFF);
  static const Color green = Color(0xFF63BFB2);
  static const Color red = Color(0xFFFF5353);
  static const Color onError = Color(0xFF571D1C);
  static const Color black = Color(0xFF464646);
  static const Color secondary = Color(0xFF757575);
  static const Color backgroundGrey = Color(0xFFEFEFEF);
  static const Color white50 = Color.fromRGBO(255, 255, 255, 0.50);
}

class AlternativePalette {

}



