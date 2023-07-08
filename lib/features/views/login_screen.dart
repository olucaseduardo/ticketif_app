import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_ifma_ticket/core/services/providers.dart';
import 'package:project_ifma_ticket/core/utils/loader.dart';
import 'package:project_ifma_ticket/features/resources/routes/app_routes.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_text_styles.dart';
import 'package:project_ifma_ticket/features/resources/widgets/app_logo.dart';
import 'package:project_ifma_ticket/features/resources/widgets/app_message.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_button_widget.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_dropdown_widget.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_text_field.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final controller = ref.watch(loginProvider);
    final matriculaEC = TextEditingController();
    final passwordEC = TextEditingController();
    final nav = Navigator.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const AppLogo(),
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(
                    "Entre para continuar",
                    style: AppTextStyle.titleMedium,
                  ),
                ),
                Form(
                  child: Column(
                    children: [
                      CommonTextField(
                        title: 'Matrícula',
                        labelText: 'Digite sua matrícula',
                        textInputAction: TextInputAction.next,
                        controller: matriculaEC,
                      ),
                      CommonTextField(
                        title: 'Senha (SUAP)',
                        labelText: 'Digite sua senha',
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        controller: passwordEC,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 4.0),
                              child: Text('Campus', style: AppTextStyle.bodyLarge,),
                            ),
                            CommonDropDownButton(
                              items: const ['Caxias', 'Timon'],
                              onChanged: () {},
                              hint: 'Selecione seu campus',
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: CommonButton(
                          label: "Entrar na conta",
                          function: () async {
                            controller.loading();

                            controller.isLoading
                                ? Loader.showLoader()
                                : const SizedBox.shrink();
                            await controller.onLoginTap(
                              matriculaEC.text,
                              passwordEC.text,
                            );
                            if (!controller.error) {
                              nav.pushNamedAndRemoveUntil(
                                  AppRouter.homeRoute, (route) => false);
                            } else {
                              Loader.hideDialog();

                              AppMessage.showError('Erro ao realizar login');
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => nav.pushNamed(
                                  AppRouter.admLoginRoute),
                  child: const Text('Login administrativo'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
