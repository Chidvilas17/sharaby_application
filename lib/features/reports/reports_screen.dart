import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_localizations.dart';
import '../../shared/models/report_stat_model.dart';
import '../../shared/repositories/report_repository.dart';
import '../../shared/widgets/animated_glass_background.dart';
import '../../shared/widgets/custom_app_bar.dart';
import '../../shared/widgets/loading_widget.dart';
import '../../shared/widgets/medical_card.dart';
import '../../shared/widgets/protected_financial_text.dart';
import '../../shared/widgets/section_header.dart';
import '../../shared/widgets/stat_card.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final ReportRepository _reportRepo = MockReportRepository();

  List<AnalyticsMetric> _metrics = [];
  List<RevenueTrendPoint> _trends = [];
  bool _isLoading = true;
  String _selectedRange = 'This Month';

  @override
  void initState() {
    super.initState();
    _fetchReportData();
  }

  Future<void> _fetchReportData() async {
    setState(() => _isLoading = true);
    final m = await _reportRepo.getMetrics();
    final t = await _reportRepo.getRevenueTrends();
    if (mounted) {
      setState(() {
        _metrics = m;
        _trends = t;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: loc.translate('reportsTitle'),
        actions: [
          PopupMenuButton<String>(
            initialValue: _selectedRange,
            onSelected: (val) => setState(() => _selectedRange = val),
            itemBuilder: (_) => [
              PopupMenuItem(value: 'This Week', child: Text(loc.translate('thisWeek'))),
              PopupMenuItem(value: 'This Month', child: Text(loc.translate('thisMonth'))),
              PopupMenuItem(value: 'This Year', child: Text(loc.translate('thisYear'))),
            ],
            icon: const Icon(Icons.filter_alt_rounded, color: AppColors.primaryDark),
          ),
        ],
      ),
      body: AnimatedGlassBackground(
        child: _isLoading
            ? LoadingWidget(message: loc.translate('reportsTitle'))
            : SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 90),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${loc.translate('performanceSummary')} ($_selectedRange)',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Metrics grid
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.15,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: _metrics.length,
                        itemBuilder: (context, index) {
                          final m = _metrics[index];
                          final isFin = index == 0 || index == 3;
                          final formattedVal = isFin
                              ? 'EGP ${m.value.toInt()}'
                              : '${m.value.toInt()}';

                          String titleLabel = m.label;
                          if (index == 0) titleLabel = loc.translate('totalRevenue');
                          if (index == 1) titleLabel = loc.translate('patientVisits');
                          if (index == 2) titleLabel = loc.translate('appointmentsCompleted');
                          if (index == 3) titleLabel = loc.translate('outstandingCollections');

                          return StatCard(
                            title: titleLabel,
                            value: formattedVal,
                            isFinancial: isFin,
                            icon: index == 0
                                ? Icons.monetization_on_rounded
                                : (index == 1
                                    ? Icons.people_alt_rounded
                                    : (index == 2
                                        ? Icons.event_available_rounded
                                        : Icons.pending_actions_rounded)),
                            color: index == 0
                                ? AppColors.success
                                : (index == 1 ? AppColors.primaryDark : AppColors.accent),
                            trend: '${m.growthPercentage.abs().toStringAsFixed(1)}%',
                            isPositive: m.growthPercentage >= 0,
                          );
                        },
                      ),
                      const SizedBox(height: 28),

                      // Custom Revenue Visualizer Chart Bar Card
                      SectionHeader(title: loc.translate('revenueGrowth')),
                      const SizedBox(height: 14),

                      MedicalCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ProtectedFinancialText(
                                    actualValue: loc.translate('monthlyRevenue'),
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                  ),
                                ),
                                const Text('2026', style: TextStyle(color: AppColors.primaryDark, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              height: 180,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: _trends.map((t) {
                                  const maxVal = 30000.0;
                                  final heightRatio = (t.amount / maxVal).clamp(0.1, 1.0);

                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        '${(t.amount / 1000).toStringAsFixed(1)}k',
                                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 4),
                                      AnimatedContainer(
                                        duration: const Duration(milliseconds: 600),
                                        width: 24,
                                        height: 130 * heightRatio,
                                        decoration: BoxDecoration(
                                          gradient: AppColors.primaryGradient,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        t.month,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: isDark ? AppColors.textMutedDark : AppColors.textMutedLight,
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Export Buttons Row
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('${loc.translate('exportPdf')}...')),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28),
                                ),
                              ),
                              icon: const Icon(Icons.picture_as_pdf_rounded, color: AppColors.error),
                              label: Text(loc.translate('exportPdf')),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('${loc.translate('exportExcel')}...')),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28),
                                ),
                              ),
                              icon: const Icon(Icons.table_chart_rounded, color: AppColors.success),
                              label: Text(loc.translate('exportExcel')),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}