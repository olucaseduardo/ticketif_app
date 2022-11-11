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
        toolbarHeight: 78.h,
        elevation: 0,
        backgroundColor: AppColors.green500,
        iconTheme: const IconThemeData(color: AppColors.white),
      ));
}
