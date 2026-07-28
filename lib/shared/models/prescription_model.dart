class MedicineItem {
  final String medicineName;
  final String dosage;
  final String frequency;
  final String duration;
  final String instructions;

  const MedicineItem({
    required this.medicineName,
    required this.dosage,
    required this.frequency,
    required this.duration,
    required this.instructions,
  });
}

class PrescriptionModel {
  final String id;
  final String patientId;
  final String patientName;
  final String doctorName;
  final DateTime issueDate;
  final List<MedicineItem> medicines;
  final String doctorNotes;
  final String diagnosis;

  const PrescriptionModel({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.doctorName,
    required this.issueDate,
    required this.medicines,
    required this.doctorNotes,
    required this.diagnosis,
  });
}
