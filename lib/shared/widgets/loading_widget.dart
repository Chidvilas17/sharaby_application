import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'glass_card.dart';

/// Glassmorphism Loading Widget featuring official Sharaby logo
class LoadingWidget extends StatelessWidget {
  final String message;

  const LoadingWidget({
    super.key,
    this.message = 'Loading data...',
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
        borderRadius: 20,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                const SizedBox(
                  width: 56,
                  height: 56,
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                    strokeWidth: 3,
                  ),
                ),
                Image.asset(
                  'assets/images/logo.png',
                  width: 28,
                  height: 28,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
