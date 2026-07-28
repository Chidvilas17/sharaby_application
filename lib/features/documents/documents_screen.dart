import 'package:flutter/material.dart';
import '../../core/constants/app_enums.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/formatters.dart';
import '../../shared/models/document_model.dart';
import '../../shared/repositories/document_repository.dart';
import '../../shared/widgets/custom_search_bar.dart';
import '../../shared/widgets/empty_state_widget.dart';
import '../../shared/widgets/loading_widget.dart';
import '../../shared/widgets/medical_card.dart';

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
        final matchesCategory = _selectedCategory == null || doc.category == _selectedCategory;
        return matchesQuery && matchesCategory;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical Documents Manager'),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded, color: AppColors.primary),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
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
                              buttonText: 'Upload Document',
                              onButtonPressed: _showUploadModal,
                            )
                          : (_isGridView ? _buildGrid() : _buildList()),
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showUploadModal,
        icon: const Icon(Icons.upload_file_rounded),
        label: const Text('Upload File'),
      ),
    );
  }

  Widget _buildList() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 90),
      itemCount: _filteredDocs.length,
      itemBuilder: (context, index) {
        final doc = _filteredDocs[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: MedicalCard(
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.insert_drive_file_rounded, color: AppColors.primary),
              ),
              title: Text(doc.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                  '${doc.patientName} • ${doc.fileSize} • ${AppFormatters.formatDate(doc.uploadDate)}'),
              trailing: IconButton(
                icon: Icon(Icons.download_rounded, color: isDark ? Colors.white : Colors.black54),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Downloading ${doc.title}...')),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGrid() {
    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 90),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.1,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: _filteredDocs.length,
      itemBuilder: (context, index) {
        final doc = _filteredDocs[index];
        return MedicalCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.picture_as_pdf_rounded, color: AppColors.error, size: 28),
                  Text(doc.fileExtension, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                ],
              ),
              Text(
                doc.title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                doc.patientName,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showUploadModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cloud_upload_rounded, size: 48, color: AppColors.primary),
              const SizedBox(height: 12),
              const Text('Upload Medical File', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('Select PDF, DICOM, or image file from device storage.', textAlign: TextAlign.center),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('File upload placeholder triggered.')),
                  );
                },
                icon: const Icon(Icons.folder_open_rounded),
                label: const Text('Browse Device Files'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}