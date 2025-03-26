import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticket_ifma/core/utils/date_util.dart';
import 'package:ticket_ifma/core/utils/dialog.dart';
import 'package:ticket_ifma/features/models/photo_request_model.dart';
import 'package:ticket_ifma/features/resources/theme/app_colors.dart';
import 'package:ticket_ifma/features/resources/theme/app_text_styles.dart';
import 'package:ticket_ifma/features/views/student/profile/photo_student_controller.dart';

class CommonPhotoRequestWidget extends StatelessWidget {
  final PhotoRequestModel photoRequest;
  final VoidCallback? function;
  final PhotoStudentController? controller;
  final bool isTap;

  const CommonPhotoRequestWidget({
    super.key,
    required this.photoRequest,
    this.function,
    this.controller,
    this.isTap = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.gray[50],
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateUtil.ticketDay(photoRequest.createdAt),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 12,
                            color: AppColors.gray[500],
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            "Nova foto de perfil",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Row(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                photoRequest.statusImage(),
                                height: 12,
                                width: 12,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                photoRequest.status,
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          if (isTap)
            SizedBox(
              width: 120,
              height: 100,
              child: Material(
                color: Colors.transparent,
                child: actionWidget(
                  photoRequest.status,
                  photoRequest.statusImage(),
                  function,
                  photoRequest,
                  context,
                  controller,
                ),
              ),
            )
        ],
      ),
    );
  }
}

// DateTime _today() {
//   DateTime dayNow = DateTime.now();
//   DateTime todayOnlyDate = DateTime(dayNow.year, dayNow.month, dayNow.day);

//   return todayOnlyDate;
// }

// DateTime _convertStringToDateTime(String ticketUseDayDate) {
//   DateTime dateTime = DateTime.parse(ticketUseDayDate);
//   DateTime dateTimeOnlyDate =
//       DateTime(dateTime.year, dateTime.month, dateTime.day);

//   return dateTimeOnlyDate;
// }

// bool _checkTodayAction(String ticketUseDayDate) {
//   DateTime dateTime = _convertStringToDateTime(ticketUseDayDate);
//   DateTime today = _today();
//   return dateTime == today;
// }

Widget actionWidget(
    String status,
    String statusImage,
    VoidCallback? action,
    PhotoRequestModel photoRequest,
    BuildContext context,
    PhotoStudentController? controller) {
  if (status == "Em Análise") {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => DialogForm(
            title: 'Cancelar Solicitação?',
            action: controller == null
                ? () => action!()
                : () => controller.cancelRequestPhoto(photoRequest.id),
            colorConfirmButton: AppColors.red,
            confirmButtonTextStyle: AppTextStyle.titleMedium.copyWith(
              color: AppColors.white,
            ),
            message:
                "Caso você queria cancelar a solicitação, clique em sim para cancelar.",
          ),
        );
      },
      child: const Row(
        children: [
          DottedLine(
            direction: Axis.vertical,
            lineLength: 60,
            dashLength: 2,
            dashColor: AppColors.gray,
          ),
          Expanded(
            child: Align(
                child: Text(
              'Cancelar',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.red,
                letterSpacing: -1,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            )),
          ),
        ],
      ),
    );
  }
  return const SizedBox(
    height: 50,
    width: 50,
  );
}
