import 'package:flutter/material.dart';
import 'package:ticket_ifma/features/resources/widgets/common_button_widget.dart';
import 'package:ticket_ifma/features/resources/widgets/common_text_field.dart';

class AddNewClassScreen extends StatefulWidget {
  const AddNewClassScreen({super.key});

  @override
  State<AddNewClassScreen> createState() => _AddNewClassScreenState();
}

class _AddNewClassScreenState extends State<AddNewClassScreen> {
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
                  function: () => {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
