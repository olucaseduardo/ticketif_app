import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';

mixin TicketTheme {
  static final _errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.red));

  static final ticketTheme = ThemeData(
    useMaterial3: false,
    primaryColor: AppColors.green,
    scaffoldBackgroundColor: AppColors.white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.green[800]!,
      primary: AppColors.green,
    ),
    fontFamily: "OpenSans",
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.green,
    ),
    appBarTheme: const AppBarTheme(
      toolbarHeight: 78,
      elevation: 0,
      backgroundColor: AppColors.green,
      iconTheme: IconThemeData(color: AppColors.white),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.gray[200],
      selectedColor: AppColors.green[300],
      checkmarkColor: AppColors.green[700],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.green),
        elevation: MaterialStateProperty.all<double>(0),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
      ),
    ),
    dividerColor: AppColors.gray[400],
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      side: BorderSide(color: AppColors.gray[400]!),
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return AppColors.gray[300];
        }
        if (states.contains(MaterialState.selected)) {
          return AppColors.green;
        }
        return AppColors.white;
      }),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      errorBorder: _errorBorder,
      focusedErrorBorder: _errorBorder,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: AppColors.green,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: AppColors.gray[300]!,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: AppColors.gray[300]!,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: AppColors.gray[300]!,
        ),
      ),
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
