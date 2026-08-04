import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_localizations.dart';
import '../../shared/models/prescription_model.dart';
import '../../shared/repositories/prescription_repository.dart';
import '../../shared/widgets/animated_glass_background.dart';
import '../../shared/widgets/custom_app_bar.dart';
import '../../shared/widgets/custom_search_bar.dart';
import '../../shared/widgets/empty_state_widget.dart';
import '../../shared/widgets/loading_widget.dart';
import '../../shared/widgets/prescription_card.dart';
import 'create_prescription_screen.dart';
import 'prescription_detail_dialog.dart';

class PrescriptionsScreen extends StatefulWidget {
  const PrescriptionsScreen({super.key});

  @override
  State<PrescriptionsScreen> createState() => _PrescriptionsScreenState();
}

class _PrescriptionsScreenState extends State<PrescriptionsScreen> {
  final PrescriptionRepository _repo = MockPrescriptionRepository();
  final TextEditingController _searchController = TextEditingController();

  List<PrescriptionModel> _allPrescriptions = [];
  List<PrescriptionModel> _filteredPrescriptions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPrescriptions();
  }

  Future<void> _fetchPrescriptions() async {
    setState(() => _isLoading = true);
    final list = await _repo.getPrescriptions();
    if (mounted) {
      setState(() {
        _allPrescriptions = list;
        _filteredPrescriptions = list;
        _isLoading = false;
      });
    }
  }

  void _onSearch(String query) {
    setState(() {
      _filteredPrescriptions = _allPrescriptions.where((p) {
        return p.patientName.toLowerCase().contains(query.toLowerCase()) ||
            p.id.toLowerCase().contains(query.toLowerCase()) ||
            p.diagnosis.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: loc.translate('prescriptionsTitle'),
      ),
      body: AnimatedGlassBackground(
        child: _isLoading
            ? LoadingWidget(message: loc.translate('prescriptionsTitle'))
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      CustomSearchBar(
                        controller: _searchController,
                        hintText: loc.translate('searchPlaceholder'),
                        onChanged: _onSearch,
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: _filteredPrescriptions.isEmpty
                            ? EmptyStateWidget(
                                title: loc.translate('noFilesMatch'),
                                message: loc.translate('noFilesMatch'),
                                icon: Icons.description_outlined,
                                buttonText: loc.translate('newPrescription'),
                                onButtonPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const CreatePrescriptionScreen(),
                                    ),
                                  ).then((_) => _fetchPrescriptions());
                                },
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.only(bottom: 90),
                                itemCount: _filteredPrescriptions.length,
                                itemBuilder: (context, index) {
                                  final rx = _filteredPrescriptions[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: PrescriptionCard(
                                      prescription: rx,
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) => PrescriptionDetailDialog(prescription: rx),
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CreatePrescriptionScreen(),
            ),
          ).then((_) => _fetchPrescriptions());
        },
        backgroundColor: AppColors.primaryDark,
        elevation: 6,
        icon: const Icon(Icons.post_add_rounded, color: Colors.white),
        label: Text(
          loc.translate('newPrescription'),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}