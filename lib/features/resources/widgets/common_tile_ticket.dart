import 'package:flutter/material.dart';
import 'package:project_ifma_ticket/features/resources/theme/app_colors.dart';

class CommonTileTicket extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? function;
  final String justification;
  final bool selected;
  final bool? check;

  const CommonTileTicket({
    super.key,
    required this.title,
    required this.subtitle,
    this.function,
    required this.justification,
    this.selected = true, 
    this.check = false,
  });

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
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.gray400,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: AppColors.gray400,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        justification,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: AppColors.gray400,
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: check == true,
                  replacement: const SizedBox.shrink(),
                  child: Icon(
                    selected ? Icons.check_box : Icons.check_box_outline_blank,
                    color: AppColors.green500,
                    size: 32,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
