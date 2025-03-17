import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:ticket_ifma/core/services/providers.dart';
import 'package:ticket_ifma/core/utils/loader.dart';
import 'package:ticket_ifma/features/resources/theme/app_colors.dart';
import 'package:ticket_ifma/features/resources/theme/app_text_styles.dart';
import 'package:ticket_ifma/features/resources/widgets/app_message.dart';
import 'package:ticket_ifma/features/resources/widgets/common_button_widget.dart';
import 'package:ticket_ifma/features/resources/widgets/common_text_field.dart';
import 'package:ticket_ifma/features/views/adm/cae/system_config/system_config_controller.dart';

class SystemConfigScreen extends ConsumerStatefulWidget {
  const SystemConfigScreen({super.key});

  @override
  ConsumerState<SystemConfigScreen> createState() => _SystemConfigScreenState();
}

class _SystemConfigScreenState extends ConsumerState<SystemConfigScreen> {
  // Manipuladores para o formulário de mátriculas com exceções
  final formKeyRegistrationException = GlobalKey<FormState>();
  final newRegistrationExceptionController = TextEditingController();
  // Manipuladores para o formulário das configurações do sistema
  final formKeySystemConfig = GlobalKey<FormState>();
  final timeLimitLunchController = TextEditingController();
  final timeLimitDinnerController = TextEditingController();
  bool isLunchTimeActive = false;
  bool isDinnerTimeActive = false;

