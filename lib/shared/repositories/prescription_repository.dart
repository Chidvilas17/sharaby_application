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
      patientName: 'Mohamed Ali Hassan',
      doctorName: 'Dr. Ahmed Sharaby',
      issueDate: DateTime.now().subtract(const Duration(days: 2)),
      diagnosis: 'Essential Hypertension & Type 2 Diabetes',
      doctorNotes: 'Monitor blood glucose twice daily. Maintain low sodium diet.',
      medicines: const [
        MedicineItem(
          medicineName: 'Metformin HCl 500mg',
          dosage: '1 Tablet',
          frequency: 'Twice daily after meals',
          duration: '30 Days',
          instructions: 'Take with full glass of water',
        ),
        MedicineItem(
          medicineName: 'Amlodipine Besylate 5mg',
          dosage: '1 Tablet',
          frequency: 'Once daily in the morning',
          duration: '30 Days',
          instructions: 'Do not skip doses',
        ),
      ],
    ),
    PrescriptionModel(
      id: 'RX-7002',
      patientId: 'P1002',
      patientName: 'Sarah Mahmoud',
      doctorName: 'Dr. Ahmed Sharaby',
      issueDate: DateTime.now(),
      diagnosis: 'Acute Bronchial Spasm',
      doctorNotes: 'Use inhaler as needed before workouts.',
      medicines: const [
        MedicineItem(
          medicineName: 'Ventolin HFA Inhaler 100mcg',
          dosage: '2 Puffs',
          frequency: 'Every 4-6 hours as needed',
          duration: '14 Days',
          instructions: 'Rinse mouth after inhalation',
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
