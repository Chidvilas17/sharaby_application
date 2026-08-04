import 'package:flutter/material.dart';
import '../../core/constants/app_enums.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_localizations.dart';
import '../../shared/models/patient_model.dart';
import '../../shared/repositories/patient_repository.dart';
import '../../shared/widgets/animated_glass_background.dart';
import '../../shared/widgets/custom_app_bar.dart';
import '../../shared/widgets/custom_search_bar.dart';
import '../../shared/widgets/empty_state_widget.dart';
import '../../shared/widgets/loading_widget.dart';
import '../../shared/widgets/patient_card.dart';
import 'add_edit_patient_dialog.dart';
import 'patient_detail_screen.dart';

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({super.key});

  @override
  State<PatientListScreen> createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  final PatientRepository _patientRepo = MockPatientRepository();
  final TextEditingController _searchController = TextEditingController();

  List<PatientModel> _allPatients = [];
  List<PatientModel> _filteredPatients = [];
  bool _isLoading = true;
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _fetchPatients();
  }

  Future<void> _fetchPatients() async {
    setState(() => _isLoading = true);
    final list = await _patientRepo.getPatients();
    if (mounted) {
      setState(() {
        _allPatients = list;
        _applyFilters();
        _isLoading = false;
      });
    }
  }

  void _applyFilters() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredPatients = _allPatients.where((p) {
        final matchesQuery = p.fullName.toLowerCase().contains(query) ||
            p.phone.contains(query) ||
            p.id.toLowerCase().contains(query) ||
            p.medicalHistory.toLowerCase().contains(query);

        bool matchesFilter = true;
        if (_selectedFilter == 'Active') {
          matchesFilter = p.status == PatientStatus.active;
        } else if (_selectedFilter == 'Emergency') {
          matchesFilter = p.status == PatientStatus.emergency;
        } else if (_selectedFilter == 'Inactive') {
          matchesFilter = p.status == PatientStatus.inactive;
        }

        return matchesQuery && matchesFilter;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: loc.translate('patientManagement'),
      ),
      body: AnimatedGlassBackground(
        child: _isLoading
            ? LoadingWidget(message: loc.translate('patientManagement'))
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      // Search field
                      CustomSearchBar(
                        controller: _searchController,
                        hintText: loc.translate('searchPlaceholder'),
                        onChanged: (_) => _applyFilters(),
                      ),
                      const SizedBox(height: 14),

                      // Filter Chips Row
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: ['All', 'Active', 'Emergency', 'Inactive'].map((filter) {
                            final isSelected = _selectedFilter == filter;
                            final filterLabel = filter == 'All'
                                ? loc.translate('all')
                                : filter;
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ChoiceChip(
                                label: Text(filterLabel),
                                selected: isSelected,
                                selectedColor: AppColors.primaryDark,
                                labelStyle: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : (isDark
                                          ? AppColors.textPrimaryDark
                                          : AppColors.primaryDark),
                                  fontWeight: FontWeight.bold,
                                ),
                                onSelected: (val) {
                                  if (val) {
                                    setState(() {
                                      _selectedFilter = filter;
                                      _applyFilters();
                                    });
                                  }
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Patient List View
                      Expanded(
                        child: _filteredPatients.isEmpty
                            ? EmptyStateWidget(
                                title: loc.translate('noPatientsFound'),
                                message: loc.translate('noFilesMatch'),
                                icon: Icons.person_off_rounded,
                                buttonText: loc.translate('addNewPatient'),
                                onButtonPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AddEditPatientDialog(
                                      onSaved: (p) => _fetchPatients(),
                                    ),
                                  );
                                },
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.only(bottom: 90),
                                itemCount: _filteredPatients.length,
                                itemBuilder: (context, index) {
                                  final patient = _filteredPatients[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: PatientCard(
                                      patient: patient,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => PatientDetailScreen(
                                              patient: patient,
                                              onPatientUpdated: _fetchPatients,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AddEditPatientDialog(
              onSaved: (p) => _fetchPatients(),
            ),
          );
        },
        backgroundColor: AppColors.primaryDark,
        elevation: 6,
        icon: const Icon(Icons.person_add_rounded, color: Colors.white),
        label: Text(
          loc.translate('addNewPatient'),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
