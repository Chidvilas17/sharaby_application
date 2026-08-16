import '../../core/constants/app_enums.dart';

class PatientModel {
  final String id;
  final String fullName;
  final int age;
  final PatientGender gender;
  final String phone;
  final String email;
  final String bloodType;
  final PatientStatus status;
  final String lastVisitDate;
  final String medicalHistory;
  final String allergies;
  final String emergencyContact;

  // Child / Pediatric Specific Fields
  final String fatherName;
  final String motherName;
  final String guardianPhone;
  final String weight;
  final String height;
  final String growthStatus;
  final String vaccinationStatus;

  const PatientModel({
    required this.id,
    required this.fullName,
    required this.age,
    required this.gender,
    required this.phone,
    required this.email,
    required this.bloodType,
    required this.status,
    required this.lastVisitDate,
    required this.medicalHistory,
    required this.allergies,
    required this.emergencyContact,
    this.fatherName = '',
    this.motherName = '',
    this.guardianPhone = '',
    this.weight = '15 kg',
    this.height = '98 cm',
    this.growthStatus = 'Normal Development',
    this.vaccinationStatus = 'Up to Date',
  });

  PatientModel copyWith({
    String? id,
    String? fullName,
    int? age,
    PatientGender? gender,
    String? phone,
    String? email,
    String? bloodType,
    PatientStatus? status,
    String? lastVisitDate,
    String? medicalHistory,
    String? allergies,
    String? emergencyContact,
    String? fatherName,
    String? motherName,
    String? guardianPhone,
    String? weight,
    String? height,
    String? growthStatus,
    String? vaccinationStatus,
  }) {
    return PatientModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      bloodType: bloodType ?? this.bloodType,
      status: status ?? this.status,
      lastVisitDate: lastVisitDate ?? this.lastVisitDate,
      medicalHistory: medicalHistory ?? this.medicalHistory,
      allergies: allergies ?? this.allergies,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      fatherName: fatherName ?? this.fatherName,
      motherName: motherName ?? this.motherName,
      guardianPhone: guardianPhone ?? this.guardianPhone,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      growthStatus: growthStatus ?? this.growthStatus,
      vaccinationStatus: vaccinationStatus ?? this.vaccinationStatus,
    );
  }
}

