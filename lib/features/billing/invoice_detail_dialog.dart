import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_enums.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/formatters.dart';
import '../../shared/models/invoice_model.dart';
import '../../shared/repositories/billing_repository.dart';

class InvoiceDetailDialog extends StatelessWidget {
  final InvoiceModel invoice;
  final VoidCallback onStatusUpdated;

  const InvoiceDetailDialog({
    super.key,
    required this.invoice,
    required this.onStatusUpdated,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final repo = MockBillingRepository();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: isDark ? AppColors.cardDark : AppColors.cardLight,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppConstants.appName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    Text('Billing Statement', style: TextStyle(fontSize: 12, color: Colors.grey)),
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
                Text(invoice.invoiceNumber, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('Status: ${invoice.status.name.toUpperCase()}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: invoice.status == PaymentStatus.paid ? AppColors.success : AppColors.warning,
                    )),
              ],
            ),
            const SizedBox(height: 12),

            Text('Patient: ${invoice.patientName}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('Issue Date: ${AppFormatters.formatDate(invoice.issueDate)}', style: const TextStyle(color: Colors.grey, fontSize: 13)),
            const SizedBox(height: 16),

            const Text('Itemized Services:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            ...invoice.items.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item.description),
                    Text('\$${item.totalPrice.toStringAsFixed(2)}'),
                  ],
                ),
              );
            }),

            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Amount:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(
                  AppFormatters.formatCurrency(invoice.totalAmount),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary),
                ),
              ],
            ),
            const SizedBox(height: 24),

            if (invoice.status != PaymentStatus.paid)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await repo.updateInvoiceStatus(invoice.id, PaymentStatus.paid);
                    onStatusUpdated();
                    if (context.mounted) Navigator.pop(context);
                  },
                  icon: const Icon(Icons.check_circle_rounded),
                  label: const Text('MARK AS PAID'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success,
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
