import 'package:flutter/material.dart';
import '../../core/constants/app_enums.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/models/patient_model.dart';
import '../../shared/repositories/patient_repository.dart';
import '../../shared/widgets/gradient_button.dart';

class AddEditPatientDialog extends StatefulWidget {
  final PatientModel? patientToEdit;
  final Function(PatientModel) onSaved;

  const AddEditPatientDialog({
    super.key,
    this.patientToEdit,
    required this.onSaved,
  });

  @override
  State<AddEditPatientDialog> createState() => _AddEditPatientDialogState();
}

class _AddEditPatientDialogState extends State<AddEditPatientDialog> {
  final _formKey = GlobalKey<FormState>();
  final PatientRepository _patientRepo = MockPatientRepository();

  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _bloodTypeController;
  late TextEditingController _historyController;

  PatientGender _gender = PatientGender.male;
  final PatientStatus _status = PatientStatus.active;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final p = widget.patientToEdit;
    _nameController = TextEditingController(text: p?.fullName ?? '');
    _ageController = TextEditingController(text: p != null ? '${p.age}' : '30');
    _phoneController = TextEditingController(text: p?.phone ?? '');
    _emailController = TextEditingController(text: p?.email ?? '');
    _bloodTypeController = TextEditingController(text: p?.bloodType ?? 'O+');
    _historyController = TextEditingController(text: p?.medicalHistory ?? 'None');

    if (p != null) {
      _gender = p.gender;
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final newPatient = PatientModel(
      id: widget.patientToEdit?.id ?? 'P${1000 + DateTime.now().millisecond}',
      fullName: _nameController.text.trim(),
      age: int.tryParse(_ageController.text.trim()) ?? 30,
      gender: _gender,
      phone: _phoneController.text.trim(),
      email: _emailController.text.trim(),
      bloodType: _bloodTypeController.text.trim(),
      status: _status,
      lastVisitDate: widget.patientToEdit?.lastVisitDate ?? 'Today',
      medicalHistory: _historyController.text.trim(),
      allergies: widget.patientToEdit?.allergies ?? 'None',
      emergencyContact: widget.patientToEdit?.emergencyContact ?? 'N/A',
    );

    if (widget.patientToEdit != null) {
      await _patientRepo.updatePatient(newPatient);
    } else {
      await _patientRepo.addPatient(newPatient);
    }

    widget.onSaved(newPatient);
    if (mounted) {
      setState(() => _isLoading = false);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isEditing = widget.patientToEdit != null;

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
                    isEditing ? 'Edit Patient File' : 'Add New Patient',
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

              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Full Name', prefixIcon: Icon(Icons.person_outlined)),
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Age'),
                      validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<PatientGender>(
                      initialValue: _gender,
                      decoration: const InputDecoration(labelText: 'Gender'),
                      items: PatientGender.values.map((g) {
                        return DropdownMenuItem(value: g, child: Text(g.name.toUpperCase()));
                      }).toList(),
                      onChanged: (v) {
                        if (v != null) setState(() => _gender = v);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Phone Number', prefixIcon: Icon(Icons.phone_outlined)),
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email Address', prefixIcon: Icon(Icons.email_outlined)),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _bloodTypeController,
                decoration: const InputDecoration(labelText: 'Blood Type (e.g. O+, A-)', prefixIcon: Icon(Icons.water_drop_outlined)),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _historyController,
                maxLines: 2,
                decoration: const InputDecoration(labelText: 'Medical History'),
              ),
              const SizedBox(height: 20),

              GradientButton(
                text: isEditing ? 'UPDATE PATIENT' : 'SAVE PATIENT RECORD',
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
