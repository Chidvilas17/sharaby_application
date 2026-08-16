import 'package:flutter/material.dart';

/// Data model representing a predefined pediatric clinical Q&A item
class DoctorHelpItem {
  final String id;
  final String categoryKey;
  final String categoryEnglish;
  final String categoryArabic;
  final String questionEnglish;
  final String questionArabic;
  final String answerEnglish;
  final String answerArabic;
  final IconData icon;

  const DoctorHelpItem({
    required this.id,
    required this.categoryKey,
    required this.categoryEnglish,
    required this.categoryArabic,
    required this.questionEnglish,
    required this.questionArabic,
    required this.answerEnglish,
    required this.answerArabic,
    this.icon = Icons.health_and_safety_rounded,
  });

  /// Get category depending on current language code ('en' or 'ar')
  String getCategory(String lang) =>
      lang == 'ar' ? categoryArabic : categoryEnglish;

  /// Get question depending on current language code ('en' or 'ar')
  String getQuestion(String lang) =>
      lang == 'ar' ? questionArabic : questionEnglish;

  /// Get answer depending on current language code ('en' or 'ar')
  String getAnswer(String lang) =>
      lang == 'ar' ? answerArabic : answerEnglish;
}
