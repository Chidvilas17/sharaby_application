import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_decorations.dart';
import '../../core/utils/app_localizations.dart';
import '../../shared/widgets/animated_glass_background.dart';
import '../../shared/widgets/custom_app_bar.dart';
import '../../shared/widgets/custom_search_bar.dart';

import 'doctor_help_item.dart';
import 'doctor_help_service.dart';
import 'widgets/doctor_help_answer_card.dart';
import 'widgets/doctor_help_card.dart';
import 'widgets/doctor_help_category_chip.dart';

/// Dedicated Doctor AI Help Screen for Pediatric Clinical Guidance
class DoctorHelpScreen extends StatefulWidget {
  const DoctorHelpScreen({super.key});

  @override
  State<DoctorHelpScreen> createState() => _DoctorHelpScreenState();
}

class _DoctorHelpScreenState extends State<DoctorHelpScreen> {
  final DoctorHelpService _helpService = LocalDoctorHelpService();
  final TextEditingController _searchController = TextEditingController();

  List<DoctorHelpItem> _items = [];
  List<Map<String, String>> _categories = [];
  String _selectedCategoryKey = 'all';
  String _searchQuery = '';
  DoctorHelpItem? _selectedItem;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _categories = _helpService.getCategories();
    _loadItems();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadItems() async {
    setState(() => _isLoading = true);
    final lang = Localizations.localeOf(context).languageCode;
    final items = await _helpService.getHelpItems(
      categoryKey: _selectedCategoryKey,
      searchQuery: _searchQuery,
      languageCode: lang,
    );
    setState(() {
      _items = items;
      _isLoading = false;
    });
  }

  void _onCategorySelected(String categoryKey) {
    setState(() {
      _selectedCategoryKey = categoryKey;
      _selectedItem = null;
    });
    _loadItems();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _selectedItem = null;
    });
    _loadItems();
  }

  void _onClearSearch() {
    _searchController.clear();
    setState(() {
      _searchQuery = '';
      _selectedItem = null;
    });
    _loadItems();
  }

  void _onSelectQuestion(DoctorHelpItem item) {
    setState(() {
      _selectedItem = item;
    });
  }

  void _onClearSelectedItem() {
    setState(() {
      _selectedItem = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loc = AppLocalizations.of(context);
    final lang = Localizations.localeOf(context).languageCode;

    return AnimatedGlassBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          title: loc.translate('doctorAiHelpTitle'),
          showBackButton: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Top Sticky Area: Search & Categories (if no answer is selected)
              if (_selectedItem == null) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                  child: Column(
                    children: [
                      // Search Bar
                      CustomSearchBar(
                        hintText: loc.translate('searchAiHelpPlaceholder'),
                        controller: _searchController,
                        onChanged: _onSearchChanged,
                        onClear: _onClearSearch,
                      ),
                      const SizedBox(height: 12),

                      // Horizontal Category Chips List
                      SizedBox(
                        height: 38,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _categories.length,
                          itemBuilder: (context, index) {
                            final cat = _categories[index];
                            final key = cat['key']!;
                            final label = lang == 'ar' ? cat['ar']! : cat['en']!;
                            final isSelected = key == _selectedCategoryKey;

                            return DoctorHelpCategoryChip(
                              label: label,
                              isSelected: isSelected,
                              onTap: () => _onCategorySelected(key),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // Main Body Content (Answer Card OR Questions List)
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                  child: _selectedItem != null
                      ? DoctorHelpAnswerCard(
                          item: _selectedItem!,
                          languageCode: lang,
                          onClear: _onClearSelectedItem,
                        )
                      : (_isLoading
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.all(40.0),
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : (_items.isEmpty
                              ? _buildEmptyState(loc, isDark)
                              : Column(
                                  children: _items.map((item) {
                                    return DoctorHelpCard(
                                      item: item,
                                      languageCode: lang,
                                      onTap: () => _onSelectQuestion(item),
                                    );
                                  }).toList(),
                                ))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(AppLocalizations loc, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: AppDecorations.glossyIconBoxDecoration(
              color: AppColors.primaryDark,
              isDark: isDark,
              isCircle: true,
            ),
            child: const Icon(
              Icons.search_off_rounded,
              size: 42,
              color: AppColors.primaryDark,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            loc.translate('noMatchingQuestions'),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.textPrimaryDark : AppColors.primaryDark,
            ),
          ),
        ],
      ),
    );
  }
}
