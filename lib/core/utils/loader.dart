import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:project_ifma_ticket/features/app/app.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';

class Loader {
  static void showLoader() {
    showDialog(
      context: navigatorKey.currentState!.context,
      builder: (context) => loader(),
    );
  }

  static Widget loader() {
    return Center(
      child: LoadingAnimationWidget.twistingDots(
        leftDotColor: AppColors.green500,
        rightDotColor: AppColors.red,
        size: 60,
      ),
    );
  }
}
