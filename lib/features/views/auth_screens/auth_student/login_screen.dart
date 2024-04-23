import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticket_ifma/core/services/providers.dart';
import 'package:ticket_ifma/core/utils/loader.dart';
import 'package:ticket_ifma/features/resources/routes/app_routes.dart';
import 'package:ticket_ifma/features/resources/theme/app_text_styles.dart';
import 'package:ticket_ifma/features/resources/widgets/app_logo.dart';
import 'package:ticket_ifma/features/resources/widgets/app_message.dart';
import 'package:ticket_ifma/features/resources/widgets/common_button_widget.dart';
import 'package:ticket_ifma/features/resources/widgets/common_dropdown_widget.dart';
import 'package:ticket_ifma/features/resources/widgets/common_text_field.dart';
import 'package:vibration/vibration.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(loginProvider).campusSelect = "";
    ref.read(loginProvider).loadPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(loginProvider);
    final matriculaEC = TextEditingController();
    final passwordEC = TextEditingController();
    final nav = Navigator.of(context);
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const AppLogo(),
                const SizedBox(height: 8),
                const Text(
                  "Entre para continuar",
                  style: AppTextStyle.titleMedium,
                ),
                const SizedBox(height: 24),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CommonTextField(
                        title: 'Matrícula',
                        labelText: 'Digite sua matrícula',
                        textInputAction: TextInputAction.next,
                        controller: matriculaEC,
                        validator: true,
                      ),
                      CommonTextField(
                        title: 'Senha (SUAP)',
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
                            const Text(
                              'Campus',
                              style: AppTextStyle.titleSmall,
                            ),
                            const SizedBox(height: 4),
                            CommonDropDownButton(
                              items: controller.campus,
                              validator: (value) =>
                                  value == null ? 'Selecione um campus' : null,
                              onChanged: (value) =>
                                  controller.selectCampus(value!),
                              hint: 'Selecione seu campus',
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: CommonButton(
                          label: "Entrar na conta",
                          function: () async {
                            final valid =
                                formKey.currentState?.validate() ?? false;

                            if (valid && controller.campusSelect != "") {
                              controller.loading();

                              controller.isLoading
                                  ? Loader.i.showLoader()
                                  : const SizedBox.shrink();

                              await controller.onLoginTap(
                                matriculaEC.text,
                                passwordEC.text,
                              );

                              if (!controller.error) {
                                nav.pushNamedAndRemoveUntil(
                                    AppRouter.homeRoute, (route) => false);
                              } else {
                                Loader.i.hideDialog();
                                AppMessage.i
                                    .showError('Erro ao realizar login');
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
                  onPressed: () => nav.pushNamed(AppRouter.admLoginRoute),
                  child: const Text('Login administrativo'),
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
