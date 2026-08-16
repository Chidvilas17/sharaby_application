import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_decorations.dart';
import 'glass_card.dart';


/// Modern Glossy Search Bar with filter action button inspired by modern healthcare UI
class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final VoidCallback? onFilterTap;

  const CustomSearchBar({
    super.key,
    this.hintText = 'Search doctors, treatments, patients...',
    this.controller,
    this.onChanged,
    this.onClear,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      borderRadius: 24,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: AppDecorations.glossyIconBoxDecoration(
              color: AppColors.primaryDark,
              isDark: isDark,
              borderRadius: 12,
            ),
            child: const Icon(
              Icons.search_rounded,
              color: AppColors.primaryDark,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w400,
                  color: isDark
                      ? AppColors.textMutedDark
                      : AppColors.textMutedLight,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          if (controller != null && controller!.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.close_rounded, size: 18),
              color: AppColors.textMutedLight,
              onPressed: () {
                controller?.clear();
                if (onClear != null) onClear!();
                if (onChanged != null) onChanged!('');
              },
            ),
          Container(
            margin: const EdgeInsets.only(left: 4),
            decoration: AppDecorations.glossyIconBoxDecoration(
              color: AppColors.primary,
              isDark: isDark,
              borderRadius: 14,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.tune_rounded,
                color: AppColors.primaryDark,
                size: 20,
              ),
              onPressed: onFilterTap ?? () {},
              tooltip: 'Filter',
            ),
          ),
        ],
      ),
    );
  }

}
