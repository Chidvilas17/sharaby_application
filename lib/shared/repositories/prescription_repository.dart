import '../models/prescription_model.dart';

abstract class PrescriptionRepository {
  Future<List<PrescriptionModel>> getPrescriptions();
  Future<void> addPrescription(PrescriptionModel prescription);
}

class MockPrescriptionRepository implements PrescriptionRepository {
  final List<PrescriptionModel> _prescriptions = [
    PrescriptionModel(
      id: 'RX-7001',
      patientId: 'P1001',
      patientName: 'Adam Mohamed',
      doctorName: 'Dr. Ahmed Sharaby',
      issueDate: DateTime.now().subtract(const Duration(days: 2)),
      diagnosis: 'Acute Tonsillitis & High Fever',
      doctorNotes: 'Administer pediatric syrup after food. Ensure adequate hydration.',
      medicines: const [
        MedicineItem(
          medicineName: 'Paracetamol Pediatric Drops (100mg/ml)',
          dosage: '1.5 ml',
          frequency: 'Every 6 hours as needed for fever',
          duration: '3 Days',
          instructions: 'Administer using calibrated oral syringe',
        ),
        MedicineItem(
          medicineName: 'Amoxicillin Oral Suspension (250mg/5ml)',
          dosage: '5 ml',
          frequency: 'Twice daily after meals',
          duration: '7 Days',
          instructions: 'Shake bottle well before use',
        ),
      ],
    ),
    PrescriptionModel(
      id: 'RX-7002',
      patientId: 'P1002',
      patientName: 'Lina Ahmed',
      doctorName: 'Dr. Ahmed Sharaby',
      issueDate: DateTime.now(),
      diagnosis: 'Mild Pediatric Asthma & Cough',
      doctorNotes: 'Use inhaler with pediatric mask spacer before physical activity.',
      medicines: const [
        MedicineItem(
          medicineName: 'Salbutamol Inhaler (100mcg/dose)',
          dosage: '2 Puffs with Pediatric Spacer',
          frequency: 'Every 6 hours as needed',
          duration: '14 Days',
          instructions: 'Rinse mouth with water after use',
        ),
        MedicineItem(
          medicineName: 'Vitamin D3 Pediatric Drops (400 IU)',
          dosage: '4 Drops',
          frequency: 'Once daily in the morning',
          duration: '30 Days',
          instructions: 'Give directly or mix with milk',
        ),
      ],
    ),
  ];


  @override
  Future<List<PrescriptionModel>> getPrescriptions() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_prescriptions);
  }

  @override
  Future<void> addPrescription(PrescriptionModel prescription) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _prescriptions.insert(0, prescription);
  }
}
