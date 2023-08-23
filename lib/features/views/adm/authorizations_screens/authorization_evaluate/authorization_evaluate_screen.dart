import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_ifma_ticket/core/services/providers.dart';
import 'package:project_ifma_ticket/core/utils/date_util.dart';
import 'package:project_ifma_ticket/core/utils/loader.dart';
import 'package:project_ifma_ticket/features/dto/student_authorization.dart';
import 'package:project_ifma_ticket/features/models/authorization.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_text_styles.dart';
import 'package:project_ifma_ticket/features/resources/widgets/app_message.dart';
import 'package:project_ifma_ticket/features/resources/widgets/common_tile_ticket.dart';
import 'package:project_ifma_ticket/features/resources/widgets/without_results.dart';

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
  String getDays(List<Authorization> list) {
    String days = '(';
    for (int i = 0; i < list.length; i++) {
      if (i == 0) {
        days = '$days${list[0].day()}';
      } else {
        days = '$days, ${list[i].day()}';
      }
    }
    return '$days)';
  }

  List<StudentAuthorization> authorizationsList() {
    List<StudentAuthorization> list = [];

    for (int index = 0; index < widget.authorizations.keys.length; index++) {
      StudentAuthorization student = StudentAuthorization(
          matricula: widget.authorizations.keys.elementAt(index),
          idStudent: widget
              .authorizations[widget.authorizations.keys.elementAt(index)]!
              .first
              .id,
          justification: widget
              .authorizations[widget.authorizations.keys.elementAt(index)]!
              .first
              .justification,
          meal: widget
              .authorizations[widget.authorizations.keys.elementAt(index)]!
              .first
              .meal,
          days: getDays(widget
              .authorizations[widget.authorizations.keys.elementAt(index)]!));
      list.add(student);
      log("Student :: ${student.toString()}");
    }
    log("List Authorizations :: $list");
    return list;
  }

  @override
  void initState() {
    super.initState();
    log("List Authorizations Init State:: $authorizationsList()");
    ref.read(caePermanentProvider).filteredAuthorizations.clear();
    ref.read(caePermanentProvider).selectedAuthorizatons.clear();
    ref
        .read(caePermanentProvider)
        .filteredAuthorizations
        .addAll(authorizationsList());
    ref
        .read(caePermanentProvider)
        .selectedAuthorizatons
        .addAll(authorizationsList());
    ref.read(caePermanentProvider).selectAll = true;
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(caePermanentProvider);
    Map<String, List<Authorization>> allAuthorizations = widget.authorizations;
    final lengthTickets = allAuthorizations.keys.length;

    log('Selected ${controller.selectedAuthorizatons.length.toString()}');
    log('SelectedAll ${controller.selectAll.toString()}');
    log('SelectedAll ${widget.authorizations.toString()}');

    bool continueSolicitation() {
      if (controller.selectedAuthorizatons.isEmpty) {
        AppMessage.i.showInfo('Não existem tickets selecionados!');
        return false;
      }

      return true;
    }

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        // Navigator.pop(context, controller.filteredAuthorizations);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                // Navigator.pop(context, controller.filteredAuthorizations);
              },
              icon: const Icon(Icons.arrow_back_rounded)),
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
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Visibility(
            visible: !controller.isLoading,
            replacement: Loader.loader(),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) => controller.filterAuthorizations(
                      value, controller.filteredAuthorizations),
                  decoration: const InputDecoration(
                    fillColor: AppColors.gray800,
                    filled: true,
                    hintText: "Busca",
                    prefixIcon: Icon(Icons.search, color: AppColors.green500),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Visibility(
                  // visible: allAuthorizations.isNotEmpty,
                  visible: controller.filteredAuthorizations.isNotEmpty,
                  replacement: const WithoutResults(
                      msg: 'Nenhuma solicitação encontrada'),

                  child: Expanded(
                    child: ListView.builder(
                      itemCount: controller.filteredAuthorizations.length,
                      itemBuilder: (context, index) => CommonTileTicket(
                        title:
                            controller.filteredAuthorizations[index].matricula,
                        subtitle:
                            "${controller.filteredAuthorizations[index].meal} - ${controller.filteredAuthorizations[index].days}",
                        justification: controller
                            .filteredAuthorizations[index].justification,
                        selected: controller.selectedAuthorizatons.contains(
                                controller.filteredAuthorizations[index])
                            ? true
                            : false,
                        function: () => controller.verifySelected(
                            controller.filteredAuthorizations[index],
                            lengthTickets),
                        check: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
                    // if (continueSolicitation()) {
                    //   controller.solicitation(7);
                    // }
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
              // Style.formSizedBox,
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // if (continueSolicitation()) {
                    //   controller.solicitation(2);
                    // }
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
