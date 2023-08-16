import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_ifma_ticket/core/services/providers.dart';
import 'package:project_ifma_ticket/core/utils/date_util.dart';
import 'package:project_ifma_ticket/core/utils/loader.dart';
import 'package:project_ifma_ticket/features/models/authorization.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
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
  @override
  void initState() {
    super.initState();
    ref.read(caePermanentProvider).filteredAuthorizations.clear();
    ref.read(caePermanentProvider).selectedAuthorizatons.clear();
    // ref.read(caePermanentProvider).filteredAuthorizations.addAll(widget.authorizations);
    // ref.read(caePermanentProvider).selectedAuthorizatons.addAll(widget.authorizations);
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
                // if (controller.isLoading) return;
                // controller.isSelected(widget.authorizations);
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
                // TextField(
                //   onChanged: (value) =>
                //       controller.filterAuthorizations(value, allAuthorizations),
                //   decoration: const InputDecoration(
                //     fillColor: AppColors.gray800,
                //     filled: true,
                //     hintText: "Busca",
                //     prefixIcon: Icon(Icons.search, color: AppColors.green500),
                //     border: OutlineInputBorder(
                //         borderSide: BorderSide.none,
                //         borderRadius: BorderRadius.all(Radius.circular(10))),
                //   ),
                // ),
                const SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: allAuthorizations.isNotEmpty,
                  // visible: controller.filteredAuthorizations.isNotEmpty,
                  replacement: const WithoutResults(
                      msg: 'Nenhuma solicitação encontrada'),
                  child: Expanded(
                    child: ListView.builder(
                      itemCount: allAuthorizations.keys.length,
                      itemBuilder: (context, index) => CommonTileTicket(
                        title: allAuthorizations.keys.elementAt(index),
                        subtitle: "${allAuthorizations[
                            allAuthorizations.keys.elementAt(index)]!.first.meal} - ${getDays(allAuthorizations[
                            allAuthorizations.keys.elementAt(index)]!)}",
                        justification:
                          allAuthorizations.values.first.first.justification,
                        // selected: controller.selectedAuthorizatons.contains(
                        //         controller.filteredAuthorizations[index])
                        //     ? true
                        //     : false,
                        // function: () => controller.verifySelected(
                        //     controller.filteredAuthorizations[index],
                        //     lengthTickets),
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
                    // style: Style.buttonTextStyle,
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
                    // style: Style.buttonTextStyle,
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
