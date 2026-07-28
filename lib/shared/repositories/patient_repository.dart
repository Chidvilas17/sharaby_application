import '../../core/constants/app_enums.dart';
import '../models/patient_model.dart';

abstract class PatientRepository {
  Future<List<PatientModel>> getPatients();
  Future<PatientModel?> getPatientById(String id);
  Future<void> addPatient(PatientModel patient);
  Future<void> updatePatient(PatientModel patient);
  Future<void> deletePatient(String id);
}

class MockPatientRepository implements PatientRepository {
  final List<PatientModel> _patients = [
    const PatientModel(
      id: 'P1001',
      fullName: 'Mohamed Ali Hassan',
      age: 42,
      gender: PatientGender.male,
      phone: '+20 101 234 5678',
      email: 'mohamed.ali@email.com',
      bloodType: 'A+',
      status: PatientStatus.active,
      lastVisitDate: '24 Jul 2026',
      medicalHistory: 'Hypertension, Type 2 Diabetes',
      allergies: 'Penicillin',
      emergencyContact: 'Fatma Ali (Wife) - +20 102 345 6789',
    ),
    const PatientModel(
      id: 'P1002',
      fullName: 'Sarah Mahmoud',
      age: 29,
      gender: PatientGender.female,
      phone: '+20 102 987 6543',
      email: 'sarah.m@email.com',
      bloodType: 'O+',
      status: PatientStatus.active,
      lastVisitDate: '28 Jul 2026',
      medicalHistory: 'Mild Asthma',
      allergies: 'Dust, Sulfa Drugs',
      emergencyContact: 'Omar Mahmoud (Brother) - +20 103 456 7890',
    ),
    const PatientModel(
      id: 'P1003',
      fullName: 'Youssef Ibrahim',
      age: 55,
      gender: PatientGender.male,
      phone: '+20 105 555 4321',
      email: 'youssef.ibrahim@email.com',
      bloodType: 'B+',
      status: PatientStatus.emergency,
      lastVisitDate: '28 Jul 2026',
      medicalHistory: 'Coronary Artery Disease, High Cholesterol',
      allergies: 'Aspirin',
      emergencyContact: 'Nour Ibrahim (Daughter) - +20 106 666 5432',
    ),
    const PatientModel(
      id: 'P1004',
      fullName: 'Mariam Ahmed',
      age: 34,
      gender: PatientGender.female,
      phone: '+20 104 333 2211',
      email: 'mariam.ahmed@email.com',
      bloodType: 'AB-',
      status: PatientStatus.active,
      lastVisitDate: '20 Jul 2026',
      medicalHistory: 'Routine Checkup',
      allergies: 'None',
      emergencyContact: 'Tarek Ahmed (Husband) - +20 107 777 8899',
    ),
    const PatientModel(
      id: 'P1005',
      fullName: 'Khaled El-Sayed',
      age: 61,
      gender: PatientGender.male,
      phone: '+20 109 888 7766',
      email: 'khaled.sayed@email.com',
      bloodType: 'O-',
      status: PatientStatus.inactive,
      lastVisitDate: '10 Jun 2026',
      medicalHistory: 'Osteoarthritis',
      allergies: 'NSAIDs',
      emergencyContact: 'Salma Khaled (Daughter) - +20 108 999 0000',
    ),
  ];

  @override
  Future<List<PatientModel>> getPatients() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_patients);
  }

  @override
  Future<PatientModel?> getPatientById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return _patients.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> addPatient(PatientModel patient) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _patients.insert(0, patient);
  }

  @override
  Future<void> updatePatient(PatientModel patient) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _patients.indexWhere((p) => p.id == patient.id);
    if (index != -1) {
      _patients[index] = patient;
    }
  }

  @override
  Future<void> deletePatient(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _patients.removeWhere((p) => p.id == id);
  }
}
