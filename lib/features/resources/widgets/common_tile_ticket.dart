import 'package:flutter/material.dart';
import 'package:ticket_ifma/features/resources/theme/app_colors.dart';

class CommonTileTicket extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? function;
  final String justification;
  final bool selected;
  final bool? check;
  final VoidCallback? next;

  const CommonTileTicket({
    super.key,
    required this.title,
    required this.subtitle,
    this.function,
    required this.justification,
    this.selected = true,
    this.check = false,
    this.next
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.gray[100],
            borderRadius: BorderRadius.circular(8),
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
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      SizedBox(
                        width: 215,
                        child: Text(
                          subtitle,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: AppColors.black,
                          ),
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
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Visibility(
                      visible: check == true,
                      replacement: const SizedBox.shrink(),
                      child: Icon(
                        selected ? Icons.check_box : Icons.check_box_outline_blank,
                        color: AppColors.green,
                        size: 32,
                      ),
                    ),
                    Visibility(
                      visible: next != null,
                      replacement: const SizedBox.shrink(),
                      child: InkWell(
                        onTap: next,
                        child: Container(
                          alignment: Alignment.centerRight,
                          height:75,
                          width: 40,
                          child: const Icon(Icons.arrow_forward_ios_rounded,
                            color: AppColors.black,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
