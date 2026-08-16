import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_decorations.dart';
import '../../../shared/widgets/glass_card.dart';
import '../doctor_help_item.dart';

/// Glossy glass card presenting a predefined pediatric question
class DoctorHelpCard extends StatelessWidget {
  final DoctorHelpItem item;
  final String languageCode;
  final VoidCallback onTap;

  const DoctorHelpCard({
    super.key,
    required this.item,
    required this.languageCode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      borderRadius: 22,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 3D Glossy Icon Badge
          Container(
            padding: const EdgeInsets.all(10),
            decoration: AppDecorations.glossyIconBoxDecoration(
              color: AppColors.primaryDark,
              isDark: isDark,
              borderRadius: 14,
            ),
            child: Icon(
              item.icon,
              color: AppColors.primaryDark,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          // Question Content & Category Pill
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3.5),
                      decoration: AppDecorations.glossyPillBoxDecoration(
                        color: AppColors.accent,
                        isDark: isDark,
                        borderRadius: 10,
                      ),
                      child: Text(
                        item.getCategory(languageCode),
                        style: const TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.bold,
                          color: AppColors.accent,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                      color: AppColors.primaryDark,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  item.getQuestion(languageCode),
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.primaryDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
