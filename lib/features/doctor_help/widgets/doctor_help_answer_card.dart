import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_decorations.dart';
import '../../../core/utils/app_localizations.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../doctor_help_item.dart';

/// Detailed Answer Display Card with mandatory Clinical Safety Disclaimer box
class DoctorHelpAnswerCard extends StatelessWidget {
  final DoctorHelpItem item;
  final String languageCode;
  final VoidCallback onClear;

  const DoctorHelpAnswerCard({
    super.key,
    required this.item,
    required this.languageCode,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loc = AppLocalizations.of(context);

    return Column(
      children: [
        GlassCard(
          padding: const EdgeInsets.all(20),
          borderRadius: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Pill & Icon Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: AppDecorations.glossyPillBoxDecoration(
                      color: AppColors.accent,
                      isDark: isDark,
                      borderRadius: 12,
                    ),
                    child: Text(
                      item.getCategory(languageCode),
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.bold,
                        color: AppColors.accent,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: AppDecorations.glossyIconBoxDecoration(
                      color: AppColors.primaryDark,
                      isDark: isDark,
                      isCircle: true,
                    ),
                    child: Icon(
                      item.icon,
                      color: AppColors.primaryDark,
                      size: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Question Title
              Text(
                item.getQuestion(languageCode),
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.primaryDark,
                ),
              ),

              const SizedBox(height: 16),
              Divider(
                height: 1,
                color: isDark
                    ? Colors.white.withValues(alpha: 0.12)
                    : const Color(0xFFE2E8F0),
              ),
              const SizedBox(height: 16),

              // Answer Body
              Text(
                item.getAnswer(languageCode),
                style: TextStyle(
                  fontSize: 14.5,
                  height: 1.55,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textPrimaryLight,
                ),
              ),

              const SizedBox(height: 20),

              // Clinical Safety Disclaimer Box
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.warning.withValues(alpha: 0.35),
                    width: 1.2,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.shield_outlined,
                      color: AppColors.warning,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            loc.translate('clinicalDisclaimerTitle'),
                            style: const TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.bold,
                              color: AppColors.warning,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            loc.translate('clinicalDisclaimerDesc'),
                            style: TextStyle(
                              fontSize: 11.5,
                              height: 1.35,
                              color: isDark
                                  ? AppColors.textSecondaryDark
                                  : AppColors.textSecondaryLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Back to Questions Button
        GradientButton(
          text: loc.translate('backToQuestions'),
          icon: Icons.arrow_back_rounded,
          onPressed: onClear,
          height: 50,
          borderRadius: 25,
        ),
      ],
    );
  }
}
