import 'package:flutter/material.dart';

class AppColors {
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color red = Color(0xFFD63336);
  static const Color yellow = Color(0xFFDBBA45);
  static const Color blue = Color(0xFF3E4DB8);

  ///Green variants
  static const MaterialColor green = MaterialColor(
    _greenPrimaryValue,
    <int, Color>{
      50: Color(0xFFECF4EE),
      100: Color(0xFFD8E9DC),
      200: Color(0xFFADD6B5),
      300: Color(0xFF83C18F),
      400: Color(0xFF5AAD6A),
      500: Color(_greenPrimaryValue),
      600: Color(0xFF0E8127),
      700: Color(0xFF1A662A),
      800: Color(0xFF0F511D),
      900: Color(0xFF002E08),
    },
  );
  static const int _greenPrimaryValue = 0xFF2F9E41;

  ///Gray variants
  static const MaterialColor gray = MaterialColor(
    _grayPrimaryValue,
    <int, Color>{
      50: Color(0xFFF3F3F3),
      100: Color(0xFFE8E8E8),
      200: Color(0xFFDEDEDE),
      300: Color(0xFFBFBFBF),
      400: Color(0xFFAAAAAA),
      500: Color(_grayPrimaryValue),
      600: Color(0xFF6E6E6E),
      700: Color(0xFF585858),
      800: Color(0xFF454545),
      900: Color(0xFF303030),
    },
  );
  static const int _grayPrimaryValue = 0xFF828282;
}
