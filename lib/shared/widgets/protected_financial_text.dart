import 'package:flutter/material.dart';
import '../../core/services/financial_security_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_localizations.dart';

/// Reusable Protected Financial Text Widget with PIN verification dialog
class ProtectedFinancialText extends StatelessWidget {
  final String actualValue;
  final TextStyle? style;
  final bool showEyeIcon;
  final MainAxisSize mainAxisSize;

  const ProtectedFinancialText({
    super.key,
    required this.actualValue,
    this.style,
    this.showEyeIcon = true,
    this.mainAxisSize = MainAxisSize.min,
  });

  void _showSecurityDialog(BuildContext context) {
    final pinController = TextEditingController();
    String? errorMessage;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final loc = AppLocalizations.of(context);
            final isDark = Theme.of(context).brightness == Brightness.dark;

            return AlertDialog(
              backgroundColor: isDark ? AppColors.cardDark : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.lock_outline_rounded,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      loc.translate('enterSecurityCode'),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc.translate('securityCodePrompt'),
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: pinController,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      letterSpacing: 8,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: '••••',
                      errorText: errorMessage,
                      filled: true,
                      fillColor: isDark
                          ? AppColors.glassSurfaceDark
                          : AppColors.primaryLight.withValues(alpha: 0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: AppColors.glassBorderLight),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: AppColors.primary, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Text(loc.translate('cancel')),
                ),
                ElevatedButton(
                  onPressed: () {
                    final pin = pinController.text.trim();
                    final success = FinancialSecurityService().unlock(pin);
                    if (success) {
                      Navigator.pop(dialogContext);
                    } else {
                      setDialogState(() {
                        errorMessage = loc.translate('incorrectSecurityCode');
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    loc.translate('verify'),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final securityService = FinancialSecurityInheritedWidget.of(context);
    final isRevealed = securityService.isRevealed;

    final defaultStyle = style ??
        const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryDark,
        );

    // Format display string
    final displayValue = isRevealed ? actualValue : "EGP ••••••••";

    return InkWell(
      onTap: () {
        if (!isRevealed) {
          _showSecurityDialog(context);
        } else {
          securityService.lock();
        }
      },
      borderRadius: BorderRadius.circular(8),
      child: Row(
        mainAxisSize: mainAxisSize,
        children: [
          Flexible(
            child: Text(
              displayValue,
              style: defaultStyle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (showEyeIcon) ...[
            const SizedBox(width: 6),
            Icon(
              isRevealed ? Icons.visibility_outlined : Icons.visibility_off_outlined,
              size: (defaultStyle.fontSize ?? 16) * 0.9,
              color: isRevealed ? AppColors.primary : AppColors.textMutedLight,
            ),
          ],
        ],
      ),
    );
  }
}
