import 'package:flutter/material.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/language_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/theme_provider.dart';
import '../../core/utils/app_localizations.dart';
import '../../shared/widgets/confirmation_dialog.dart';
import '../../shared/widgets/custom_app_bar.dart';
import '../../shared/widgets/glass_card.dart';
import '../../shared/widgets/settings_tile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;

  void _showLanguageDialog() {
    final langProvider = LanguageInheritedWidget.of(context);
    final loc = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Text(loc.translate('language')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(loc.translate('english')),
                leading: Icon(
                  langProvider.locale.languageCode == 'en'
                      ? Icons.check_circle_rounded
                      : Icons.radio_button_unchecked_rounded,
                  color: AppColors.primary,
                ),
                onTap: () {
                  langProvider.setLanguage('en');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(loc.translate('arabic')),
                leading: Icon(
                  langProvider.locale.languageCode == 'ar'
                      ? Icons.check_circle_rounded
                      : Icons.radio_button_unchecked_rounded,
                  color: AppColors.primary,
                ),
                onTap: () {
                  langProvider.setLanguage('ar');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPrivacyPolicy() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Privacy Policy'),
        content: const SingleChildScrollView(
          child: Text(
            'Sharaby Center Clinic System complies with HIPAA and international data protection laws. All patient data, prescriptions, and medical records are encrypted end-to-end and stored securely in cloud servers.',
            style: TextStyle(height: 1.4),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeInheritedWidget.of(context);
    final langProvider = LanguageInheritedWidget.of(context);
    final isDark = themeProvider.isDarkMode;
    final loc = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: CustomAppBar(
        title: loc.translate('settingsTitle'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          children: [
            // Theme Section
            SettingsTile(
              title: loc.translate('appearance'),
              subtitle: isDark ? 'Dark mode enabled' : 'Light sky mode active',
              icon: isDark ? Icons.dark_mode_rounded : Icons.wb_sunny_rounded,
              iconColor: AppColors.primary,
              trailing: Switch(
                value: isDark,
                onChanged: (val) => themeProvider.toggleTheme(),
              ),
            ),

            // Language Section
            SettingsTile(
              title: loc.translate('language'),
              subtitle: langProvider.isArabic ? 'العربية' : 'English',
              icon: Icons.language_rounded,
              iconColor: AppColors.accent,
              onTap: _showLanguageDialog,
            ),

            // Notifications Section
            SettingsTile(
              title: loc.translate('notifications'),
              subtitle: 'Appointment alerts and system updates',
              icon: Icons.notifications_active_rounded,
              iconColor: AppColors.info,
              trailing: Switch(
                value: _notificationsEnabled,
                onChanged: (val) {
                  setState(() => _notificationsEnabled = val);
                },
              ),
            ),

            // Privacy Policy
            SettingsTile(
              title: loc.translate('privacy'),
              subtitle: 'Data protection and HIPAA terms',
              icon: Icons.security_rounded,
              iconColor: AppColors.success,
              onTap: _showPrivacyPolicy,
            ),

            // About Section
            SettingsTile(
              title: loc.translate('about'),
              subtitle: 'Sharaby Center Clinic Management System',
              icon: Icons.info_outline_rounded,
              iconColor: AppColors.warning,
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'Sharaby Center',
                  applicationVersion: '1.0.0',
                  applicationIcon: const Icon(
                    Icons.local_hospital_rounded,
                    color: AppColors.primary,
                    size: 40,
                  ),
                );
              },
            ),

            // App Version Card
            GlassCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              margin: const EdgeInsets.only(bottom: 16),
              borderRadius: 18,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.verified_user_rounded,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        loc.translate('version'),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimaryLight,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'LATEST',
                      style: TextStyle(
                        color: AppColors.success,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Logout Button
            Container(
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: AppColors.error.withValues(alpha: 0.3),
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => ConfirmationDialog(
                        title: 'Sign Out',
                        content:
                            'Are you sure you want to log out of Sharaby Center?',
                        confirmText: 'Logout',
                        onConfirm: () async {
                          await AuthService().signOut();
                        },
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.logout_rounded, color: AppColors.error),
                      const SizedBox(width: 8),
                      Text(
                        loc.translate('navLogout').toUpperCase(),
                        style: const TextStyle(
                          color: AppColors.error,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}