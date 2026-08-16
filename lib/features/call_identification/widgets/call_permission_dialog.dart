import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_decorations.dart';
import '../../../core/utils/app_localizations.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/gradient_button.dart';

/// Glossy Permission Dialog explaining Patient Call Identification permission requirement
class CallPermissionDialog extends StatelessWidget {
  const CallPermissionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loc = AppLocalizations.of(context);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: GlassCard(
        padding: const EdgeInsets.all(24),
        borderRadius: 26,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 3D Glossy Icon Orb
            Container(
              padding: const EdgeInsets.all(16),
              decoration: AppDecorations.glossyIconBoxDecoration(
                color: AppColors.primaryDark,
                isDark: isDark,
                isCircle: true,
              ),
              child: const Icon(
                Icons.phone_callback_rounded,
                color: AppColors.primaryDark,
                size: 36,
              ),
            ),
            const SizedBox(height: 18),

            // Title
            Text(
              loc.translate('callPermissionExplainTitle'),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textPrimaryDark : AppColors.primaryDark,
              ),
            ),
            const SizedBox(height: 12),

            // Description
            Text(
              loc.translate('callPermissionExplainDesc'),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.5,
                height: 1.45,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              ),
            ),
            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(
                      loc.translate('close'),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: GradientButton(
                    text: loc.translate('grantPermissionButton'),
                    icon: Icons.shield_rounded,
                    height: 48,
                    borderRadius: 24,
                    onPressed: () async {
                      final status = await Permission.phone.request();
                      if (context.mounted) {
                        Navigator.pop(context, status.isGranted);
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
