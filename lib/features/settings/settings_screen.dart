import 'package:flutter/material.dart';
import '../../core/services/auth_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/theme_provider.dart';
import '../../shared/widgets/confirmation_dialog.dart';
import '../../shared/widgets/medical_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeInheritedWidget.of(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('System Settings'),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded, color: AppColors.primary),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Appearance & Theme Group
            MedicalCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Appearance & Theme',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary),
                  ),
                  const SizedBox(height: 8),
                  SwitchListTile(
                    secondary: Icon(
                      isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                      color: AppColors.primary,
                    ),
                    title: const Text('Dark Mode Theme'),
                    subtitle: Text(isDark ? 'Dark glass mode active' : 'Light clinical mode active'),
                    value: isDark,
                    activeThumbColor: AppColors.primary,
                    onChanged: (val) {
                      themeProvider.toggleTheme();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Notifications & Language
            MedicalCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Preferences',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary),
                  ),
                  const SizedBox(height: 8),
                  SwitchListTile(
                    secondary: const Icon(Icons.notifications_active_rounded, color: AppColors.accent),
                    title: const Text('Appointment Alerts'),
                    subtitle: const Text('Receive sound and popup notifications'),
                    value: _notificationsEnabled,
                    activeThumbColor: AppColors.accent,
                    onChanged: (val) {
                      setState(() => _notificationsEnabled = val);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.language_rounded, color: AppColors.success),
                    title: const Text('System Language'),
                    subtitle: const Text('English (US)'),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Security Group
            MedicalCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Account & Security',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary),
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    leading: const Icon(Icons.lock_reset_rounded, color: AppColors.warning),
                    title: const Text('Change Account Password'),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Password change triggered.')),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Sign Out Button
            ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => ConfirmationDialog(
                    title: 'Sign Out',
                    content: 'Are you sure you want to log out of Sharaby Center?',
                    confirmText: 'Sign Out',
                    onConfirm: () async {
                      await AuthService().signOut();
                    },
                  ),
                );
              },
              icon: const Icon(Icons.logout_rounded),
              label: const Text('SIGN OUT OF APPLICATION'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}