import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'glass_card.dart';
import 'protected_financial_text.dart';

/// Reusable Glassmorphism Stat Card for Dashboard Metrics
class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String? trend;
  final bool isPositive;
  final bool isFinancial;
  final VoidCallback? onTap;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.trend,
    this.isPositive = true,
    this.isFinancial = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final checkFinancial = isFinancial || value.contains('EGP') || value.contains('\$');
    final formattedValue = value.replaceAll('\$', 'EGP ');

    final valueStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      letterSpacing: -0.5,
      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
    );

    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.all(14),
      borderRadius: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: color.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              if (trend != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: (isPositive ? AppColors.success : AppColors.error)
                        .withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isPositive
                            ? Icons.trending_up_rounded
                            : Icons.trending_down_rounded,
                        size: 13,
                        color: isPositive ? AppColors.success : AppColors.error,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        trend!,
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.bold,
                          color: isPositive ? AppColors.success : AppColors.error,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          checkFinancial
              ? ProtectedFinancialText(
                  actualValue: formattedValue,
                  style: valueStyle,
                )
              : Text(
                  formattedValue,
                  style: valueStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
          const SizedBox(height: 2),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
            ),
          ),
        ],
      ),
    );
  }
}
