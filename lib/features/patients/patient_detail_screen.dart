import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_localizations.dart';
import '../../shared/models/patient_model.dart';
import '../../shared/repositories/patient_repository.dart';
import '../../shared/widgets/animated_glass_background.dart';
import '../../shared/widgets/confirmation_dialog.dart';
import '../../shared/widgets/custom_app_bar.dart';
import '../../shared/widgets/medical_card.dart';
import 'add_edit_patient_dialog.dart';

class PatientDetailScreen extends StatefulWidget {
  final PatientModel patient;
  final VoidCallback onPatientUpdated;

  const PatientDetailScreen({
    super.key,
    required this.patient,
    required this.onPatientUpdated,
  });

  @override
  State<PatientDetailScreen> createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PatientModel _patient;
  final PatientRepository _patientRepo = MockPatientRepository();

  @override
  void initState() {
    super.initState();
    _patient = widget.patient;
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: loc.translate('patientDetails'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_rounded, color: AppColors.primaryDark),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AddEditPatientDialog(
                  patientToEdit: _patient,
                  onSaved: (updated) {
                    setState(() => _patient = updated);
                    widget.onPatientUpdated();
                  },
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded, color: AppColors.error),
            onPressed: () {
              showDialog(
                context: context,
                builder: (dialogCtx) => ConfirmationDialog(
                  title: loc.translate('deletePatient'),
                  content: loc.translate('confirmDeletePatient'),
                  confirmText: loc.translate('delete'),
                  onConfirm: () async {
                    final nav = Navigator.of(context);
                    await _patientRepo.deletePatient(_patient.id);
                    widget.onPatientUpdated();
                    if (mounted) nav.pop();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: AnimatedGlassBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Patient Header Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadowBlue,
                      blurRadius: 18,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 34,
                      backgroundColor: Colors.white,
                      child: Text(
                        _patient.fullName.characters.first,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryDark,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _patient.fullName,
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'ID: ${_patient.id} • ${_patient.gender.name.toUpperCase()} • ${_patient.age} yrs',
                            style: const TextStyle(color: Colors.white70, fontSize: 12.5),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Blood Group: ${_patient.bloodType}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Tab Bar
              TabBar(
                controller: _tabController,
                labelColor: AppColors.primaryDark,
                unselectedLabelColor: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                indicatorColor: AppColors.primaryDark,
                tabs: [
                  Tab(text: loc.translate('growth')),
                  Tab(text: loc.translate('medicalHistory')),
                  Tab(text: loc.translate('parentGuardian')),
                ],
              ),

              // Tab Views
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Growth & Vitals Tab
                    ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        MedicalCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                loc.translate('growthStatus'),
                                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.primaryDark),
                              ),
                              const SizedBox(height: 14),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  _buildGrowthMetricTile(loc.translate('weight'), _patient.weight, Icons.monitor_weight_rounded, AppColors.primaryDark),
                                  _buildGrowthMetricTile(loc.translate('height'), _patient.height, Icons.height_rounded, AppColors.accent),
                                  _buildGrowthMetricTile(loc.translate('vaccinationStatus'), _patient.vaccinationStatus, Icons.vaccines_rounded, AppColors.success),
                                ],
                              ),
                              const SizedBox(height: 14),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.child_care_rounded, color: AppColors.primaryDark),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        'Growth Percentile: ${_patient.growthStatus}',
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        MedicalCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Pediatric Vital Signs',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  _buildVitalColumn('Heart Rate', '95 bpm', AppColors.error),
                                  _buildVitalColumn('Body Temp', '37.1 °C', AppColors.warning),
                                  _buildVitalColumn('SpO2', '99%', AppColors.success),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Medical & History Tab
                    ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        MedicalCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                loc.translate('medicalHistory'),
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primaryDark),
                              ),
                              const SizedBox(height: 8),
                              Text(_patient.medicalHistory),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        MedicalCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Known Pediatric Allergies',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.error),
                              ),
                              const SizedBox(height: 8),
                              Text(_patient.allergies),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        MedicalCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Vaccination Record',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.success),
                              ),
                              const SizedBox(height: 8),
                              Text(_patient.vaccinationStatus),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Parent / Guardian Tab
                    ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        MedicalCard(
                          child: ListTile(
                            leading: const Icon(Icons.person_rounded, color: AppColors.primaryDark),
                            title: Text(loc.translate('fatherName')),
                            subtitle: Text(_patient.fatherName.isNotEmpty ? _patient.fatherName : _patient.emergencyContact),
                          ),
                        ),
                        const SizedBox(height: 12),
                        MedicalCard(
                          child: ListTile(
                            leading: const Icon(Icons.person_outline_rounded, color: AppColors.accent),
                            title: Text(loc.translate('motherName')),
                            subtitle: Text(_patient.motherName.isNotEmpty ? _patient.motherName : 'Registered Mother / Guardian'),
                          ),
                        ),
                        const SizedBox(height: 12),
                        MedicalCard(
                          child: ListTile(
                            leading: const Icon(Icons.phone_rounded, color: AppColors.success),
                            title: Text(loc.translate('guardianPhone')),
                            subtitle: Text(_patient.phone),
                          ),
                        ),
                        const SizedBox(height: 12),
                        MedicalCard(
                          child: ListTile(
                            leading: const Icon(Icons.contact_phone_rounded, color: AppColors.warning),
                            title: const Text('Emergency Contact'),
                            subtitle: Text(_patient.emergencyContact),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGrowthMetricTile(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: AppColors.textMutedLight),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildVitalColumn(String label, String val, Color color) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 11.5, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(val, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }
}

