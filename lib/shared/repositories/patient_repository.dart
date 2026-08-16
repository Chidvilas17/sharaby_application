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
      fullName: 'Adam Mohamed',
      age: 4,
      gender: PatientGender.male,
      phone: '+20 101 234 5678',
      email: 'mohamed.ali@email.com',
      bloodType: 'A+',
      status: PatientStatus.active,
      lastVisitDate: '02 Aug 2026',
      medicalHistory: 'Acute Tonsillitis, Routine Growth Assessment',
      allergies: 'Penicillin',
      emergencyContact: 'Mohamed Ali (Father) - +20 101 234 5678',
      fatherName: 'Mohamed Ali Hassan',
      motherName: 'Fatima Mahmoud',
      guardianPhone: '+20 101 234 5678',
      weight: '17 kg',
      height: '102 cm',
      growthStatus: 'Normal Development (50th percentile)',
      vaccinationStatus: 'Up to Date',
    ),
    const PatientModel(
      id: 'P1002',
      fullName: 'Lina Ahmed',
      age: 7,
      gender: PatientGender.female,
      phone: '+20 102 987 6543',
      email: 'ahmed.m@email.com',
      bloodType: 'O+',
      status: PatientStatus.active,
      lastVisitDate: '08 Aug 2026',
      medicalHistory: 'Mild Pediatric Asthma, Seasonal Rhinitis',
      allergies: 'Dust Mites',
      emergencyContact: 'Ahmed Mahmoud (Father) - +20 102 987 6543',
      fatherName: 'Ahmed Mahmoud',
      motherName: 'Nour El-Din Hassan',
      guardianPhone: '+20 102 987 6543',
      weight: '24 kg',
      height: '122 cm',
      growthStatus: 'Healthy Growth (75th percentile)',
      vaccinationStatus: 'Completed Primary Series',
    ),
    const PatientModel(
      id: 'P1003',
      fullName: 'Youssef Ali',
      age: 2,
      gender: PatientGender.male,
      phone: '+20 105 555 4321',
      email: 'ali.ibrahim@email.com',
      bloodType: 'B+',
      status: PatientStatus.emergency,
      lastVisitDate: '10 Aug 2026',
      medicalHistory: 'Acute Otitis Media, High Fever',
      allergies: 'None',
      emergencyContact: 'Ali Ibrahim (Father) - +20 105 555 4321',
      fatherName: 'Ali Ibrahim',
      motherName: 'Mona Zaki',
      guardianPhone: '+20 105 555 4321',
      weight: '12 kg',
      height: '86 cm',
      growthStatus: 'Normal Development (60th percentile)',
      vaccinationStatus: 'MMR Booster Due',
    ),
    const PatientModel(
      id: 'P1004',
      fullName: 'Nour Hassan',
      age: 1,
      gender: PatientGender.female,
      phone: '+20 104 333 2211',
      email: 'hassan.o@email.com',
      bloodType: 'O-',
      status: PatientStatus.active,
      lastVisitDate: '01 Aug 2026',
      medicalHistory: 'Infant Teething Rash, Routine Checkup',
      allergies: 'Egg Whites',
      emergencyContact: 'Hassan Omar (Father) - +20 104 333 2211',
      fatherName: 'Hassan Omar',
      motherName: 'Reem Khaled',
      guardianPhone: '+20 104 333 2211',
      weight: '8.5 kg',
      height: '71 cm',
      growthStatus: 'Healthy Infant (45th percentile)',
      vaccinationStatus: '9-Month Vaccine Completed',
    ),
    const PatientModel(
      id: 'P1005',
      fullName: 'Omar Youssef',
      age: 12,
      gender: PatientGender.male,
      phone: '+20 109 888 7766',
      email: 'youssef.t@email.com',
      bloodType: 'AB+',
      status: PatientStatus.inactive,
      lastVisitDate: '15 Jun 2026',
      medicalHistory: 'Adolescent Growth Assessment, Sports Physical',
      allergies: 'Peanuts',
      emergencyContact: 'Youssef Tarek (Father) - +20 109 888 7766',
      fatherName: 'Youssef Tarek',
      motherName: 'Salma Tarek',
      guardianPhone: '+20 109 888 7766',
      weight: '42 kg',
      height: '148 cm',
      growthStatus: 'Growth Spurt Phase',
      vaccinationStatus: 'Up to Date',
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
