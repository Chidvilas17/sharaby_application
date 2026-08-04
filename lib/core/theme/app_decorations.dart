import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Reusable Glassmorphism & Glossy Soft Blue Shadows for Sharaby Center
class AppDecorations {
  static BoxDecoration glassBoxDecoration({
    required bool isDark,
    double borderRadius = 20,
    Color? customColor,
    Border? border,
    List<BoxShadow>? shadows,
  }) {
    return BoxDecoration(
      color: customColor ??
          (isDark ? AppColors.glassSurfaceDark : AppColors.glassSurfaceLight),
      borderRadius: BorderRadius.circular(borderRadius),
      border: border ??
          Border.all(
            color: isDark
                ? AppColors.glassBorderDark
                : AppColors.glassBorderLight,
            width: 1.5,
          ),
      boxShadow: shadows ??
          [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.35)
                  : AppColors.shadowBlue,
              blurRadius: 24,
              spreadRadius: 0,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: AppColors.glowBlue,
              blurRadius: 12,
              spreadRadius: -4,
              offset: const Offset(0, 4),
            ),
          ],
    );
  }

  static BoxDecoration cardBoxDecoration({
    required bool isDark,
    double borderRadius = 20,
    Color? borderColor,
  }) {
    return BoxDecoration(
      color: isDark ? AppColors.cardDark : AppColors.cardLight,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: borderColor ??
            (isDark
                ? AppColors.glassBorderDark
                : AppColors.glassBorderLight),
        width: 1.2,
      ),
      boxShadow: [
        BoxShadow(
          color: isDark
              ? Colors.black.withValues(alpha: 0.25)
              : AppColors.shadowBlue,
          blurRadius: 18,
          offset: const Offset(0, 6),
        ),
      ],
    );
  }

  static BoxDecoration gradientBoxDecoration({
    required Gradient gradient,
    double borderRadius = 20,
    List<BoxShadow>? shadows,
  }) {
    return BoxDecoration(
      gradient: gradient,
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: shadows ??
          [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.35),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
    );
  }
}
