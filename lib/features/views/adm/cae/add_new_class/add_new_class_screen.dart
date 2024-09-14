import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticket_ifma/core/services/providers.dart';
import 'package:ticket_ifma/core/utils/loader.dart';
import 'package:ticket_ifma/features/resources/widgets/app_message.dart';
import 'package:ticket_ifma/features/resources/widgets/common_button_widget.dart';
import 'package:ticket_ifma/features/resources/widgets/common_text_field.dart';

class AddNewClassScreen extends ConsumerStatefulWidget {
  const AddNewClassScreen({super.key});

  @override
  ConsumerState<AddNewClassScreen> createState() => _AddNewClassScreenState();
}

class _AddNewClassScreenState extends ConsumerState<AddNewClassScreen> {
  final newClass = TextEditingController();
  final course = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    newClass.dispose();
    course.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(addNewClassProvider);

    void loadingVerify() {
      controller.isLoading
                            ? Loader.i.showLoader()
                            : const SizedBox.shrink();
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Nova Turma'),
      ),
      
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),

          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
            
              children: [
                CommonTextField(
                  title: 'Turma ex. 2020IC.CAX',
                  labelText: 'Digite a nova turma',
                  textInputAction: TextInputAction.next,
                  controller: newClass,
                  validator: true,
                ),
                
                CommonTextField(
                  title: 'Curso',
                  labelText: 'Digite o curso',
                  textInputAction: TextInputAction.done,
                  controller: course,
                  validator: true,
                ),

                const SizedBox(height: 20),

                CommonButton(
                  label: 'Adicionar Turma',
                  function: () async {
                    final valid =
                                formKey.currentState?.validate() ?? false;

                    if (valid) {
                      controller.loading();

                      loadingVerify();

                      await controller.addClass(
                        newClass.text.toUpperCase().trim(),
                        course.text.trim(),
                      );

                      if (!controller.error) {
                        Loader.i.hideDialog();
                        AppMessage.i
                            .showMessage('Nova turma inserida com sucesso!');
                      } else {
                        Loader.i.hideDialog();
                        AppMessage.i
                            .showError('Erro ao inserir nova turma!');
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
