import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:ticket_ifma/features/resources/theme/app_colors.dart';

class CommonTileOptions extends StatelessWidget {
  final IconData leading;
  final String label;
  final VoidCallback? function;

  const CommonTileOptions({
    super.key,
    required this.leading,
    required this.label,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.gray[50],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Icon(
                      leading,
                      color: AppColors.black,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                    child: Text(
                      label,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              PhosphorIcon(
                PhosphorIcons.caretRight(),
                size: 24,
                color: AppColors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
