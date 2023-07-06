import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/features/models/user.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_text_styles.dart';

class CommonTileStudent extends StatelessWidget {
  final User? student;
  final VoidCallback? function;
  const CommonTileStudent({super.key, this.function, this.student});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.gray900,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Fulano de Tal",
                          style: TextApp.titleLarge.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.gray400,
                          )),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        "20191BCC.CAX03848",
                        style: TextApp.labelLarge.copyWith(
                          fontWeight: FontWeight.normal,
                          color: AppColors.gray400,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text("Superior",
                          style: TextApp.labelLarge.copyWith(
                            fontWeight: FontWeight.normal,
                            color: AppColors.gray400,
                          )),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_rounded,
                  color: AppColors.gray400,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
