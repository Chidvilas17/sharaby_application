import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_decorations.dart';
import '../../core/utils/app_localizations.dart';
import '../../shared/widgets/animated_glass_background.dart';
import '../../shared/widgets/custom_app_bar.dart';
import '../../shared/widgets/glass_card.dart';

/// Doctor Tools Placeholder Screen (Option 3)
class DoctorToolsScreen extends StatelessWidget {
  const DoctorToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loc = AppLocalizations.of(context);
    final lang = Localizations.localeOf(context).languageCode;

    final List<Map<String, dynamic>> tools = [
      {
        'titleEn': 'Patient Clinical Tools',
        'titleAr': 'أدوات المريض الطبية',
        'subEn': 'Vitals tracking & clinical calculators',
        'subAr': 'حاسبات التقييم الطبي وتتبع القياسات',
        'icon': Icons.healing_rounded,
        'color': AppColors.primaryDark,
      },
      {
        'titleEn': 'Prescription Dosing Calculator',
        'titleAr': 'حاسبة جرعات الروشتات للأطفال',
        'subEn': 'Weight-based pediatric dosing engine',
        'subAr': 'محرك حساب الجرعات بحسب وزن الطفل',
        'icon': Icons.calculate_rounded,
        'color': AppColors.accent,
      },
      {
        'titleEn': 'Clinical Consultation Notes',
        'titleAr': 'ملاحظات الكشف العيادي',
        'subEn': 'Structured SOAP clinical templates',
        'subAr': 'قوالب تدوين الفحص الكلينيكي السريع',
        'icon': Icons.edit_note_rounded,
        'color': AppColors.warning,
      },
      {
        'titleEn': 'Pediatric Growth Velocity Tools',
        'titleAr': 'أدوات متابعة معدل النمو',
        'subEn': 'WHO percentile velocity calculators',
        'subAr': 'حساب سرعة النمو مقارنة بالمنحنيات الدولية',
        'icon': Icons.straighten_rounded,
        'color': AppColors.success,
      },
      {
        'titleEn': 'Visit Summary Generator',
        'titleAr': 'مولد ملخص الزيارة الطبية',
        'subEn': 'Instant PDF visit notes for parents',
        'subAr': 'إنشاء ملخص PDF مطبوع لأولياء الأمور',
        'icon': Icons.picture_as_pdf_rounded,
        'color': AppColors.primaryDark,
      },
    ];

    return AnimatedGlassBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          title: loc.translate('doctorToolsTitle'),
          showBackButton: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Banner Note
                GlassCard(
                  padding: const EdgeInsets.all(18),
                  borderRadius: 22,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: AppDecorations.glossyIconBoxDecoration(
                          color: AppColors.primaryDark,
                          isDark: isDark,
                          isCircle: true,
                        ),
                        child: const Icon(
                          Icons.medical_services_rounded,
                          color: AppColors.primaryDark,
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              loc.translate('doctorToolsTitle'),
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: isDark
                                    ? AppColors.textPrimaryDark
                                    : AppColors.primaryDark,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              loc.translate('comingSoonDesc'),
                              style: TextStyle(
                                fontSize: 12.5,
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
                const SizedBox(height: 20),

                // Placeholder Cards List
                Column(
                  children: tools.map((tool) {
                    final title = lang == 'ar' ? tool['titleAr'] : tool['titleEn'];
                    final sub = lang == 'ar' ? tool['subAr'] : tool['subEn'];
                    final IconData icon = tool['icon'];
                    final Color color = tool['color'];

                    return GlassCard(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      borderRadius: 20,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: AppDecorations.glossyIconBoxDecoration(
                              color: color,
                              isDark: isDark,
                              borderRadius: 14,
                            ),
                            child: Icon(icon, color: color, size: 22),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: isDark
                                        ? AppColors.textPrimaryDark
                                        : AppColors.primaryDark,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  sub,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark
                                        ? AppColors.textMutedDark
                                        : AppColors.textMutedLight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 9, vertical: 4),
                            decoration: AppDecorations.glossyPillBoxDecoration(
                              color: AppColors.warning,
                              isDark: isDark,
                              borderRadius: 10,
                            ),
                            child: Text(
                              loc.translate('comingSoonTag'),
                              style: const TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.bold,
                                color: AppColors.warning,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
