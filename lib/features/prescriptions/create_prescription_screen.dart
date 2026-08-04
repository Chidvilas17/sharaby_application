import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_localizations.dart';
import '../../shared/models/patient_model.dart';
import '../../shared/models/prescription_model.dart';
import '../../shared/repositories/patient_repository.dart';
import '../../shared/repositories/prescription_repository.dart';
import '../../shared/widgets/animated_glass_background.dart';
import '../../shared/widgets/custom_app_bar.dart';
import '../../shared/widgets/gradient_button.dart';
import '../../shared/widgets/medical_card.dart';

class CreatePrescriptionScreen extends StatefulWidget {
  const CreatePrescriptionScreen({super.key});

  @override
  State<CreatePrescriptionScreen> createState() => _CreatePrescriptionScreenState();
}

class _CreatePrescriptionScreenState extends State<CreatePrescriptionScreen> {
  final _formKey = GlobalKey<FormState>();
  final PatientRepository _patientRepo = MockPatientRepository();
  final PrescriptionRepository _prescriptionRepo = MockPrescriptionRepository();

  List<PatientModel> _patients = [];
  PatientModel? _selectedPatient;
  final TextEditingController _diagnosisController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  final List<MedicineItem> _medicines = [];

  // Temporary medicine controllers
  final _medNameCtrl = TextEditingController();
  final _dosageCtrl = TextEditingController();
  final _freqCtrl = TextEditingController();
  final _durationCtrl = TextEditingController();

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

  void _addMedicine() {
    if (_medNameCtrl.text.trim().isEmpty) return;

    setState(() {
      _medicines.add(MedicineItem(
        medicineName: _medNameCtrl.text.trim(),
        dosage: _dosageCtrl.text.trim().isEmpty ? '1 Tablet' : _dosageCtrl.text.trim(),
        frequency: _freqCtrl.text.trim().isEmpty ? 'Twice daily' : _freqCtrl.text.trim(),
        duration: _durationCtrl.text.trim().isEmpty ? '7 Days' : _durationCtrl.text.trim(),
        instructions: 'Take after meals',
      ));
      _medNameCtrl.clear();
      _dosageCtrl.clear();
      _freqCtrl.clear();
      _durationCtrl.clear();
    });
  }

  Future<void> _submit() async {
    if (_selectedPatient == null || _medicines.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select patient and add at least one medicine')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final rx = PrescriptionModel(
      id: 'RX-${1000 + DateTime.now().millisecond}',
      patientId: _selectedPatient!.id,
      patientName: _selectedPatient!.fullName,
      doctorName: AppConstants.defaultDoctorName,
      issueDate: DateTime.now(),
      medicines: List.from(_medicines),
      doctorNotes: _notesController.text.trim(),
      diagnosis: _diagnosisController.text.trim().isEmpty
          ? 'General Consultation'
          : _diagnosisController.text.trim(),
    );

    await _prescriptionRepo.addPrescription(rx);

    if (mounted) {
      setState(() => _isLoading = false);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: CustomAppBar(title: loc.translate('newPrescription')),
      body: AnimatedGlassBackground(
        child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Patient Selector
                if (_patients.isNotEmpty)
                  DropdownButtonFormField<PatientModel>(
                    initialValue: _selectedPatient,
                    decoration: const InputDecoration(
                      labelText: 'Select Patient',
                      prefixIcon: Icon(Icons.person_outlined, color: AppColors.primary),
                    ),
                    items: _patients.map((p) {
                      return DropdownMenuItem(value: p, child: Text(p.fullName));
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedPatient = val);
                    },
                  ),
                const SizedBox(height: 16),

                // Diagnosis input
                TextField(
                  controller: _diagnosisController,
                  decoration: const InputDecoration(
                    labelText: 'Diagnosis / Clinical Impression',
                    prefixIcon: Icon(Icons.medical_information_outlined, color: AppColors.primary),
                  ),
                ),
                const SizedBox(height: 24),

                // Medicine Input Card
                MedicalCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Add Prescribed Medicines',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _medNameCtrl,
                        decoration: const InputDecoration(labelText: 'Medicine Name (e.g. Paracetamol 500mg)'),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _dosageCtrl,
                              decoration: const InputDecoration(labelText: 'Dosage (1 tab)'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _freqCtrl,
                              decoration: const InputDecoration(labelText: 'Frequency (Bid)'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _durationCtrl,
                              decoration: const InputDecoration(labelText: 'Duration (7 days)'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton.icon(
                          onPressed: _addMedicine,
                          icon: const Icon(Icons.add_rounded),
                          label: const Text('Add Medicine Item'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Medicines List Added
                if (_medicines.isNotEmpty) ...[
                  const Text('Prescription Items:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ..._medicines.map((m) => Card(
                        child: ListTile(
                          title: Text(m.medicineName, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('${m.dosage} • ${m.frequency} • ${m.duration}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline, color: AppColors.error),
                            onPressed: () => setState(() => _medicines.remove(m)),
                          ),
                        ),
                      )),
                  const SizedBox(height: 20),
                ],

                // Doctor Notes
                TextField(
                  controller: _notesController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Doctor Remarks & Dietary Advice',
                    prefixIcon: Icon(Icons.edit_note_rounded),
                  ),
                ),
                const SizedBox(height: 28),

                GradientButton(
                  text: 'ISSUE PRESCRIPTION',
                  isLoading: _isLoading,
                  onPressed: _submit,
                ),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}
