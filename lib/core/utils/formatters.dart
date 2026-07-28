/// Custom formatters for dates, times, and currencies without external package bloat
class AppFormatters {
  static String formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  static String formatTime(DateTime time) {
    final hour = time.hour == 0 ? 12 : (time.hour > 12 ? time.hour - 12 : time.hour);
    final period = time.hour >= 12 ? 'PM' : 'AM';
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute $period';
  }

  static String formatDateTime(DateTime dt) {
    return '${formatDate(dt)} at ${formatTime(dt)}';
  }

  static String formatCurrency(double amount, {String currency = '\$'}) {
    final formatted = amount.toStringAsFixed(2);
    return '$currency$formatted';
  }
}
