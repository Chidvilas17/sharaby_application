import 'package:flutter/material.dart';
import '../../core/constants/app_enums.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/models/invoice_model.dart';
import '../../shared/models/patient_model.dart';
import '../../shared/repositories/billing_repository.dart';
import '../../shared/repositories/patient_repository.dart';
import '../../shared/widgets/gradient_button.dart';

class CreateInvoiceDialog extends StatefulWidget {
  final VoidCallback onCreated;

  const CreateInvoiceDialog({
    super.key,
    required this.onCreated,
  });

  @override
  State<CreateInvoiceDialog> createState() => _CreateInvoiceDialogState();
}

class _CreateInvoiceDialogState extends State<CreateInvoiceDialog> {
  final PatientRepository _patientRepo = MockPatientRepository();
  final BillingRepository _billingRepo = MockBillingRepository();

  List<PatientModel> _patients = [];
  PatientModel? _selectedPatient;
  final _serviceCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();

  final List<InvoiceItem> _items = [
    const InvoiceItem(description: 'Specialist Consultation', quantity: 1, unitPrice: 150.0),
  ];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadPatients();
  }

  Future<void> _loadPatients() async {
    final list = await _patientRepo.getPatients();
    if (mounted && list.isNotEmpty) {
      setState(() {
        _patients = list;
        _selectedPatient = list.first;
      });
    }
  }

  void _addItem() {
    if (_serviceCtrl.text.trim().isEmpty) return;
    final price = double.tryParse(_priceCtrl.text.trim()) ?? 50.0;
    setState(() {
      _items.add(InvoiceItem(
        description: _serviceCtrl.text.trim(),
        quantity: 1,
        unitPrice: price,
      ));
      _serviceCtrl.clear();
      _priceCtrl.clear();
    });
  }

  Future<void> _submit() async {
    if (_selectedPatient == null || _items.isEmpty) return;
    setState(() => _isLoading = true);

    final inv = InvoiceModel(
      id: 'INV-${100 + DateTime.now().millisecond}',
      invoiceNumber: 'INV-2026-${100 + DateTime.now().millisecond}',
      patientId: _selectedPatient!.id,
      patientName: _selectedPatient!.fullName,
      issueDate: DateTime.now(),
      dueDate: DateTime.now().add(const Duration(days: 7)),
      items: List.from(_items),
      status: PaymentStatus.outstanding,
    );

    await _billingRepo.addInvoice(inv);
    widget.onCreated();

    if (mounted) {
      setState(() => _isLoading = false);
      Navigator.pop(context);
    }
  }

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Create Patient Invoice',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),

            if (_patients.isNotEmpty)
              DropdownButtonFormField<PatientModel>(
                initialValue: _selectedPatient,
                decoration: const InputDecoration(labelText: 'Select Patient'),
                items: _patients.map((p) {
                  return DropdownMenuItem(value: p, child: Text(p.fullName));
                }).toList(),
                onChanged: (v) {
                  if (v != null) setState(() => _selectedPatient = v);
                },
              ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _serviceCtrl,
                    decoration: const InputDecoration(labelText: 'Medical Service'),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 90,
                  child: TextField(
                    controller: _priceCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Price (\$)'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_rounded, color: AppColors.primary, size: 32),
                  onPressed: _addItem,
                ),
              ],
            ),
            const SizedBox(height: 16),

            const Text('Line Items:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ..._items.map((item) {
              return ListTile(
                title: Text(item.description),
                trailing: Text('\$${item.totalPrice.toStringAsFixed(2)}'),
              );
            }),
            const SizedBox(height: 24),

            GradientButton(
              text: 'GENERATE INVOICE',
              isLoading: _isLoading,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
