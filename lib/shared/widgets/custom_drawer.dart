import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/services/auth_service.dart';
import '../../core/theme/app_colors.dart';
import 'confirmation_dialog.dart';

/// Reusable Glassmorphism Side Drawer with doctor info header and menu items
class CustomDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomDrawer({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final menuItems = [
      {'title': 'Dashboard', 'icon': Icons.dashboard_rounded},
      {'title': 'Patients', 'icon': Icons.people_alt_rounded},
      {'title': 'Appointments', 'icon': Icons.calendar_month_rounded},
      {'title': 'Prescriptions', 'icon': Icons.description_rounded},
      {'title': 'Billing', 'icon': Icons.receipt_long_rounded},
      {'title': 'Reports', 'icon': Icons.analytics_rounded},
      {'title': 'Documents', 'icon': Icons.folder_shared_rounded},
      {'title': 'Profile', 'icon': Icons.person_rounded},
      {'title': 'Settings', 'icon': Icons.settings_rounded},
      {'title': 'About', 'icon': Icons.info_outline_rounded},
    ];

    return Drawer(
      backgroundColor: isDark ? AppColors.backgroundDark : Colors.white,
      child: Column(
        children: [
          // Doctor & Clinic Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 24),
            decoration: const BoxDecoration(
              gradient: AppColors.heroGradient,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const CircleAvatar(
                        radius: 28,
                        backgroundColor: AppColors.primaryLight,
                        child: Icon(
                          Icons.local_hospital_rounded,
                          size: 32,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppConstants.appName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            AppConstants.defaultDoctorName,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'DOCTOR / CLINIC ADMIN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Navigation Items List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                final isSelected = selectedIndex == index;

                return Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary.withValues(alpha: 0.12)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    dense: true,
                    leading: Icon(
                      item['icon'] as IconData,
                      color: isSelected
                          ? AppColors.primary
                          : (isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight),
                    ),
                    title: Text(
                      item['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.w500,
                        color: isSelected
                            ? AppColors.primary
                            : (isDark
                                ? AppColors.textPrimaryDark
                                : AppColors.textPrimaryLight),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      onItemSelected(index);
                    },
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          // Logout Option
          Padding(
            padding: const EdgeInsets.all(12),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              tileColor: AppColors.error.withValues(alpha: 0.08),
              leading: const Icon(Icons.logout_rounded, color: AppColors.error),
              title: const Text(
                'Logout',
                style: TextStyle(
                  color: AppColors.error,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) => ConfirmationDialog(
                    title: 'Sign Out',
                    content: 'Are you sure you want to sign out of Sharaby Center?',
                    confirmText: 'Logout',
                    onConfirm: () async {
                      await AuthService().signOut();
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
