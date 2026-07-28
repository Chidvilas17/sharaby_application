/// Core Enums for Sharaby Center
enum UserRole {
  doctor,
  receptionist,
  clinicStaff,
  admin,
}

enum PatientGender {
  male,
  female,
  other,
}

enum PatientStatus {
  active,
  inactive,
  emergency,
}

enum AppointmentStatus {
  confirmed,
  inProgress,
  pending,
  completed,
  cancelled,
}

enum PaymentStatus {
  paid,
  outstanding,
  overdue,
  partiallyPaid,
}

enum DocumentCategory {
  labResult,
  xRay,
  prescription,
  medicalReport,
  generalDocument,
}
