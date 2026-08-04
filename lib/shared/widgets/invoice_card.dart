import 'package:flutter/material.dart';
import '../../core/constants/app_enums.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/formatters.dart';
import '../models/invoice_model.dart';
import 'medical_card.dart';
import 'protected_financial_text.dart';

/// Invoice summary card for billing module with financial security protection
class InvoiceCard extends StatelessWidget {
  final InvoiceModel invoice;
  final VoidCallback? onTap;

  const InvoiceCard({
    super.key,
    required this.invoice,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color statusColor;
    String statusLabel;
    switch (invoice.status) {
      case PaymentStatus.paid:
        statusColor = AppColors.success;
        statusLabel = 'PAID';
        break;
      case PaymentStatus.outstanding:
        statusColor = AppColors.warning;
        statusLabel = 'UNPAID';
        break;
      case PaymentStatus.overdue:
        statusColor = AppColors.error;
        statusLabel = 'OVERDUE';
        break;
      case PaymentStatus.partiallyPaid:
        statusColor = AppColors.accent;
        statusLabel = 'PARTIAL';
        break;
    }

    return MedicalCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                invoice.invoiceNumber,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  statusLabel,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      invoice.patientName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Due: ${AppFormatters.formatDate(invoice.dueDate)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark
                            ? AppColors.textMutedDark
                            : AppColors.textMutedLight,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              ProtectedFinancialText(
                actualValue: AppFormatters.formatCurrency(invoice.totalAmount),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.primaryDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
