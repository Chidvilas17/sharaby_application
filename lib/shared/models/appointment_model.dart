import '../../core/constants/app_enums.dart';

class AppointmentModel {
  final String id;
  final String patientId;
  final String patientName;
  final String doctorName;
  final DateTime dateTime;
  final String timeSlot;
  final String reason;
  final AppointmentStatus status;
  final String department;

  const AppointmentModel({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.doctorName,
    required this.dateTime,
    required this.timeSlot,
    required this.reason,
    required this.status,
    required this.department,
  });

  AppointmentModel copyWith({
    String? id,
    String? patientId,
    String? patientName,
    String? doctorName,
    DateTime? dateTime,
    String? timeSlot,
    String? reason,
    AppointmentStatus? status,
    String? department,
  }) {
    return AppointmentModel(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      patientName: patientName ?? this.patientName,
      doctorName: doctorName ?? this.doctorName,
      dateTime: dateTime ?? this.dateTime,
      timeSlot: timeSlot ?? this.timeSlot,
      reason: reason ?? this.reason,
      status: status ?? this.status,
      department: department ?? this.department,
    );
  }
}
