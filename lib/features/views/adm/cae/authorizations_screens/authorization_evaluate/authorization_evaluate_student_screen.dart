import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticket_ifma/core/services/providers.dart';
import 'package:ticket_ifma/core/utils/loader.dart';
import 'package:ticket_ifma/features/models/student_authorization.dart';
import 'package:ticket_ifma/features/resources/theme/app_text_styles.dart';
import 'package:ticket_ifma/features/resources/widgets/app_message.dart';
import 'package:ticket_ifma/features/resources/widgets/common_tile_ticket.dart';

class AuthorizationEvaluateStudentScreen extends ConsumerStatefulWidget {
  final StudentAuthorization authorizationStudent;
  final String title;

  const AuthorizationEvaluateStudentScreen({
    super.key,
    required this.authorizationStudent,
    required this.title,
  });

  @override
  ConsumerState<AuthorizationEvaluateStudentScreen> createState() =>
      _AuthorizationEvaluateStudentScreenState();
}

class _AuthorizationEvaluateStudentScreenState
    extends ConsumerState<AuthorizationEvaluateStudentScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(caePermanentProvider).selectAllStudent = true;
    ref.read(caePermanentProvider).selectedAuthorizationsStudent.clear();
    ref.read(caePermanentProvider).selectedAuthorizationsStudent.addAll(widget.authorizationStudent.ticketsIds);
  }

  List<int> authorizedTicketsStudent = [];

  eraserAuthorizationStudent(List<int> values) {
    authorizedTicketsStudent.clear();
    authorizedTicketsStudent = values;
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(caePermanentProvider);

    bool continueSolicitation() {
      if (controller.selectedAuthorizationsStudent.isEmpty) {
        AppMessage.i.showInfo('Não existem tickets selecionados!');
        return false;
      }

      return true;
    }

    return PopScope(
      canPop: true,
      onPopInvoked: (bool didPop) async {
        if (didPop) return;

        Navigator.pop(context, authorizedTicketsStudent);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, authorizedTicketsStudent);
            },
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          title: Text(widget.title),
          actions: [
            IconButton(
              onPressed: () {
                if (controller.isLoading) return;
                controller.isSelectedAuthorizationStudent(
                    widget.authorizationStudent.ticketsIds);
              },
              icon: Icon(controller.selectAllStudent
                  ? Icons.check_box
                  : Icons.check_box_outline_blank),
            ),
          ],
        ),
        body: Visibility(
          visible: !controller.isLoading,
          replacement: Loader.loader(),
          child: ListView.builder(
              padding: const EdgeInsets.all(20),
              shrinkWrap: true,
              itemCount: widget.authorizationStudent.ticketsIds.length,
              itemBuilder: (context, index) {
                return CommonTileTicket(
                    title: widget.authorizationStudent.matricula,
                    subtitle:
                        "${widget.authorizationStudent.meal} - ${widget.authorizationStudent.listDays[index].toString()}",
                    justification: widget.authorizationStudent.text,
                    selected: controller.selectedAuthorizationsStudent
                            .contains(
                      widget.authorizationStudent.ticketsIds[index],
                    ) ? true : false,
                    function: () =>
                        controller.verifySelectedAuthorizationStudent(
                          widget.authorizationStudent.ticketsIds[index],
                          widget.authorizationStudent.ticketsIds.length,
                        ),
                    check: true);
              }),
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
                      eraserAuthorizationStudent(controller.selectedAuthorizationsStudent);
                      controller.changedAuthorizationStudent(7);
                      AppMessage.i.showInfo('Tickets recusados com sucesso');
                      Navigator.pop(context, authorizedTicketsStudent);
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
                      eraserAuthorizationStudent(controller.selectedAuthorizationsStudent);
                      controller.changedAuthorizationStudent(4);
                      AppMessage.i.showMessage(
                          'Tickets permanentes aprovados com sucesso');
                      Navigator.pop(context, authorizedTicketsStudent);
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
