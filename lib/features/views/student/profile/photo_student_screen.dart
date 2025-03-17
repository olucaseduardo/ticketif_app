import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticket_ifma/core/services/providers.dart';
import 'package:ticket_ifma/core/utils/loader.dart';
import 'package:ticket_ifma/features/resources/routes/app_routes.dart';
import 'package:ticket_ifma/features/resources/theme/app_colors.dart';
import 'package:ticket_ifma/features/resources/theme/app_text_styles.dart';
import 'package:ticket_ifma/features/resources/widgets/common_photo_request_widget.dart';
import 'package:ticket_ifma/features/views/student/profile/photo_student_controller.dart';

class PhotoStudentScreen extends ConsumerStatefulWidget {
  const PhotoStudentScreen({super.key});

  @override
  ConsumerState<PhotoStudentScreen> createState() => _PhotoStudentState();
}

class _PhotoStudentState extends ConsumerState<PhotoStudentScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await ref.read(photoStudentProvider).loadData();
      } catch (e) {
        // Handle data loading errors
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(photoStudentProvider);
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(controller),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      titleSpacing: 0,
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.black,
      centerTitle: false,
      title: const Text(
        'Voltar',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: AppColors.black,
          )),
    );
  }

  Widget _buildBody(PhotoStudentController controller) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
            child: Text(
              'Foto de Perfil',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  _buildImageStudent(controller),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              )),
          const SizedBox(
            height: 10,
          ),
          _buildMealsSection(controller),
        ],
      ),
    );
  }

  Widget _buildImageStudent(PhotoStudentController controller) {
    if (controller.imgURL != null) {
      return CachedNetworkImage(
        fit: BoxFit.cover,
        width: 300,
        height: 300,
        cacheKey: "student_photo_${controller.user!.registration}",
        imageUrl: controller.imgURL!,
        placeholder: (context, url) => Column(
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(color: AppColors.gray[200]),
              width: 300,
              height: 300,
              child: Loader.refreshLoader(),
            ),
          ],
        ),
        errorWidget: (context, url, error) {
          log("", error: error);
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(color: AppColors.gray[200]),
            width: 300,
            height: 300,
            child: const Icon(
              Icons.person,
              size: 125,
              color: AppColors.gray,
            ),
          );
        },
      );
    } else {
      return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(color: AppColors.gray[200]),
        width: 300,
        height: 300,
        child: const Icon(
          Icons.person,
          size: 125,
          color: AppColors.gray,
        ),
      );
    }
  }

  Widget _buildMealsSection(PhotoStudentController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Solicitações de Troca',
                  style: AppTextStyle.labelBig
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                TextButton(
                  onPressed: () => {
                    Navigator.pushNamed(
                      context,
                      AppRouter.newSolicitationPhotoStudentRoute,
                    ).then((value) async {
                      await controller.loadData();
                    })
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 0.0),
                    ),
                  ),
                  child: Text(
                    'Nova Solicitação',
                    style: AppTextStyle.titleSmall
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
              visible: controller.isLoading == false,
              replacement: SizedBox(height: 100, child: Loader.refreshLoader()),
              child: controller.photoRequests.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.photoRequests.length,
                      itemBuilder: (context, index) {
                        final photoRequest = controller.photoRequests[index];
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: CommonPhotoRequestWidget(
                                photoRequest: photoRequest,
                                controller: controller,
                              ),
                            ),
                          ],
                        );
                      })
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 200,
                          child: Text(
                            'Faça sua solicitação para mudança de foto e aguarde ser aprovado.',
                            style: TextStyle(
                                fontSize: 12, color: AppColors.gray[800]),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )),
        ],
      ),
    );
  }
}
