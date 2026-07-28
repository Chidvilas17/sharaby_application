import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Typography hierarchy for Sharaby Center Clinic
class AppTypography {
  static TextStyle headlineLarge(bool isDark) => TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
      );

  static TextStyle headlineMedium(bool isDark) => TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.3,
        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
      );

  static TextStyle titleLarge(bool isDark) => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
      );

  static TextStyle titleMedium(bool isDark) => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
      );

  static TextStyle bodyLarge(bool isDark) => TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
      );

  static TextStyle bodyMedium(bool isDark) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: isDark
            ? AppColors.textSecondaryDark
            : AppColors.textSecondaryLight,
      );

  static TextStyle labelSmall(bool isDark) => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
      );
}
