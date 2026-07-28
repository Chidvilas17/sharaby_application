import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/models/report_stat_model.dart';
import '../../shared/repositories/report_repository.dart';
import '../../shared/widgets/loading_widget.dart';
import '../../shared/widgets/medical_card.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports & Analytics'),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded, color: AppColors.primary),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        actions: [
          PopupMenuButton<String>(
            initialValue: _selectedRange,
            onSelected: (val) => setState(() => _selectedRange = val),
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'This Week', child: Text('This Week')),
              PopupMenuItem(value: 'This Month', child: Text('This Month')),
              PopupMenuItem(value: 'This Year', child: Text('This Year')),
            ],
            icon: const Icon(Icons.filter_alt_rounded, color: AppColors.primary),
          ),
        ],
      ),
      body: _isLoading
          ? const LoadingWidget(message: 'Generating analytics report...')
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Performance Summary ($_selectedRange)',
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
                        childAspectRatio: 1.3,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: _metrics.length,
                      itemBuilder: (context, index) {
                        final m = _metrics[index];
                        return StatCard(
                          title: m.label,
                          value: '${m.unit}${m.value.toInt()}',
                          icon: index == 0
                              ? Icons.monetization_on_rounded
                              : (index == 1
                                  ? Icons.people_alt_rounded
                                  : (index == 2
                                      ? Icons.event_available_rounded
                                      : Icons.pending_actions_rounded)),
                          color: index == 0
                              ? AppColors.success
                              : (index == 1 ? AppColors.primary : AppColors.accent),
                          trend: '${m.growthPercentage.abs().toStringAsFixed(1)}%',
                          isPositive: m.growthPercentage >= 0,
                        );
                      },
                    ),
                    const SizedBox(height: 28),

                    // Custom Revenue Visualizer Chart Bar Card
                    const SectionHeader(title: 'Revenue Growth Trend'),
                    const SizedBox(height: 14),

                    MedicalCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Monthly Revenue (\$) ',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text('2026', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
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
                                const SnackBar(content: Text('Exporting PDF Report...')),
                              );
                            },
                            icon: const Icon(Icons.picture_as_pdf_rounded, color: AppColors.error),
                            label: const Text('Export PDF'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Exporting Excel Sheet...')),
                              );
                            },
                            icon: const Icon(Icons.table_chart_rounded, color: AppColors.success),
                            label: const Text('Export Excel'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}