import 'package:flutter/material.dart';
import 'package:ticket_ifma/features/resources/theme/app_colors.dart';

class CommonTilePhotoRequest extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? function;
  final VoidCallback? view;
  final bool selected;
  final bool? check;

  const CommonTilePhotoRequest(
      {super.key,
      required this.title,
      required this.subtitle,
      this.function,
      this.selected = true,
      this.check = false,
      required this.view});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: view,
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
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: function,
                      child: Visibility(
                        visible: check == true,
                        replacement: const SizedBox.shrink(),
                        child: Icon(
                          selected
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: AppColors.green,
                          size: 32,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Text(
                      "Ver",
                      style: TextStyle(
                        fontSize: 16,
                          color: AppColors.green, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
