import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_decorations.dart';
import '../../core/utils/app_localizations.dart';
import '../../shared/widgets/animated_glass_background.dart';
import '../../shared/widgets/custom_app_bar.dart';
import '../../shared/widgets/glass_card.dart';

/// Doctor Assistant Placeholder Screen (Option 4)
class DoctorAssistantScreen extends StatelessWidget {
  const DoctorAssistantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loc = AppLocalizations.of(context);
    final lang = Localizations.localeOf(context).languageCode;

    final List<Map<String, dynamic>> assistantFeatures = [
      {
        'titleEn': 'Daily Pediatric Schedule Assistant',
        'titleAr': 'المساعد اليومي لمواعيد العيادة',
        'subEn': 'Automated daily schedule & patient queue overview',
        'subAr': 'تنظيم قائمة المواعيد وقائمة الانتظار اليومية',
        'icon': Icons.today_rounded,
        'color': AppColors.primaryDark,
      },
      {
        'titleEn': 'Patient History Summarizer',
        'titleAr': 'مُلخص التاريخ الطبي للأطفال',
        'subEn': 'Concise 1-page summary of previous clinic visits',
        'subAr': 'ملخص مركز في صفحة واحدة للزيارات السابقة',
        'icon': Icons.analytics_rounded,
        'color': AppColors.accent,
      },
      {
        'titleEn': 'Pediatric Visit Briefing',
        'titleAr': 'إحاطة قبل دخول الطفل للكشف',
        'subEn': 'Pre-visit alerts for vaccinations & growth milestones',
        'subAr': 'تنبيهات فورية للتطعيمات والقياسات قبل الفحص',
        'icon': Icons.notifications_active_rounded,
        'color': AppColors.warning,
      },
      {
        'titleEn': 'Follow-Up Tracking Assistant',
        'titleAr': 'مساعد متابعة الحالات الحرجة والمراجعة',
        'subEn': 'Automated reminders for 24-48h acute cases',
        'subAr': 'تنبيهات المتابعة التلقائية للحالات الحادة',
        'icon': Icons.update_rounded,
        'color': AppColors.success,
      },
      {
        'titleEn': 'Clinical Workspace Assistant',
        'titleAr': 'مساعد مساحة العمل الطبية',
        'subEn': 'Customizable daily clinical shortcuts & tools',
        'subAr': 'اختصارات مخصصة لسير العمل اليومي بالعيادة',
        'icon': Icons.space_dashboard_rounded,
        'color': AppColors.primaryDark,
      },
    ];

    return AnimatedGlassBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          title: loc.translate('doctorAssistantTitle'),
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
                          color: AppColors.accent,
                          isDark: isDark,
                          isCircle: true,
                        ),
                        child: const Icon(
                          Icons.psychology_rounded,
                          color: AppColors.accent,
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              loc.translate('doctorAssistantTitle'),
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

                // Placeholder List
                Column(
                  children: assistantFeatures.map((feat) {
                    final title = lang == 'ar' ? feat['titleAr'] : feat['titleEn'];
                    final sub = lang == 'ar' ? feat['subAr'] : feat['subEn'];
                    final IconData icon = feat['icon'];
                    final Color color = feat['color'];

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
