import 'package:flutter/material.dart';

/// Data model representing an application usage guide Q&A item
class AppHelpItem {
  final String id;
  final String categoryKey;
  final String categoryEnglish;
  final String categoryArabic;
  final String questionEnglish;
  final String questionArabic;
  final String answerEnglish;
  final String answerArabic;
  final IconData icon;

  const AppHelpItem({
    required this.id,
    required this.categoryKey,
    required this.categoryEnglish,
    required this.categoryArabic,
    required this.questionEnglish,
    required this.questionArabic,
    required this.answerEnglish,
    required this.answerArabic,
    this.icon = Icons.help_outline_rounded,
  });

  String getCategory(String lang) =>
      lang == 'ar' ? categoryArabic : categoryEnglish;

  String getQuestion(String lang) =>
      lang == 'ar' ? questionArabic : questionEnglish;

  String getAnswer(String lang) =>
      lang == 'ar' ? answerArabic : answerEnglish;
}
