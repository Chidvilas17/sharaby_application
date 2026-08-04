import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_localizations.dart';

/// Floating Modern Glassmorphism Bottom Navigation Bar for rapid module switching
class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loc = AppLocalizations.of(context);

    final primaryItems = [
      {'label': loc.translate('navDashboard'), 'icon': Icons.grid_view_rounded},
      {'label': loc.translate('navPatients'), 'icon': Icons.people_alt_rounded},
      {'label': loc.translate('navAppointments'), 'icon': Icons.calendar_month_rounded},
      {'label': loc.translate('navPrescriptions'), 'icon': Icons.description_rounded},
      {'label': loc.translate('navBilling'), 'icon': Icons.receipt_long_rounded},
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(14, 0, 14, 14),
      height: 66,
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.glassSurfaceDark
            : AppColors.glassSurfaceLight,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowBlue,
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
          BoxShadow(
            color: AppColors.glowBlue,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: isDark
              ? AppColors.glassBorderDark
              : AppColors.glassBorderLight,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(primaryItems.length, (index) {
          final isSelected = selectedIndex == index;
          final item = primaryItems[index];

          return GestureDetector(
            onTap: () => onTabSelected(index),
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withValues(alpha: 0.18)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    item['icon'] as IconData,
                    color: isSelected
                        ? AppColors.primaryDark
                        : (isDark
                            ? AppColors.textMutedDark
                            : AppColors.textMutedLight),
                    size: 22,
                  ),
                  if (isSelected) ...[
                    const SizedBox(width: 6),
                    Text(
                      item['label'] as String,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
