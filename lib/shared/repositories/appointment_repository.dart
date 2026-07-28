import '../../core/constants/app_enums.dart';
import '../models/appointment_model.dart';

abstract class AppointmentRepository {
  Future<List<AppointmentModel>> getAppointments();
  Future<void> addAppointment(AppointmentModel appointment);
  Future<void> updateAppointment(AppointmentModel appointment);
  Future<void> cancelAppointment(String id);
}

class MockAppointmentRepository implements AppointmentRepository {
  final List<AppointmentModel> _appointments = [
    AppointmentModel(
      id: 'APT-901',
      patientId: 'P1002',
      patientName: 'Sarah Mahmoud',
      doctorName: 'Dr. Ahmed Sharaby',
      dateTime: DateTime.now(),
      timeSlot: '09:30 AM',
      reason: 'General Consultation & Vitals Check',
      status: AppointmentStatus.inProgress,
      department: 'Internal Medicine',
    ),
    AppointmentModel(
      id: 'APT-902',
      patientId: 'P1001',
      patientName: 'Mohamed Ali Hassan',
      doctorName: 'Dr. Ahmed Sharaby',
      dateTime: DateTime.now(),
      timeSlot: '10:45 AM',
      reason: 'Diabetes Follow-up & Prescription Review',
      status: AppointmentStatus.confirmed,
      department: 'Endocrinology',
    ),
    AppointmentModel(
      id: 'APT-903',
      patientId: 'P1003',
      patientName: 'Youssef Ibrahim',
      doctorName: 'Dr. Mona Zaki',
      dateTime: DateTime.now(),
      timeSlot: '11:30 AM',
      reason: 'ECG Analysis & Cardiac Consultation',
      status: AppointmentStatus.pending,
      department: 'Cardiology',
    ),
    AppointmentModel(
      id: 'APT-904',
      patientId: 'P1004',
      patientName: 'Mariam Ahmed',
      doctorName: 'Dr. Ahmed Sharaby',
      dateTime: DateTime.now().add(const Duration(days: 1)),
      timeSlot: '02:00 PM',
      reason: 'Routine Annual Bloodwork Review',
      status: AppointmentStatus.confirmed,
      department: 'General Practice',
    ),
    AppointmentModel(
      id: 'APT-905',
      patientId: 'P1005',
      patientName: 'Khaled El-Sayed',
      doctorName: 'Dr. Hassan Omar',
      dateTime: DateTime.now().subtract(const Duration(days: 1)),
      timeSlot: '04:15 PM',
      reason: 'Joint Stiffness Evaluation',
      status: AppointmentStatus.completed,
      department: 'Orthopedics',
    ),
  ];

  @override
  Future<List<AppointmentModel>> getAppointments() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_appointments);
  }

  @override
  Future<void> addAppointment(AppointmentModel appointment) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _appointments.insert(0, appointment);
  }

  @override
  Future<void> updateAppointment(AppointmentModel appointment) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _appointments.indexWhere((a) => a.id == appointment.id);
    if (index != -1) {
      _appointments[index] = appointment;
    }
  }

  @override
  Future<void> cancelAppointment(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _appointments.indexWhere((a) => a.id == id);
    if (index != -1) {
      _appointments[index] = _appointments[index].copyWith(
        status: AppointmentStatus.cancelled,
      );
    }
  }
}
