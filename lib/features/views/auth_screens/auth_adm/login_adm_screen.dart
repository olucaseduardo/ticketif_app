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
import 'package:vibration/vibration.dart';

class LoginAdmScreen extends ConsumerStatefulWidget {
  const LoginAdmScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginAdmScreen> createState() => _LoginAdmScreenState();
}

class _LoginAdmScreenState extends ConsumerState<LoginAdmScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(loginProvider).campusSelect = "";
    ref.read(loginProvider).loadPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(loginProvider);
    final usernameEC = TextEditingController();
    final passwordEC = TextEditingController();
    final nav = Navigator.of(context);
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,

              children: [
                const AppLogo(
                  adm: true,
                ),

                const Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(
                    "Entre para continuar",
                    style: AppTextStyle.titleMedium,
                  ),
                ),

                Form(
                  key: formKey,

                  child: Column(
                    children: [
                      CommonTextField(
                        title: 'Usuário',
                        labelText: 'Digite seu usuário',
                        textInputAction: TextInputAction.next,
                        controller: usernameEC,
                        validator: true,
                      ),

                      CommonTextField(
                        title: 'Senha',
                        labelText: 'Digite sua senha',
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        controller: passwordEC,
                        validator: true,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 4.0),
                              child: Text(
                                'Campus',
                                style: AppTextStyle.bodyLarge,
                              ),
                            ),

                            CommonDropDownButton(
                              items: controller.campus,
                              onChanged: (value) => controller.selectCampus(value),
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

                            final valid = formKey.currentState?.validate() ?? false;

                            if (valid && controller.campusSelect != "") {
                              controller.loading();

                              controller.isLoading
                                  ? Loader.i.showLoader()
                                  : const SizedBox.shrink();

                              await controller.onLoginAdmTap(
                                usernameEC.text,
                                passwordEC.text,
                              );

                              if (!controller.error) {
                                nav.pushNamedAndRemoveUntil(
                                    AppRouter.authCheck, (route) => false);
                              } else {
                                AppMessage.i.showError('Erro ao realizar login');
                                Loader.i.hideDialog();
                              }
                            } else if (valid && controller.campusSelect == "") {
                              AppMessage.i.showInfo("Selecione o seu campus!");
                              Vibration.vibrate(duration: 1000);
                            } 
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                TextButton(
                  onPressed: () => nav.pushNamedAndRemoveUntil(
                      AppRouter.loginRoute, (route) => false),
                  child: const Text('Login aluno'),
                ),

                Text(
                  "Versão: ${controller.packageInfo?.version.toString() ?? ''}",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
