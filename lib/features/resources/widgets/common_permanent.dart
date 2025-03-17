import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ticket_ifma/features/models/permanent_model.dart';
import 'package:ticket_ifma/features/resources/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonPermanent extends StatelessWidget {
  final PermanentModel permanentModel;

  const CommonPermanent({
    super.key,
    required this.permanentModel,
  });

  @override
  Widget build(BuildContext context) {
    String statusName() {
      return permanentModel.statusId == 1 ? 'Em análise' : permanentModel.statusId == 4 ? "Autorizado" : "Não autorizado";
    }

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
                    'Permanente para ${permanentModel.weekDescription}',

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
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.timer_rounded,
                            size: 12,
                            color: AppColors.gray[500],
                          ),

                          const SizedBox(width: 4),

                          Text(
                            permanentModel.mealDescription,
                            style: const TextStyle(
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
                                permanentModel.statusImage(),
                                height: 12,
                                width: 12,
                              ),

                              const SizedBox(width: 4),

                              Text(
                                statusName(),
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
        ],
      ),
    );
  }
}