  // MASCARÁ PARA CONFIGURAÇÃO DE HORÁRIOS COM BASE NO TEMPO
  MaskTextInputFormatter timeMask = MaskTextInputFormatter(
    mask: '##:##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final controller = ref.read(systemConfigClassProvider);
      await controller.loadData();
      if (controller.systemConfig.isNotEmpty) {
        setState(() {
          isLunchTimeActive = controller.systemConfig[0].isActive;
          isDinnerTimeActive = controller.systemConfig[1].isActive;
        });
      }
    });

  }

  @override
  void dispose() {
    newRegistrationExceptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(systemConfigClassProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Parâmetros do Sistema'),
      ),
      body: Visibility(
        visible: !controller.isLoading,
        replacement: Loader.loader(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSystemConfigForm(controller),
                  const SizedBox(height: 30),
                  const Text("Mátriculas Cadastradas (Exceções)",
                      style: AppTextStyle.titleSmall),
                  const SizedBox(height: 10),
                  const Divider(height: 0),
                  const SizedBox(height: 10),
                  _buildRegistrationList(controller),
                  const SizedBox(height: 30),
                  _buildNewRegistrationForm(controller),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeLimitField({
    required String title,
    required String labelText,
    required String hintText,
    TextEditingController? controller,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return CommonTextField(
        title: title,
        labelText: labelText,
        controller: controller,
        keyboardType: TextInputType.datetime,
        textInputAction: TextInputAction.next,
        validator: true,
        toolTip: hintText,
        inputFormatters: inputFormatters);
  }

  Widget _buildTimeLimitSwitch({
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.green,
          inactiveTrackColor: Colors.red[200],
        ),
        const SizedBox(width: 6),
        Text(
          value ? "Habilitado" : "Desabilitado",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: value ? Colors.green : Colors.red,
          ),
        ),
      ],
    );
  }

  Widget _buildSystemConfigForm(SystemConfigClassController controller) {
    return Form(
        key: formKeySystemConfig,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: SizedBox(
                    width: 250,
                    child: _buildTimeLimitField(
                        title: 'Horário limite para almoço',
                        labelText: controller.systemConfig.isNotEmpty
                            ? controller.systemConfig[0].value
                            : 'Digite um horário',
                        hintText: controller.systemConfig.isNotEmpty
                            ? controller.systemConfig[0].description
                            : "Consulte o desenvolvedor do sistema",
                        controller: timeLimitLunchController,
                        inputFormatters: [timeMask]),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                _buildTimeLimitSwitch(
                    value: isLunchTimeActive,
                    onChanged: (bool value) async {
                      await controller.updateMealTimeStatus(1, value);
                      if (!controller.error) {
                        AppMessage.i.showMessage("Status atualizado com sucesso!");
                      } else {
                        controller.loading();
                        AppMessage.i.showError(controller.errorMessage);
                      }
                      setState(() {
                        isLunchTimeActive = value;
                      });
                    })
              ],
            ),
            const SizedBox(
              width: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: SizedBox(
                    width: 250,
                    child: _buildTimeLimitField(
                        title: 'Horário limite para jantar',
                        labelText: controller.systemConfig.isNotEmpty
                            ? controller.systemConfig[1].value
                            : 'Digite um horário',
                        hintText: controller.systemConfig.isNotEmpty
                            ? controller.systemConfig[1].description
                            : "Consulte o desenvolvedor do sistema",
                        controller: timeLimitDinnerController,
                        inputFormatters: [timeMask]),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                _buildTimeLimitSwitch(
                    value: isDinnerTimeActive,
                    onChanged: (bool value) async {
                      await controller.updateMealTimeStatus(2, value);
                      if (!controller.error) {
                        AppMessage.i.showMessage("Status atualizado com sucesso!");
                      } else {
                        controller.loading();
                        AppMessage.i.showError(controller.errorMessage);
                      }
                      setState(() {
                        isDinnerTimeActive = value;
                      });
                    }
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildSaveButton(controller),
          ],
        ));
  }

  Widget _buildSaveButton(SystemConfigClassController controller) {
    return CommonButton(
      label: 'Salvar Modificação',
      function: () async {
        if (timeLimitDinnerController.text.isEmpty && timeLimitLunchController.text.isEmpty) {
          AppMessage.i.showError("Pelo menos um dos campos deve ser preenchido.");
          return;
        }
        if (timeLimitLunchController.text.isNotEmpty) {
          await controller.updateMealTime(1,timeLimitLunchController.text);
        }
        if (timeLimitDinnerController.text.isNotEmpty){
          await controller.updateMealTime(2,timeLimitDinnerController.text);
        }
        formKeySystemConfig.currentState!.reset();
          if (!controller.error) {
            await controller.loadData();
            AppMessage.i.showMessage("Horários atualizados com sucesso!");
          } else {
            controller.loading();
            AppMessage.i.showError(controller.errorMessage);
          }
        }
    );
  }

  Widget _buildRegistrationList(SystemConfigClassController controller) {
    return controller.registrationException.isNotEmpty
        ? GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 8,
                childAspectRatio: 5.0,
                mainAxisExtent: 25),
            itemCount: controller.registrationException.length,
            itemBuilder: (_, index) {
              final exception = controller.registrationException[index];
              return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.green),
                  height: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            textAlign: TextAlign.center,
                            style: AppTextStyle.normalText
                                .copyWith(color: Colors.white, fontSize: 14),
                            exception.value),
                        InkWell(
                          onTap: () async {
                            await controller.deleteRegistrationExceptionTicket(
                                exception.id);
                            if (!controller.error) {
                              await controller.loadData();
                              AppMessage.i.showMessage(
                                  'Mátricula deletada com sucesso');
                            } else {
                              controller.loading();
                              AppMessage.i.showError(controller.errorMessage);
                            }
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                  ));
            },
          )
        : const Center(child: Text("Ainda não há matrículas cadastradas"));
  }

  Widget _buildNewRegistrationForm(SystemConfigClassController controller) {
    return Form(
      key: formKeyRegistrationException,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTextField(
            title: 'Matrícula ex. 2020IC.CAX',
            labelText: 'Digite uma nova matrícula',
            textInputAction: TextInputAction.next,
            controller: newRegistrationExceptionController,
            validator: true,
            toolTip:
                "Turmas cadastradas terão permissão para solicitação de tickets além dos horários permitidos",
          ),
          const SizedBox(height: 20),
          CommonButton(
            label: 'Adicionar Matrícula',
            function: () async {
              if (formKeyRegistrationException.currentState?.validate() ??
                  false) {
                await controller.addRegistrationExceptionTicket(
                    newRegistrationExceptionController.text
                        .toUpperCase()
                        .trim());

                if (!controller.error) {
                  await controller.loadData();
                  AppMessage.i
                      .showMessage('Nova matrícula inserida com sucesso!');
                } else {
                  controller.loading();
                  AppMessage.i.showError(controller.errorMessage);
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
