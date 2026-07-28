class AnalyticsMetric {
  final String label;
  final double value;
  final double previousValue;
  final String unit;

  const AnalyticsMetric({
    required this.label,
    required this.value,
    required this.previousValue,
    this.unit = '',
  });

  double get growthPercentage {
    if (previousValue == 0) return 0;
    return ((value - previousValue) / previousValue) * 100;
  }
}

class RevenueTrendPoint {
  final String month;
  final double amount;

  const RevenueTrendPoint(this.month, this.amount);
}
