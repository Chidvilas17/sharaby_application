import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/financial_security_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_localizations.dart';
import 'confirmation_dialog.dart';
import 'drawer_tile.dart';

/// Floating Glassmorphic Navigation Drawer inspired by Apple VisionOS & modern SaaS UI
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
    final loc = AppLocalizations.of(context);

    final List<Map<String, dynamic>> menuItems = [
      {
        'index': 0,
        'title': loc.translate('navDashboard'),
        'icon': Icons.grid_view_rounded,
      },
      {
        'index': 1,
        'title': loc.translate('navPatients'),
        'icon': Icons.people_alt_rounded,
      },
      {
        'index': 2,
        'title': loc.translate('navAppointments'),
        'icon': Icons.calendar_month_rounded,
      },
      {
        'index': 3,
        'title': loc.translate('navPrescriptions'),
        'icon': Icons.description_rounded,
      },
      {
        'index': 4,
        'title': loc.translate('navBilling'),
        'icon': Icons.receipt_long_rounded,
      },
      {
        'index': 5,
        'title': loc.translate('navReports'),
        'icon': Icons.analytics_rounded,
      },
      {
        'index': 6,
        'title': loc.translate('navDocuments'),
        'icon': Icons.folder_shared_rounded,
      },
      {
        'index': 7,
        'title': loc.translate('navNotifications'),
        'icon': Icons.notifications_active_rounded,
        'badge': '5',
      },
      {
        'index': 8,
        'title': loc.translate('navProfile'),
        'icon': Icons.person_rounded,
      },
      {
        'index': 9,
        'title': loc.translate('navSettings'),
        'icon': Icons.settings_rounded,
      },
      {
        'index': 10,
        'title': loc.translate('navAbout'),
        'icon': Icons.info_outline_rounded,
      },
    ];

    return Drawer(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.fromLTRB(12, 12, 0, 12),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.glassSurfaceDark
                : AppColors.glassSurfaceLight,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: isDark
                  ? AppColors.glassBorderDark
                  : AppColors.glassBorderLight,
              width: 1.5,
            ),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadowBlue,
                blurRadius: 30,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Column(
                children: [
                  // Floating Profile Header with Official Logo & Doctor info
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      onItemSelected(8); // Profile tab
                    },
                    child: Container(
                      margin: const EdgeInsets.all(12),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        gradient: AppColors.heroGradient,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.35),
                          width: 1.5,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.shadowBlue,
                            blurRadius: 14,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              radius: 22,
                              backgroundColor: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Image.asset(
                                  'assets/images/logo.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  AppConstants.defaultDoctorName,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  loc.translate('doctorRole'),
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 11,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right_rounded,
                            color: Colors.white70,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(height: 1, indent: 20, endIndent: 20),

                  // Navigation Items List
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: menuItems.length,
                      itemBuilder: (context, index) {
                        final item = menuItems[index];
                        final itemIdx = item['index'] as int;
                        final isSelected = selectedIndex == itemIdx;

                        return DrawerTile(
                          title: item['title'] as String,
                          icon: item['icon'] as IconData,
                          isSelected: isSelected,
                          badge: item['badge'] as String?,
                          onTap: () {
                            Navigator.pop(context);
                            onItemSelected(itemIdx);
                          },
                        );
                      },
                    ),
                  ),

                  const Divider(height: 1, indent: 20, endIndent: 20),
                  // Logout Button
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.error.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        leading: const Icon(
                          Icons.logout_rounded,
                          color: AppColors.error,
                        ),
                        title: Text(
                          loc.translate('navLogout'),
                          style: const TextStyle(
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
                              title: loc.translate('confirmSignOutTitle'),
                              content: loc.translate('confirmSignOutDesc'),
                              confirmText: loc.translate('navLogout'),
                              onConfirm: () async {
                                FinancialSecurityService().resetOnLogout();
                                await AuthService().signOut();
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
