import 'package:flutter/material.dart';

/// Centralized Color Palette for Sharaby Center Healthcare Application
/// Modern Glossy Sky Blue, Azure & Cyan Apple VisionOS Theme
class AppColors {
  // Primary Palette (Sky Blue & Azure)
  static const Color primary = Color(0xFF38BDF8); // Sky Blue
  static const Color primaryDark = Color(0xFF0284C7); // Azure Deep Blue
  static const Color primaryLight = Color(0xFFE0F2FE); // Ice Blue

  // Secondary & Accent Palette
  static const Color secondary = Color(0xFFFFFFFF); // Pure White
  static const Color accent = Color(0xFF06B6D4); // Soft Cyan
  static const Color accentLight = Color(0xFFCFFAFE);

  // Background Colors
  static const Color backgroundLight = Color(0xFFE0F2FE); // Vibrant Ice Blue
  static const Color backgroundDark = Color(0xFF0B132B); // Deep Navy

  // Card & Surface Colors
  static const Color cardLight = Colors.white;
  static const Color cardDark = Color(0xFF1E293B);
  static const Color glassSurfaceLight = Color(0xEEF0F9FF);
  static const Color glassSurfaceDark = Color(0xDD1E293B);
  static const Color glassBorderLight = Color(0x8038BDF8);
  static const Color glassBorderDark = Color(0x6038BDF8);

  // Glowing & Shadow Colors
  static const Color glowBlue = Color(0x6038BDF8);
  static const Color shadowBlue = Color(0x280284C7);

  // Text Colors
  static const Color textPrimaryLight = Color(0xFF0369A1);
  static const Color textSecondaryLight = Color(0xFF0284C7);
  static const Color textMutedLight = Color(0xFF64748B);

  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFF94A3B8);
  static const Color textMutedDark = Color(0xFF64748B);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFD1FAE5);

  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);

  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);

  static const Color info = Color(0xFF0EA5E9);
  static const Color infoLight = Color(0xFFE0F2FE);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF0284C7), Color(0xFF38BDF8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFF38BDF8), Color(0xFF06B6D4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF0369A1), Color(0xFF0284C7), Color(0xFF38BDF8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient glassGradientLight = LinearGradient(
    colors: [Color(0xF8FFFFFF), Color(0xDCBAE6FD)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient glassGradientDark = LinearGradient(
    colors: [Color(0xFA1E293B), Color(0xB30F172A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
