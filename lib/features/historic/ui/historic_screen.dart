import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';

class HistoricScreen extends StatelessWidget {
  const HistoricScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Voltar',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: AppColors.gray200,
            )),
        titleTextStyle: const TextStyle(color: AppColors.gray200),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.gray200,
      ),
      body: Center(),
    );
  }
}
