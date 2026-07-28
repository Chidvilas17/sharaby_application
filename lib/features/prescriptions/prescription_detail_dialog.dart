import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/formatters.dart';
import '../../shared/models/prescription_model.dart';

class PrescriptionDetailDialog extends StatelessWidget {
  final PrescriptionModel prescription;

  const PrescriptionDetailDialog({
    super.key,
    required this.prescription,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: isDark ? AppColors.cardDark : AppColors.cardLight,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Clinic Branding
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppConstants.appName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      AppConstants.clinicAddress,
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Rx #: ${prescription.id}', style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(AppFormatters.formatDate(prescription.issueDate), style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 12),

            Text('Patient: ${prescription.patientName}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('Doctor: ${prescription.doctorName}', style: const TextStyle(color: AppColors.primary)),
            Text('Diagnosis: ${prescription.diagnosis}', style: const TextStyle(fontSize: 13, color: Colors.grey)),
            const SizedBox(height: 16),

            const Text('Rx Medicines:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 8),

            ...prescription.medicines.map((m) {
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.medication_rounded, color: AppColors.primary),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(m.medicineName, style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text('${m.dosage} • ${m.frequency} • ${m.duration}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 16),

            if (prescription.doctorNotes.isNotEmpty) ...[
              const Text('Doctor Remarks:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(prescription.doctorNotes, style: const TextStyle(fontStyle: FontStyle.italic)),
              const SizedBox(height: 20),
            ],

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sent prescription to printer...')),
                  );
                },
                icon: const Icon(Icons.print_rounded),
                label: const Text('PRINT PRESCRIPTION'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
