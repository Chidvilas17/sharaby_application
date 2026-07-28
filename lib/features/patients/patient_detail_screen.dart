import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/models/patient_model.dart';
import '../../shared/repositories/patient_repository.dart';
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

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Patient Profile',
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_rounded, color: AppColors.primary),
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
                  title: 'Delete Patient',
                  content: 'Are you sure you want to remove ${_patient.fullName} from clinic records?',
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
      body: SafeArea(
        child: Column(
          children: [
            // Patient Header Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.white,
                    child: Text(
                      _patient.fullName.characters.first,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
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
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'ID: ${_patient.id} • ${_patient.gender.name.toUpperCase()} • ${_patient.age} yrs',
                          style: const TextStyle(color: Colors.white70, fontSize: 13),
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
                              fontSize: 12,
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
              labelColor: AppColors.primary,
              unselectedLabelColor: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
              indicatorColor: AppColors.primary,
              tabs: const [
                Tab(text: 'Medical Info'),
                Tab(text: 'Contact & Emergency'),
                Tab(text: 'Vitals & History'),
              ],
            ),

            // Tab Views
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Medical Info Tab
                  ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      MedicalCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Diagnosed Conditions / History',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primary),
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
                              'Known Allergies',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.error),
                            ),
                            const SizedBox(height: 8),
                            Text(_patient.allergies),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Contact Tab
                  ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      MedicalCard(
                        child: ListTile(
                          leading: const Icon(Icons.phone_rounded, color: AppColors.primary),
                          title: const Text('Phone Number'),
                          subtitle: Text(_patient.phone),
                        ),
                      ),
                      const SizedBox(height: 12),
                      MedicalCard(
                        child: ListTile(
                          leading: const Icon(Icons.email_rounded, color: AppColors.accent),
                          title: const Text('Email Address'),
                          subtitle: Text(_patient.email),
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

                  // Vitals & History Tab
                  ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      const MedicalCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Recent Vitals Reading',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(children: [Text('BP', style: TextStyle(color: Colors.grey)), Text('120/80', style: TextStyle(fontWeight: FontWeight.bold))]),
                                Column(children: [Text('Pulse', style: TextStyle(color: Colors.grey)), Text('72 bpm', style: TextStyle(fontWeight: FontWeight.bold))]),
                                Column(children: [Text('Temp', style: TextStyle(color: Colors.grey)), Text('98.6 °F', style: TextStyle(fontWeight: FontWeight.bold))]),
                              ],
                            ),
                          ],
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
    );
  }
}
