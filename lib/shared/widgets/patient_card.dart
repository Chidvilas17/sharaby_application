import 'package:flutter/material.dart';
import '../../core/constants/app_enums.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_decorations.dart';
import '../models/patient_model.dart';
import 'glass_card.dart';


/// Patient Card with avatar badge, status tags, and glass finish
class PatientCard extends StatelessWidget {
  final PatientModel patient;
  final VoidCallback? onTap;

  const PatientCard({
    super.key,
    required this.patient,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color statusColor;
    String statusLabel;
    switch (patient.status) {
      case PatientStatus.active:
        statusColor = AppColors.success;
        statusLabel = 'Active';
        break;
      case PatientStatus.emergency:
        statusColor = AppColors.error;
        statusLabel = 'Emergency';
        break;
      case PatientStatus.inactive:
        statusColor = AppColors.textMutedLight;
        statusLabel = 'Inactive';
        break;
    }

    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      borderRadius: 22,
      child: Row(
        children: [
          // Avatar with 3D glowing ring
          Container(
            padding: const EdgeInsets.all(2.5),
            decoration: AppDecorations.glossyIconBoxDecoration(
              color: AppColors.primaryDark,
              isDark: isDark,
              isCircle: true,
            ),
            child: CircleAvatar(
              radius: 24,
              backgroundColor: isDark ? AppColors.cardDark : Colors.white,
              child: Text(
                patient.fullName.characters.first,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          // Patient info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        patient.fullName,
                        style: TextStyle(
                          fontSize: 15.5,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimaryLight,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 9, vertical: 4),
                      decoration: AppDecorations.glossyPillBoxDecoration(
                        color: statusColor,
                        isDark: isDark,
                        borderRadius: 12,
                      ),
                      child: Text(
                        statusLabel,
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${patient.gender.name.toUpperCase()} • ${patient.age} yrs • Blood: ${patient.bloodType}',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.history_rounded,
                      size: 13,
                      color: AppColors.primaryDark,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Last Visit: ${patient.lastVisitDate}',
                      style: TextStyle(
                        fontSize: 11.5,
                        color: isDark
                            ? AppColors.textMutedDark
                            : AppColors.textMutedLight,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(7),
            decoration: AppDecorations.glossyIconBoxDecoration(
              color: AppColors.primaryDark,
              isDark: isDark,
              isCircle: true,
            ),
            child: const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.primaryDark,
              size: 18,
            ),
          ),
        ],
      ),
    );

  }
}
