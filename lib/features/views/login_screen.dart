import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_ifma_ticket/core/services/providers.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_text_styles.dart';
import 'package:project_ifma_ticket/features/resources/widgets/app_logo.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_button_widget.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_text_field.dart';
import 'package:project_ifma_ticket/features/views/home_screen.dart';



class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final controller = ref.watch(loginProvider);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const AppLogo(),
                Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Text(
                    "Entre para continuar",
                    style: TextStyle(fontSize: 16.sp, color: AppColors.gray400),
                  ),
                ),
                Form(
                    child: Column(
                  children: [
                    const CommonTextField(
                      title: 'Matrícula',
                      labelText: 'Digite sua matrícula',
                      textInputAction: TextInputAction.next,
                    ),
                    const CommonTextField(
                      title: 'Senha (SUAP)',
                      labelText: 'Digite sua senha',
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: CommomButton(
                            label: "Entrar na conta",
                            onPressed: () => controller.onLoginTap())),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
