import '../../core/constants/app_enums.dart';
import '../models/invoice_model.dart';

abstract class BillingRepository {
  Future<List<InvoiceModel>> getInvoices();
  Future<void> addInvoice(InvoiceModel invoice);
  Future<void> updateInvoiceStatus(String id, PaymentStatus status);
}

class MockBillingRepository implements BillingRepository {
  final List<InvoiceModel> _invoices = [
    InvoiceModel(
      id: 'INV-401',
      invoiceNumber: 'INV-2026-001',
      patientId: 'P1001',
      patientName: 'Mohamed Ali Hassan',
      issueDate: DateTime.now().subtract(const Duration(days: 5)),
      dueDate: DateTime.now().add(const Duration(days: 10)),
      status: PaymentStatus.paid,
      discount: 20.0,
      items: const [
        InvoiceItem(description: 'Specialist Consultation Fee', quantity: 1, unitPrice: 150.0),
        InvoiceItem(description: 'Fasting Blood Glucose Test', quantity: 1, unitPrice: 40.0),
        InvoiceItem(description: 'HbA1c Lab Panel', quantity: 1, unitPrice: 60.0),
      ],
    ),
    InvoiceModel(
      id: 'INV-402',
      invoiceNumber: 'INV-2026-002',
      patientId: 'P1002',
      patientName: 'Sarah Mahmoud',
      issueDate: DateTime.now().subtract(const Duration(days: 1)),
      dueDate: DateTime.now().add(const Duration(days: 7)),
      status: PaymentStatus.outstanding,
      discount: 0.0,
      items: const [
        InvoiceItem(description: 'General Examination', quantity: 1, unitPrice: 120.0),
        InvoiceItem(description: 'Pulmonary Function Screening', quantity: 1, unitPrice: 85.0),
      ],
    ),
    InvoiceModel(
      id: 'INV-403',
      invoiceNumber: 'INV-2026-003',
      patientId: 'P1003',
      patientName: 'Youssef Ibrahim',
      issueDate: DateTime.now().subtract(const Duration(days: 15)),
      dueDate: DateTime.now().subtract(const Duration(days: 2)),
      status: PaymentStatus.overdue,
      discount: 0.0,
      items: const [
        InvoiceItem(description: 'Emergency Cardiac Triage', quantity: 1, unitPrice: 250.0),
        InvoiceItem(description: 'ECG 12-Lead Diagnostic', quantity: 1, unitPrice: 110.0),
      ],
    ),
  ];

  @override
  Future<List<InvoiceModel>> getInvoices() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_invoices);
  }

  @override
  Future<void> addInvoice(InvoiceModel invoice) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _invoices.insert(0, invoice);
  }

  @override
  Future<void> updateInvoiceStatus(String id, PaymentStatus status) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _invoices.indexWhere((i) => i.id == id);
    if (index != -1) {
      _invoices[index] = _invoices[index].copyWith(status: status);
    }
  }
}
