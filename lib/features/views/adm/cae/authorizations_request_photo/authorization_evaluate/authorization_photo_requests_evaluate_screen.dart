import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticket_ifma/core/services/providers.dart';
import 'package:ticket_ifma/core/utils/date_util.dart';
import 'package:ticket_ifma/core/utils/loader.dart';
import 'package:ticket_ifma/features/models/photo_request_model.dart';
import 'package:ticket_ifma/features/resources/theme/app_colors.dart';
import 'package:ticket_ifma/features/resources/widgets/app_message.dart';
import 'package:ticket_ifma/features/resources/widgets/common_tile_photo_request.dart';
import 'package:ticket_ifma/features/resources/widgets/photo_dialog.dart';
import 'package:ticket_ifma/features/resources/widgets/without_results.dart';

class PhotoRequestAuthorizationEvaluateRoute extends ConsumerStatefulWidget {
  final List<PhotoRequestModel> photoRequests;
  final String title;

  const PhotoRequestAuthorizationEvaluateRoute({
    super.key,
    required this.title,
    required this.photoRequests,
  });

  @override
  ConsumerState<PhotoRequestAuthorizationEvaluateRoute> createState() =>
      _PhotoRequestAuthorizationEvaluateRouteState();
}

class _PhotoRequestAuthorizationEvaluateRouteState
    extends ConsumerState<PhotoRequestAuthorizationEvaluateRoute> {
  @override
  void initState() {
    super.initState();
    ref.read(photoRequestAuthorizationProvider).filteredPhotoRequests.clear();
    ref.read(photoRequestAuthorizationProvider).selectedPhotoRequests.clear();
    ref
        .read(photoRequestAuthorizationProvider)
        .filteredPhotoRequests
        .addAll(widget.photoRequests);
    ref
        .read(photoRequestAuthorizationProvider)
        .selectedPhotoRequests
        .addAll(widget.photoRequests);
    ref.read(photoRequestAuthorizationProvider).selectAll = true;
    ref.read(photoRequestAuthorizationProvider).isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(photoRequestAuthorizationProvider);
    List<PhotoRequestModel> allPhotoRequests = widget.photoRequests;
    final lengthPhotoRequests = allPhotoRequests.length;
    bool continueSolicitation() {
      if (controller.selectedPhotoRequests.isEmpty) {
        AppMessage.i.showInfo('Não existem solicitações selecionadas!');
        return false;
      }

      return true;
    }

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (bool didPop, dynamic d) async {
        if (didPop) return;
        Navigator.pop(context, controller.filteredPhotoRequests);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, controller.filteredPhotoRequests);
            },
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          title: Text(widget.title),
          actions: [
            IconButton(
              onPressed: () {
                if (controller.isLoading) return;
                controller.isSelected(widget.photoRequests);
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
                  onChanged: (value) =>
                      controller.filterPhotoRequests(value, allPhotoRequests),
                  decoration: const InputDecoration(
                    filled: true,
                    hintText: "Busca",
                    prefixIcon: Icon(Icons.search, color: AppColors.green),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: controller.filteredPhotoRequests.isNotEmpty,
                  replacement: const WithoutResults(
                      msg: 'Nenhuma solicitação encontrada'),
                  child: Expanded(
                    child: ListView.builder(
                        itemCount: controller.filteredPhotoRequests.length,
                        itemBuilder: (context, index) {
                          final photoRequest =
                              controller.filteredPhotoRequests[index];
                          return CommonTilePhotoRequest(
                            title: controller.filteredPhotoRequests
                                .elementAt(index)
                                .studentRegistration,
                            subtitle:
                                "Data da solicitação: ${DateUtil.getDateStr(controller.filteredPhotoRequests.elementAt(index).createdAt)}",
                            selected: controller.selectedPhotoRequests
                                    .contains(photoRequest)
                                ? true
                                : false,
                            view: () => photoRequestDialog(context,
                                controller.getImageUrl(photoRequest.id)),
                            function: () => controller.verifySelected(
                                photoRequest, lengthPhotoRequests),
                            check: true,
                          );
                        }),
                  ),
                )
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
                    if (continueSolicitation()) {
                      controller.solicitation(PhotoRequestModel.reproved);
                    }
                  },
                  child: const Text(
                    'Recusar',
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (continueSolicitation()) {
                      controller.solicitation(PhotoRequestModel.approved);
                    }
                  },
                  child: const Text(
                    'Aprovar',
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
