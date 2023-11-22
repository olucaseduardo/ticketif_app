import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';

mixin TicketTheme {
  static final _errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: const BorderSide(color: AppColors.red)
  );

  static final ticketTheme = ThemeData(
    primaryColor: AppColors.green500,
    fontFamily: GoogleFonts.inter().fontFamily,
    scaffoldBackgroundColor: AppColors.white,

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.green800,
      primary: AppColors.green500,
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.green500,
    ),

    appBarTheme: const AppBarTheme(
      toolbarHeight: 78,
      elevation: 0,
      backgroundColor: AppColors.green500,
      iconTheme: IconThemeData(color: AppColors.white),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: AppColors.gray900,
      selectedColor: AppColors.green800,
      checkmarkColor: AppColors.green300,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.green500),
        elevation: MaterialStateProperty.all<double>(0),

        shape: MaterialStateProperty.all<OutlinedBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
          ),
        ),
      ),
    ),

    checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: const BorderSide(color: AppColors.green800),
        fillColor: MaterialStateProperty.all(AppColors.green500),
    ),

    inputDecorationTheme: InputDecorationTheme(
      errorBorder: _errorBorder,
      focusedErrorBorder: _errorBorder,
      errorStyle: const TextStyle(color: AppColors.red)
    ),
  );
}

extension StringExtension on String {
  String capitalizeRequest() {
    List<String> words = toLowerCase().split('-');
    for (int i = 0; i < words.length; i++) {
      String word = words[i];
      if (word.isNotEmpty) {
        words[i] = "${word[0].toUpperCase()}${word.substring(1)}";
      }
    }
    return words.join('-');
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
