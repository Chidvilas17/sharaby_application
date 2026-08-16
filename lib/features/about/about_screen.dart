import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_localizations.dart';
import '../../shared/widgets/animated_glass_background.dart';
import '../../shared/widgets/custom_app_bar.dart';
import '../../shared/widgets/medical_card.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: loc.translate('navAbout'),
      ),
      body: AnimatedGlassBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              children: [
                // Logo & Branding Hero
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    gradient: AppColors.heroGradient,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.35),
                      width: 1.5,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.shadowBlue,
                        blurRadius: 20,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.shadowBlue,
                              blurRadius: 16,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: 60,
                          height: 60,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        loc.translate('appName'),
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${loc.translate('version')} (${AppConstants.appVersion})',
                        style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // App Specs Card
                MedicalCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'System Information',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.textPrimaryDark : AppColors.primaryDark,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const ListTile(
                        leading: Icon(Icons.cloud_done_rounded, color: AppColors.success),
                        title: Text('Authentication Backend'),
                        subtitle: Text('Firebase Authentication (Active)'),
                      ),
                      const ListTile(
                        leading: Icon(Icons.dns_rounded, color: AppColors.primaryDark),
                        title: Text('Database Standard'),
                        subtitle: Text('SQL Server / Arabic Unicode Support'),
                      ),
                      const ListTile(
                        leading: Icon(Icons.developer_mode_rounded, color: AppColors.accent),
                        title: Text('Framework & Design System'),
                        subtitle: Text('Flutter • Apple VisionOS Glassmorphism Architecture'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Expandable Privacy & Terms
                MedicalCard(
                  child: ExpansionTile(
                    leading: const Icon(Icons.privacy_tip_rounded, color: AppColors.primaryDark),
                    title: Text(loc.translate('privacy')),
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Sharaby Center Pediatric Clinic System enforces end-to-end data encryption for pediatric health records in accordance with medical data privacy guidelines.',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),

                    ],
                  ),
                ),
                const SizedBox(height: 12),

                MedicalCard(
                  child: ExpansionTile(
                    leading: const Icon(Icons.gavel_rounded, color: AppColors.accent),
                    title: const Text('Terms of Service'),
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Authorized clinical personnel only. Unauthorized access, export, or distribution of patient records is strictly prohibited.',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}