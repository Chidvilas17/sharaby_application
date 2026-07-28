import '../models/report_stat_model.dart';

abstract class ReportRepository {
  Future<List<AnalyticsMetric>> getMetrics();
  Future<List<RevenueTrendPoint>> getRevenueTrends();
}

class MockReportRepository implements ReportRepository {
  @override
  Future<List<AnalyticsMetric>> getMetrics() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return const [
      AnalyticsMetric(
        label: 'Total Revenue',
        value: 24850.0,
        previousValue: 21200.0,
        unit: '\$',
      ),
      AnalyticsMetric(
        label: 'Patient Visits',
        value: 384,
        previousValue: 340,
      ),
      AnalyticsMetric(
        label: 'Appointments Completed',
        value: 312,
        previousValue: 290,
      ),
      AnalyticsMetric(
        label: 'Outstanding Collections',
        value: 3450.0,
        previousValue: 4100.0,
        unit: '\$',
      ),
    ];
  }

  @override
  Future<List<RevenueTrendPoint>> getRevenueTrends() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return const [
      RevenueTrendPoint('Jan', 18500),
      RevenueTrendPoint('Feb', 19200),
      RevenueTrendPoint('Mar', 21000),
      RevenueTrendPoint('Apr', 20500),
      RevenueTrendPoint('May', 22800),
      RevenueTrendPoint('Jun', 23400),
      RevenueTrendPoint('Jul', 24850),
    ];
  }
}
