import 'package:flutter/material.dart';
import 'package:ticket_ifma/features/models/user.dart';
import 'package:ticket_ifma/features/resources/theme/app_colors.dart';
import 'package:ticket_ifma/features/resources/theme/app_text_styles.dart';

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
            color: AppColors.gray[50],
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
                      Text(
                        student!.name,
                        style: AppTextStyle.titleMedium.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        student!.matricula,
                        style: AppTextStyle.labelLarge.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        student!.type,
                        style: AppTextStyle.labelLarge.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_rounded,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
