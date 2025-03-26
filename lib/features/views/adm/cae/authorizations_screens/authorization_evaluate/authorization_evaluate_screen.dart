import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticket_ifma/core/services/providers.dart';
import 'package:ticket_ifma/core/utils/loader.dart';
import 'package:ticket_ifma/features/models/authorization.dart';
import 'package:ticket_ifma/features/models/student_authorization.dart';
import 'package:ticket_ifma/features/resources/routes/app_routes.dart';
import 'package:ticket_ifma/features/resources/routes/screen_arguments.dart';
import 'package:ticket_ifma/features/resources/theme/app_colors.dart';
import 'package:ticket_ifma/features/resources/theme/app_text_styles.dart';
import 'package:ticket_ifma/features/resources/widgets/app_message.dart';
import 'package:ticket_ifma/features/resources/widgets/common_tile_ticket.dart';
import 'package:ticket_ifma/features/resources/widgets/without_results.dart';

class AuthorizationEvaluateScreen extends ConsumerStatefulWidget {
  final Map<String, List<Authorization>> authorizations;
  final String title;

  const AuthorizationEvaluateScreen({
    super.key,
    required this.authorizations,
    required this.title,
  });

  @override
  ConsumerState<AuthorizationEvaluateScreen> createState() =>
      _AuthorizationEvaluateScreenState();
}

class _AuthorizationEvaluateScreenState
    extends ConsumerState<AuthorizationEvaluateScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(caePermanentProvider).filteredAuthorizations.clear();
    ref.read(caePermanentProvider).selectedAuthorizations.clear();
    ref.read(caePermanentProvider).authorizationsList(widget.authorizations);
    ref.read(caePermanentProvider).selectAll = true;
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(caePermanentProvider);

    List<StudentAuthorization> allStudents =
        controller.studentsAuthorizationsList(widget.authorizations);
    final lengthTickets = allStudents.length;
    List<List<String>> selectedStudents = [];

    bool continueSolicitation() {
      if (controller.selectedAuthorizations.isEmpty) {
        AppMessage.i.showInfo('Não existem tickets selecionados!');
        return false;
      }

      return true;
    }

    eraserStudents() {
      for (var element in controller.selectedAuthorizations) {
        selectedStudents.add([element.matricula, element.meal]);
      }
    }

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (bool didPop, dynamic d) async {
        if (didPop) return;

        Navigator.pop(context, selectedStudents);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, selectedStudents);
            },
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          title: Text(widget.title),
          actions: [
            IconButton(
              onPressed: () {
                if (controller.isLoading) return;
                controller.isSelected(controller.filteredAuthorizations);
              },
              icon: Icon(controller.selectAll
                  ? Icons.check_box
                  : Icons.check_box_outline_blank),
            ),
          ],
        ),
        body: Visibility(
          visible: !controller.isLoading,
          replacement: Loader.loader(),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 20, top: 20.0, right: 20.0),
                child: TextField(
                  onChanged: (value) =>
                      controller.filterAuthorizations(value, allStudents),
                  decoration: const InputDecoration(
                    filled: true,
                    hintText: "Busca",
                    prefixIcon: Icon(Icons.search, color: AppColors.green),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                visible: controller.filteredAuthorizations.isNotEmpty,
                replacement:
                    const WithoutResults(msg: 'Nenhuma solicitação encontrada'),
                child: Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      itemCount: controller.filteredAuthorizations.length,
                      itemBuilder: (context, index) {
                        return CommonTileTicket(
                            title: controller
                                .filteredAuthorizations[index].matricula,
                            subtitle:
                                "${controller.filteredAuthorizations[index].meal} - ${controller.filteredAuthorizations[index].getDays()}",
                            justification:
                                controller.filteredAuthorizations[index].text,
                            selected:
                                controller.selectedAuthorizations.contains(
                              controller.filteredAuthorizations[index],
                            )
                                    ? true
                                    : false,
                            function: () => controller.verifySelected(
                                  controller.filteredAuthorizations[index],
                                  lengthTickets,
                                ),
                            check: true,
                            next: () async {
                              dynamic list = await Navigator.pushNamed(
                                context,
                                AppRouter.authorizationEvaluateStudentRoute,
                                arguments: ScreenArguments(
                                    title: controller
                                        .filteredAuthorizations[index]
                                        .matricula,
                                    authorizationStudent: controller
                                        .filteredAuthorizations[index]),
                              );
                              controller.updateAuthorizationsStudent(
                                  list as List<int>, index);
                            });
                      }),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    if (continueSolicitation()) {
                      controller.changedAuthorizations(7);
                      eraserStudents();
                      AppMessage.i.showInfo('Tickets recusados com sucesso');
                      Navigator.pop(context, selectedStudents);
                    }
                  },
                  child: const Text(
                    'Recusar',
                    style: AppTextStyle.buttonTextStyle,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    if (continueSolicitation()) {
                      controller.changedAuthorizations(4);
                      eraserStudents();
                      AppMessage.i.showMessage(
                          'Tickets permanentes aprovados com sucesso');
                      Navigator.pop(context, selectedStudents);
                      return Future.value();
                    }
                  },
                  child: const Text(
                    'Aprovar',
                    style: AppTextStyle.buttonTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
