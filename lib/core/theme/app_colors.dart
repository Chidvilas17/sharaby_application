import 'package:flutter/material.dart';

/// Centralized Color Palette for Sharaby Center Clinic Management System
class AppColors {
  // Primary Palette
  static const Color primary = Color(0xFF4A90E2);
  static const Color primaryDark = Color(0xFF2C68C7);
  static const Color primaryLight = Color(0xFF82B1EF);

  // Secondary & Accent Palette
  static const Color secondary = Color(0xFF64B5F6);
  static const Color accent = Color(0xFF26C6DA);
  static const Color accentLight = Color(0xFF80DEEA);

  // Background Colors
  static const Color backgroundLight = Color(0xFFF4F8FC);
  static const Color backgroundDark = Color(0xFF0F172A);

  // Card & Surface Colors
  static const Color cardLight = Colors.white;
  static const Color cardDark = Color(0xFF1E293B);
  static const Color glassSurfaceLight = Color(0xCCFFFFFF);
  static const Color glassSurfaceDark = Color(0xCC1E293B);

  // Text Colors
  static const Color textPrimaryLight = Color(0xFF1E293B);
  static const Color textSecondaryLight = Color(0xFF64748B);
  static const Color textMutedLight = Color(0xFF94A3B8);

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

  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFDBEAFE);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF4A90E2), Color(0xFF64B5F6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFF4A90E2), Color(0xFF26C6DA)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF1E40AF), Color(0xFF3B82F6), Color(0xFF26C6DA)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient glassGradientLight = LinearGradient(
    colors: [Color(0xE6FFFFFF), Color(0x99FFFFFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient glassGradientDark = LinearGradient(
    colors: [Color(0xE61E293B), Color(0x991E293B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
