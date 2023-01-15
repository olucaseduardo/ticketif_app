import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';

mixin TicketTheme {
  static final ticketTheme = ThemeData(
      primaryColor: AppColors.green500,
      fontFamily: GoogleFonts.inter().fontFamily,
      scaffoldBackgroundColor: AppColors.white,
      appBarTheme: AppBarTheme(
        toolbarHeight: 78,
        elevation: 0,
        backgroundColor: AppColors.green500,
        iconTheme: const IconThemeData(color: AppColors.white),
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
          borderRadius: BorderRadius.all(Radius.circular(4)),
        )),
      )),
      checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          side: const BorderSide(color: AppColors.green800),
          fillColor: MaterialStateProperty.all(AppColors.green500)));
}
