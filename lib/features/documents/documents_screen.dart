import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/constants/app_enums.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_localizations.dart';
import '../../core/utils/formatters.dart';
import '../../shared/models/document_model.dart';
import '../../shared/repositories/document_repository.dart';
import '../../shared/widgets/custom_app_bar.dart';
import '../../shared/widgets/custom_search_bar.dart';
import '../../shared/widgets/empty_state_widget.dart';
import '../../shared/widgets/glass_card.dart';
import '../../shared/widgets/gradient_button.dart';
import '../../shared/widgets/loading_widget.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  final DocumentRepository _docRepo = MockDocumentRepository();
  final TextEditingController _searchController = TextEditingController();

  List<MedicalDocumentModel> _documents = [];
  List<MedicalDocumentModel> _filteredDocs = [];
  bool _isLoading = true;
  bool _isExporting = false;
  bool _isGridView = false;
  DocumentCategory? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _fetchDocuments();
  }

  Future<void> _fetchDocuments() async {
    setState(() => _isLoading = true);
    final list = await _docRepo.getDocuments();
    if (mounted) {
      setState(() {
        _documents = list;
        _filteredDocs = list;
        _isLoading = false;
      });
    }
  }

  void _applyFilter() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredDocs = _documents.where((doc) {
        final matchesQuery = doc.title.toLowerCase().contains(query) ||
            doc.patientName.toLowerCase().contains(query);
        final matchesCategory =
            _selectedCategory == null || doc.category == _selectedCategory;
        return matchesQuery && matchesCategory;
      }).toList();
    });
  }

  /// Real CSV Generation & File Export Function
  Future<void> _exportAndDownloadCsv() async {
    setState(() => _isExporting = true);

    try {
      // 1. Build real CSV content from sample patient data
      final csvHeader = "Patient Name,Age,Gender,Phone,Diagnosis,Appointment Date,Doctor\n";
      final samplePatients = [
        "Sarah Mansour,28,Female,01012345678,Dental Caries Checkup,2026-08-04,Dr. Ahmed Sharaby",
        "Mohamed Ali,42,Male,01198765432,Hypertension Follow-up,2026-08-04,Dr. Ahmed Sharaby",
        "Khaled Mahmoud,35,Male,01234567890,Routine Physical Exam,2026-08-03,Dr. Ahmed Sharaby",
        "Nour El-Din,19,Female,01555555555,Allergic Rhinitis,2026-08-02,Dr. Ahmed Sharaby",
        "Omar Hassan,50,Male,01099998888,Type-2 Diabetes Consultation,2026-08-01,Dr. Ahmed Sharaby",
        "Youssef Ibrahim,31,Male,01011112222,General Consultation,2026-07-30,Dr. Ahmed Sharaby",
        "Mona Zaki,26,Female,01244443333,Orthodontic Evaluation,2026-07-28,Dr. Ahmed Sharaby",
      ];

      final csvData = csvHeader + samplePatients.join("\n");

      // 2. Obtain local file path
      final directory = await getApplicationDocumentsDirectory();
      final filePath = "${directory.path}/sharaby_clinic_patients_export.csv";
      final file = File(filePath);

      // 3. Save CSV file locally
      await file.writeAsString(csvData);

      if (!mounted) return;

      final loc = AppLocalizations.of(context);

      // 4. Show success snackbar with share option
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 5),
          backgroundColor: AppColors.success,
          content: Row(
            children: [
              const Icon(Icons.check_circle_rounded, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  loc.translate('csvSuccess'),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          action: SnackBarAction(
            label: loc.translate('shareFile'),
            textColor: Colors.white,
            onPressed: () {
              Share.shareXFiles(
                [XFile(filePath)],
                text: 'Sharaby Center Patient Records CSV Export',
              );
            },
          ),
        ),
      );

      // Trigger native share dialog automatically
      await Share.shareXFiles(
        [XFile(filePath)],
        text: 'Sharaby Center Patient Records CSV Export',
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.error,
            content: Text("Failed to save CSV file: $e"),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isExporting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loc = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: CustomAppBar(
        title: loc.translate('documentsTitle'),
        actions: [
          IconButton(
            icon: Icon(
              _isGridView ? Icons.view_list_rounded : Icons.grid_view_rounded,
              color: AppColors.primary,
            ),
            onPressed: () => setState(() => _isGridView = !_isGridView),
          ),
        ],
      ),
      body: _isLoading
          ? const LoadingWidget(message: 'Loading documents...')
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    // Export Banner Card with CSV Button
                    GlassCard(
                      borderRadius: 22,
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.table_chart_rounded,
                              color: AppColors.primary,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  loc.translate('downloadCsv'),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isDark
                                        ? AppColors.textPrimaryDark
                                        : AppColors.textPrimaryLight,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  loc.translate('exportSubtitle'),
                                  style: TextStyle(
                                    fontSize: 11.5,
                                    color: isDark
                                        ? AppColors.textMutedDark
                                        : AppColors.textMutedLight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          GradientButton(
                            text: loc.translate('downloadCsv'),
                            icon: Icons.download_rounded,
                            height: 42,
                            width: 130,
                            borderRadius: 14,
                            isLoading: _isExporting,
                            onPressed: _exportAndDownloadCsv,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Search Bar
                    CustomSearchBar(
                      controller: _searchController,
                      hintText: 'Search files or patient names...',
                      onChanged: (_) => _applyFilter(),
                    ),
                    const SizedBox(height: 14),

                    // Folder category chips
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ChoiceChip(
                            label: const Text('All Files'),
                            selected: _selectedCategory == null,
                            selectedColor: AppColors.primary,
                            onSelected: (val) {
                              if (val) {
                                setState(() {
                                  _selectedCategory = null;
                                  _applyFilter();
                                });
                              }
                            },
                          ),
                          const SizedBox(width: 8),
                          ...DocumentCategory.values.map((cat) {
                            final isSelected = _selectedCategory == cat;
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ChoiceChip(
                                label: Text(cat.name.toUpperCase()),
                                selected: isSelected,
                                selectedColor: AppColors.primary,
                                labelStyle: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : (isDark
                                          ? AppColors.textPrimaryDark
                                          : AppColors.textPrimaryLight),
                                  fontWeight: FontWeight.bold,
                                ),
                                onSelected: (val) {
                                  if (val) {
                                    setState(() {
                                      _selectedCategory = cat;
                                      _applyFilter();
                                    });
                                  }
                                },
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    Expanded(
                      child: _filteredDocs.isEmpty
                          ? EmptyStateWidget(
                              title: 'No Documents Found',
                              message: 'No files match your search criteria.',
                              icon: Icons.folder_open_rounded,
                              buttonText: loc.translate('downloadCsv'),
                              onButtonPressed: _exportAndDownloadCsv,
                            )
                          : (_isGridView ? _buildGrid() : _buildList()),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 30),
      itemCount: _filteredDocs.length,
      itemBuilder: (context, index) {
        final doc = _filteredDocs[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: GlassCard(
            padding: const EdgeInsets.all(14),
            borderRadius: 18,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.insert_drive_file_rounded,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doc.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${doc.patientName} • ${doc.fileSize} • ${AppFormatters.formatDate(doc.uploadDate)}',
                        style: const TextStyle(
                          fontSize: 11.5,
                          color: AppColors.textMutedLight,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.download_rounded,
                    color: AppColors.primary,
                  ),
                  onPressed: _exportAndDownloadCsv,
                  tooltip: 'Download CSV Export',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGrid() {
    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 30),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.1,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: _filteredDocs.length,
      itemBuilder: (context, index) {
        final doc = _filteredDocs[index];
        return GlassCard(
          padding: const EdgeInsets.all(14),
          borderRadius: 18,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.picture_as_pdf_rounded,
                    color: AppColors.error,
                    size: 26,
                  ),
                  Text(
                    doc.fileExtension,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                doc.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                doc.patientName,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textMutedLight,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}