import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Reusable Glassmorphism & Shadow Decorations for Sharaby Center
class AppDecorations {
  static BoxDecoration glassBoxDecoration({
    required bool isDark,
    double borderRadius = 20,
    Color? customColor,
    Border? border,
  }) {
    return BoxDecoration(
      color: customColor ??
          (isDark ? AppColors.glassSurfaceDark : AppColors.glassSurfaceLight),
      borderRadius: BorderRadius.circular(borderRadius),
      border: border ??
          Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.1)
                : Colors.white.withValues(alpha: 0.6),
            width: 1.5,
          ),
      boxShadow: [
        BoxShadow(
          color: isDark
              ? Colors.black.withValues(alpha: 0.3)
              : AppColors.primary.withValues(alpha: 0.08),
          blurRadius: 20,
          spreadRadius: 2,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }

  static BoxDecoration cardBoxDecoration({
    required bool isDark,
    double borderRadius = 18,
    Color? borderColor,
  }) {
    return BoxDecoration(
      color: isDark ? AppColors.cardDark : AppColors.cardLight,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: borderColor ??
            (isDark
                ? Colors.white.withValues(alpha: 0.05)
                : const Color(0xFFE2E8F0)),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: isDark
              ? Colors.black.withValues(alpha: 0.2)
              : Colors.black.withValues(alpha: 0.04),
          blurRadius: 15,
          offset: const Offset(0, 4),
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
              color: AppColors.primary.withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
    );
  }
}
