import 'package:flutter/material.dart';
import '../../core/constants/app_enums.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_decorations.dart';
import '../models/appointment_model.dart';
import 'glass_card.dart';

/// Appointment card displaying patient, time, reason, doctor, and status badge
class AppointmentCard extends StatelessWidget {
  final AppointmentModel appointment;
  final VoidCallback? onTap;
  final VoidCallback? onStatusTap;

  const AppointmentCard({
    super.key,
    required this.appointment,
    this.onTap,
    this.onStatusTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color statusColor;
    String statusLabel;
    switch (appointment.status) {
      case AppointmentStatus.inProgress:
        statusColor = AppColors.accent;
        statusLabel = 'In Progress';
        break;
      case AppointmentStatus.confirmed:
        statusColor = AppColors.success;
        statusLabel = 'Confirmed';
        break;
      case AppointmentStatus.pending:
        statusColor = AppColors.warning;
        statusLabel = 'Pending';
        break;
      case AppointmentStatus.completed:
        statusColor = AppColors.primaryDark;
        statusLabel = 'Completed';
        break;
      case AppointmentStatus.cancelled:
        statusColor = AppColors.error;
        statusLabel = 'Cancelled';
        break;
    }

    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      borderRadius: 22,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: AppDecorations.glossyPillBoxDecoration(
                      color: AppColors.primaryDark,
                      isDark: isDark,
                      borderRadius: 12,
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.access_time_filled_rounded,
                            size: 14, color: AppColors.primaryDark),
                        const SizedBox(width: 6),
                        Text(
                          appointment.timeSlot,
                          style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: onStatusTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: AppDecorations.glossyPillBoxDecoration(
                    color: statusColor,
                    isDark: isDark,
                    borderRadius: 12,
                  ),
                  child: Text(
                    statusLabel,
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            appointment.patientName,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.textPrimaryDark : AppColors.primaryDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            appointment.reason,
            style: TextStyle(
              fontSize: 13,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          Divider(
            height: 1,
            color: isDark ? Colors.white.withValues(alpha: 0.1) : const Color(0xFFE2E8F0),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.medical_services_outlined,
                      size: 14, color: AppColors.primaryDark),
                  const SizedBox(width: 6),
                  Text(
                    appointment.doctorName,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                    ),
                  ),
                ],
              ),
              Text(
                appointment.department,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

