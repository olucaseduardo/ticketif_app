import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:TicketIFMA/features/resources/theme/app_colors.dart';

class Loader {
  late final GlobalKey<NavigatorState> _navigatorKey;

  Loader._();

  static Loader? _instance;

  static Loader get i {
    _instance ??= Loader._();
    return _instance!;
  }

  set navigatorKey(GlobalKey<NavigatorState> key) => _navigatorKey = key;

  void showLoader() {
    showDialog(
      context: _navigatorKey.currentState!.context,
      builder: (context) => loader(),
    );
  }

  void hideDialog() {
    Navigator.pop(_navigatorKey.currentState!.context);
  }

  static Widget loader() {
    return Center(
      child: LoadingAnimationWidget.twistingDots(
        leftDotColor: AppColors.green,
        rightDotColor: AppColors.red,
        size: 60,
      ),
    );
  }
}
