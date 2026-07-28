import '../../core/constants/app_enums.dart';

class InvoiceItem {
  final String description;
  final int quantity;
  final double unitPrice;

  const InvoiceItem({
    required this.description,
    required this.quantity,
    required this.unitPrice,
  });

  double get totalPrice => quantity * unitPrice;
}

class InvoiceModel {
  final String id;
  final String invoiceNumber;
  final String patientId;
  final String patientName;
  final DateTime issueDate;
  final DateTime dueDate;
  final List<InvoiceItem> items;
  final PaymentStatus status;
  final double discount;

  const InvoiceModel({
    required this.id,
    required this.invoiceNumber,
    required this.patientId,
    required this.patientName,
    required this.issueDate,
    required this.dueDate,
    required this.items,
    required this.status,
    this.discount = 0.0,
  });

  double get subtotal => items.fold(0.0, (sum, item) => sum + item.totalPrice);
  double get totalAmount => (subtotal - discount).clamp(0, double.infinity);

  InvoiceModel copyWith({
    String? id,
    String? invoiceNumber,
    String? patientId,
    String? patientName,
    DateTime? issueDate,
    DateTime? dueDate,
    List<InvoiceItem>? items,
    PaymentStatus? status,
    double? discount,
  }) {
    return InvoiceModel(
      id: id ?? this.id,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      patientId: patientId ?? this.patientId,
      patientName: patientName ?? this.patientName,
      issueDate: issueDate ?? this.issueDate,
      dueDate: dueDate ?? this.dueDate,
      items: items ?? this.items,
      status: status ?? this.status,
      discount: discount ?? this.discount,
    );
  }
}
