import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticket_ifma/core/services/providers.dart';
import 'package:ticket_ifma/core/utils/loader.dart';
import 'package:ticket_ifma/features/resources/theme/app_text_styles.dart';
import 'package:ticket_ifma/features/resources/widgets/app_message.dart';
import 'package:ticket_ifma/features/resources/widgets/common_button_widget.dart';
import 'package:ticket_ifma/features/resources/widgets/common_dropdown_widget.dart';
import 'package:ticket_ifma/features/resources/widgets/common_text_field.dart';

class AddNewClassScreen extends ConsumerStatefulWidget {
  const AddNewClassScreen({super.key});

  @override
  ConsumerState<AddNewClassScreen> createState() => _AddNewClassScreenState();
}

class _AddNewClassScreenState extends ConsumerState<AddNewClassScreen> {
  final newClass = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(addNewClassProvider).loadData();
    });
  }

  @override
  void dispose() {
    newClass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(addNewClassProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Adicionar Nova Turma'),
        ),
        body: Visibility(
          visible: !controller.isLoading,
          replacement: Loader.loader(),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Turmas Cadastradas (Ensino Médio)",
                      style: AppTextStyle.titleSmall),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 0,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: !controller.classes.isNotEmpty
                        ? const Center(
                            child: Text("Ainda não há turmas cadastradas"))
                        : ListView.builder(
                            itemCount: controller.classes.length,
                            itemBuilder: (_, index) {
                              final classe =
                                  controller.classes.elementAt(index);
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colors.grey[300]!,
                                      width: 1), // Borda sutil
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.black.withValues(alpha: .05),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10), // Melhor espaçamento
                                margin: const EdgeInsets.all(
                                    4), // Margem levemente maior
                                height: 45,
                                width: 120,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${classe.registration} - ${controller.coursesMap[classe.course].toString().toUpperCase()}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow
                                          .ellipsis, // Evita cortes abruptos
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              );
                            }),
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonTextField(
                          title: 'Turma ex. 2020IC.CAX',
                          labelText: 'Digite a nova turma',
                          textInputAction: TextInputAction.next,
                          controller: newClass,
                          validator: true,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            'Curso',
                            style: AppTextStyle.titleSmall,
                          ),
                        ),
                        CommonDropDownButton(
                          hint: 'Selecione um curso',
                          validator: (value) =>
                              value == null ? 'Selecione um curso' : null,
                          items: controller.courses
                              .map((e) => e.keys.first)
                              .toList(),
                          onChanged: (value) => controller.selectCourse(value),
                        ),
                        const SizedBox(height: 20),
                        CommonButton(
                          label: 'Adicionar Turma',
                          function: () async {
                            final valid =
                                formKey.currentState?.validate() ?? false;

                            if (valid) {
                              controller.loading();

                              await controller.addClass(
                                newClass.text.toUpperCase().trim(),
                                controller.selectedCourse!,
                              );

                              if (!controller.error) {
                                Loader.i.hideDialog();
                                AppMessage.i.showMessage(
                                    'Nova turma inserida com sucesso!');
                                controller.loadData();
                              } else {
                                Loader.i.hideDialog();
                                AppMessage.i
                                    .showError(
                                    "Erro ao inserir uma nova turma");
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
