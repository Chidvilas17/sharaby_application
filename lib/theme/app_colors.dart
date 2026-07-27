import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xff4A90E2);
  static const Color secondary = Color(0xff64B5F6);
  static const Color accent = Color(0xff26C6DA);

  static const Color background = Color(0xffF5F9FD);

  static const Color card = Colors.white;

  static const Color textDark = Color(0xff263238);

  static const Color textLight = Color(0xff607D8B);

  static const LinearGradient headerGradient =
  LinearGradient(
    colors: [
      Color(0xff4A90E2),
      Color(0xff64B5F6),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}