import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_decorations.dart';
import '../../core/utils/app_localizations.dart';
import '../../shared/widgets/animated_glass_background.dart';
import '../../shared/widgets/custom_app_bar.dart';
import '../../shared/widgets/custom_search_bar.dart';
import '../../shared/widgets/glass_card.dart';
import '../../shared/widgets/gradient_button.dart';
import 'app_help_data.dart';
import 'app_help_item.dart';

/// Dedicated App Help Screen explaining how to use clinic features & forms
class AppHelpScreen extends StatefulWidget {
  const AppHelpScreen({super.key});

  @override
  State<AppHelpScreen> createState() => _AppHelpScreenState();
}

class _AppHelpScreenState extends State<AppHelpScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<AppHelpItem> _filteredItems = [];
  String _searchQuery = '';
  AppHelpItem? _selectedItem;

  @override
  void initState() {
    super.initState();
    _filteredItems = List.from(AppHelpData.items);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query.toLowerCase().trim();
      _selectedItem = null;
      if (_searchQuery.isEmpty) {
        _filteredItems = List.from(AppHelpData.items);
      } else {
        _filteredItems = AppHelpData.items.where((item) {
          final qEng = item.questionEnglish.toLowerCase();
          final qAr = item.questionArabic.toLowerCase();
          final aEng = item.answerEnglish.toLowerCase();
          final aAr = item.answerArabic.toLowerCase();
          return qEng.contains(_searchQuery) ||
              qAr.contains(_searchQuery) ||
              aEng.contains(_searchQuery) ||
              aAr.contains(_searchQuery);
        }).toList();
      }
    });
  }

  void _onClearSearch() {
    _searchController.clear();
    _onSearchChanged('');
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
          title: loc.translate('appHelpHeaderTitle'),
          showBackButton: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              if (_selectedItem == null) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                  child: CustomSearchBar(
                    hintText: loc.translate('searchAppHelpPlaceholder'),
                    controller: _searchController,
                    onChanged: _onSearchChanged,
                    onClear: _onClearSearch,
                  ),
                ),
              ],
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                  child: _selectedItem != null
                      ? _buildAnswerCard(context, _selectedItem!, lang, loc, isDark)
                      : (_filteredItems.isEmpty
                          ? _buildEmptyState(loc, isDark)
                          : Column(
                              children: _filteredItems.map((item) {
                                return _buildQuestionCard(item, lang, isDark);
                              }).toList(),
                            )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionCard(AppHelpItem item, String lang, bool isDark) {
    return GlassCard(
      onTap: () => setState(() => _selectedItem = item),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      borderRadius: 22,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: AppDecorations.glossyIconBoxDecoration(
              color: AppColors.accent,
              isDark: isDark,
              borderRadius: 14,
            ),
            child: Icon(item.icon, color: AppColors.accent, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3.5),
                      decoration: AppDecorations.glossyPillBoxDecoration(
                        color: AppColors.primaryDark,
                        isDark: isDark,
                        borderRadius: 10,
                      ),
                      child: Text(
                        item.getCategory(lang),
                        style: const TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryDark,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                      color: AppColors.primaryDark,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  item.getQuestion(lang),
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.primaryDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerCard(BuildContext context, AppHelpItem item, String lang, AppLocalizations loc, bool isDark) {
    return Column(
      children: [
        GlassCard(
          padding: const EdgeInsets.all(20),
          borderRadius: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: AppDecorations.glossyPillBoxDecoration(
                      color: AppColors.accent,
                      isDark: isDark,
                      borderRadius: 12,
                    ),
                    child: Text(
                      item.getCategory(lang),
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.bold,
                        color: AppColors.accent,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: AppDecorations.glossyIconBoxDecoration(
                      color: AppColors.accent,
                      isDark: isDark,
                      isCircle: true,
                    ),
                    child: Icon(item.icon, color: AppColors.accent, size: 20),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                item.getQuestion(lang),
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.primaryDark,
                ),
              ),
              const SizedBox(height: 16),
              Divider(
                height: 1,
                color: isDark
                    ? Colors.white.withValues(alpha: 0.12)
                    : const Color(0xFFE2E8F0),
              ),
              const SizedBox(height: 16),
              Text(
                item.getAnswer(lang),
                style: TextStyle(
                  fontSize: 14.5,
                  height: 1.55,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textPrimaryLight,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        GradientButton(
          text: loc.translate('backToQuestions'),
          icon: Icons.arrow_back_rounded,
          onPressed: () => setState(() => _selectedItem = null),
          height: 50,
          borderRadius: 25,
        ),
      ],
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
