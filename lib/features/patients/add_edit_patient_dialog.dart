import 'package:flutter/material.dart';
import '../../core/constants/app_enums.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_localizations.dart';
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
  late TextEditingController _fatherNameController;
  late TextEditingController _motherNameController;
  late TextEditingController _phoneController;
  late TextEditingController _weightController;
  late TextEditingController _heightController;
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
    _ageController = TextEditingController(text: p != null ? '${p.age}' : '4');
    _fatherNameController = TextEditingController(text: p?.fatherName ?? '');
    _motherNameController = TextEditingController(text: p?.motherName ?? '');
    _phoneController = TextEditingController(text: p?.phone ?? '');
    _weightController = TextEditingController(text: p?.weight ?? '17 kg');
    _heightController = TextEditingController(text: p?.height ?? '102 cm');
    _bloodTypeController = TextEditingController(text: p?.bloodType ?? 'A+');
    _historyController = TextEditingController(text: p?.medicalHistory ?? '');

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
      age: int.tryParse(_ageController.text.trim()) ?? 4,
      gender: _gender,
      phone: _phoneController.text.trim(),
      email: widget.patientToEdit?.email ?? 'guardian@email.com',
      bloodType: _bloodTypeController.text.trim(),
      status: _status,
      lastVisitDate: widget.patientToEdit?.lastVisitDate ?? 'Today',
      medicalHistory: _historyController.text.trim().isEmpty
          ? 'Routine Pediatric Assessment'
          : _historyController.text.trim(),
      allergies: widget.patientToEdit?.allergies ?? 'None',
      emergencyContact: '${_fatherNameController.text.trim().isNotEmpty ? _fatherNameController.text.trim() : 'Father'} - ${_phoneController.text.trim()}',
      fatherName: _fatherNameController.text.trim(),
      motherName: _motherNameController.text.trim(),
      guardianPhone: _phoneController.text.trim(),
      weight: _weightController.text.trim().isEmpty ? '17 kg' : _weightController.text.trim(),
      height: _heightController.text.trim().isEmpty ? '102 cm' : _heightController.text.trim(),
      growthStatus: widget.patientToEdit?.growthStatus ?? 'Normal Development (50th percentile)',
      vaccinationStatus: widget.patientToEdit?.vaccinationStatus ?? 'Up to Date',
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
    final loc = AppLocalizations.of(context);
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
                    isEditing ? loc.translate('editPatient') : loc.translate('addNewPatient'),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.primaryDark,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Child Name
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: loc.translate('childName'),
                  prefixIcon: const Icon(Icons.child_care_rounded, color: AppColors.primary),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                ),
                validator: (val) => val == null || val.isEmpty ? loc.translate('fillRequiredFields') : null,
              ),
              const SizedBox(height: 12),

              // Age & Gender
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: '${loc.translate('age')} (years)',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<PatientGender>(
                      initialValue: _gender,
                      decoration: InputDecoration(
                        labelText: loc.translate('gender'),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      items: [
                        DropdownMenuItem(value: PatientGender.male, child: Text(loc.translate('male'))),
                        DropdownMenuItem(value: PatientGender.female, child: Text(loc.translate('female'))),
                      ],
                      onChanged: (v) {
                        if (v != null) setState(() => _gender = v);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Weight & Height
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _weightController,
                      decoration: InputDecoration(
                        labelText: loc.translate('weight'),
                        prefixIcon: const Icon(Icons.monitor_weight_outlined, color: AppColors.primary),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _heightController,
                      decoration: InputDecoration(
                        labelText: loc.translate('height'),
                        prefixIcon: const Icon(Icons.height_rounded, color: AppColors.primary),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Father Name
              TextFormField(
                controller: _fatherNameController,
                decoration: InputDecoration(
                  labelText: loc.translate('fatherName'),
                  prefixIcon: const Icon(Icons.person_outline, color: AppColors.primary),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
              const SizedBox(height: 12),

              // Mother Name
              TextFormField(
                controller: _motherNameController,
                decoration: InputDecoration(
                  labelText: loc.translate('motherName'),
                  prefixIcon: const Icon(Icons.person_2_outlined, color: AppColors.primary),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
              const SizedBox(height: 12),

              // Parent/Guardian Phone
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: loc.translate('guardianPhone'),
                  prefixIcon: const Icon(Icons.phone_outlined, color: AppColors.primary),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                ),
                validator: (val) => val == null || val.isEmpty ? loc.translate('fillRequiredFields') : null,
              ),
              const SizedBox(height: 12),

              // Medical History / Diagnosis Notes
              TextFormField(
                controller: _historyController,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: loc.translate('medicalHistory'),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
              const SizedBox(height: 20),

              GradientButton(
                text: isEditing
                    ? loc.translate('saveChanges').toUpperCase()
                    : loc.translate('addNewPatient').toUpperCase(),
                isLoading: _isLoading,
                onPressed: _submit,
                borderRadius: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }

}
