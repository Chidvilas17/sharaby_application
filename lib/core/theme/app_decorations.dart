import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Reusable Glassmorphism & Glossy Neumorphic Design System for Sharaby Center
class AppDecorations {
  /// Ultra-Glossy Neumorphic Glass Box Decoration
  static BoxDecoration glassBoxDecoration({
    required bool isDark,
    double borderRadius = 22,
    Color? customColor,
    Border? border,
    List<BoxShadow>? shadows,
  }) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: isDark
            ? [
                customColor ?? const Color(0xF01E293B),
                customColor?.withValues(alpha: 0.8) ?? const Color(0xD00F172A),
              ]
            : [
                customColor ?? const Color(0xFAFFFFFF),
                customColor?.withValues(alpha: 0.85) ?? const Color(0xDFE0F2FE),
              ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(borderRadius),
      border: border ??
          Border.all(
            color: isDark ? AppColors.glassBorderDark : AppColors.glassBorderLight,
            width: 1.5,
          ),
      boxShadow: shadows ??
          [
            // Soft Top Ambient Light Source Glow
            BoxShadow(
              color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white.withValues(alpha: 0.75),
              blurRadius: 10,
              spreadRadius: -2,
              offset: const Offset(0, -3),
            ),
            // Deep Ambient Blue Drop Shadow
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.45)
                  : const Color(0x1F0284C7),
              blurRadius: 22,
              spreadRadius: 0,
              offset: const Offset(0, 8),
            ),
            // Subtle Ambient Cyan Glow Ring
            BoxShadow(
              color: AppColors.glowBlue,
              blurRadius: 14,
              spreadRadius: -3,
              offset: const Offset(0, 4),
            ),
          ],
    );
  }

  /// Glossy 3D Raised Icon Badge Container Decoration
  static BoxDecoration glossyIconBoxDecoration({
    required Color color,
    required bool isDark,
    double borderRadius = 16,
    bool isCircle = false,
  }) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: isDark
            ? [
                color.withValues(alpha: 0.35),
                color.withValues(alpha: 0.15),
              ]
            : [
                Colors.white,
                color.withValues(alpha: 0.18),
              ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: isCircle ? null : BorderRadius.circular(borderRadius),
      shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
      border: Border.all(
        color: isDark
            ? color.withValues(alpha: 0.45)
            : Colors.white.withValues(alpha: 0.9),
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.white.withValues(alpha: isDark ? 0.05 : 0.8),
          blurRadius: 6,
          spreadRadius: -1,
          offset: const Offset(0, -2),
        ),
        BoxShadow(
          color: color.withValues(alpha: isDark ? 0.4 : 0.25),
          blurRadius: 12,
          spreadRadius: 0,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  /// Glossy Mini-Pill Badge Decoration (Trends, Statuses, Tags)
  static BoxDecoration glossyPillBoxDecoration({
    required Color color,
    required bool isDark,
    double borderRadius = 14,
  }) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: isDark ? 0.3 : 0.18),
          color.withValues(alpha: isDark ? 0.15 : 0.08),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: color.withValues(alpha: isDark ? 0.5 : 0.35),
        width: 1.2,
      ),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.15),
          blurRadius: 8,
          spreadRadius: -1,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  /// Standard Card Decoration
  static BoxDecoration cardBoxDecoration({
    required bool isDark,
    double borderRadius = 22,
    Color? borderColor,
  }) {
    return glassBoxDecoration(
      isDark: isDark,
      borderRadius: borderRadius,
    );
  }

  /// Gradient Card Decoration
  static BoxDecoration gradientBoxDecoration({
    required Gradient gradient,
    double borderRadius = 24,
    List<BoxShadow>? shadows,
  }) {
    return BoxDecoration(
      gradient: gradient,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.4),
        width: 1.5,
      ),
      boxShadow: shadows ??
          [
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.4),
              blurRadius: 8,
              spreadRadius: -2,
              offset: const Offset(0, -2),
            ),
            BoxShadow(
              color: AppColors.primaryDark.withValues(alpha: 0.3),
              blurRadius: 20,
              spreadRadius: 0,
              offset: const Offset(0, 8),
            ),
          ],
    );
  }
}

