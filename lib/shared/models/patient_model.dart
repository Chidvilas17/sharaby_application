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
    );
  }
}
