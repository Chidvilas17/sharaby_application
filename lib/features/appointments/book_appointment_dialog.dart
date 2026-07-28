import 'package:flutter/material.dart';
import '../../core/constants/app_enums.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/models/appointment_model.dart';
import '../../shared/models/patient_model.dart';
import '../../shared/repositories/appointment_repository.dart';
import '../../shared/repositories/patient_repository.dart';
import '../../shared/widgets/gradient_button.dart';

class BookAppointmentDialog extends StatefulWidget {
  final VoidCallback onBooked;

  const BookAppointmentDialog({
    super.key,
    required this.onBooked,
  });

  @override
  State<BookAppointmentDialog> createState() => _BookAppointmentDialogState();
}

class _BookAppointmentDialogState extends State<BookAppointmentDialog> {
  final _formKey = GlobalKey<FormState>();
  final PatientRepository _patientRepo = MockPatientRepository();
  final AppointmentRepository _appointmentRepo = MockAppointmentRepository();

  List<PatientModel> _patients = [];
  PatientModel? _selectedPatient;
  final String _doctorName = 'Dr. Ahmed Sharaby';
  String _department = 'Internal Medicine';
  String _reason = 'Routine Examination';
  String _timeSlot = '10:00 AM';
  final DateTime _date = DateTime.now();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadPatients();
  }

  Future<void> _loadPatients() async {
    final list = await _patientRepo.getPatients();
    if (mounted && list.isNotEmpty) {
      setState(() {
        _patients = list;
        _selectedPatient = list.first;
      });
    }
  }

  Future<void> _submit() async {
    if (_selectedPatient == null) return;
    setState(() => _isLoading = true);

    final appointment = AppointmentModel(
      id: 'APT-${100 + DateTime.now().millisecond}',
      patientId: _selectedPatient!.id,
      patientName: _selectedPatient!.fullName,
      doctorName: _doctorName,
      dateTime: _date,
      timeSlot: _timeSlot,
      reason: _reason,
      status: AppointmentStatus.confirmed,
      department: _department,
    );

    await _appointmentRepo.addAppointment(appointment);
    widget.onBooked();

    if (mounted) {
      setState(() => _isLoading = false);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: isDark ? AppColors.cardDark : AppColors.cardLight,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Book New Appointment',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Patient Selection
              if (_patients.isNotEmpty)
                DropdownButtonFormField<PatientModel>(
                  initialValue: _selectedPatient,
                  decoration: const InputDecoration(labelText: 'Select Patient', prefixIcon: Icon(Icons.person_outlined)),
                  items: _patients.map((p) {
                    return DropdownMenuItem(value: p, child: Text(p.fullName));
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedPatient = val);
                  },
                ),
              const SizedBox(height: 12),

              // Department Selection
              DropdownButtonFormField<String>(
                initialValue: _department,
                decoration: const InputDecoration(labelText: 'Department', prefixIcon: Icon(Icons.domain_outlined)),
                items: const [
                  DropdownMenuItem(value: 'Internal Medicine', child: Text('Internal Medicine')),
                  DropdownMenuItem(value: 'Endocrinology', child: Text('Endocrinology')),
                  DropdownMenuItem(value: 'Cardiology', child: Text('Cardiology')),
                  DropdownMenuItem(value: 'Orthopedics', child: Text('Orthopedics')),
                ],
                onChanged: (val) {
                  if (val != null) setState(() => _department = val);
                },
              ),
              const SizedBox(height: 12),

              // Reason
              TextFormField(
                initialValue: _reason,
                decoration: const InputDecoration(labelText: 'Reason for Visit', prefixIcon: Icon(Icons.notes_outlined)),
                onChanged: (val) => _reason = val,
              ),
              const SizedBox(height: 12),

              // Time slot
              TextFormField(
                initialValue: _timeSlot,
                decoration: const InputDecoration(labelText: 'Time Slot (e.g. 10:30 AM)', prefixIcon: Icon(Icons.access_time_outlined)),
                onChanged: (val) => _timeSlot = val,
              ),
              const SizedBox(height: 20),

              GradientButton(
                text: 'CONFIRM BOOKING',
                isLoading: _isLoading,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
