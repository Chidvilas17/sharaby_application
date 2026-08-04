/// Custom formatters for dates, times, and currencies
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

  /// Formats amounts using Egyptian Pound currency (EGP) with thousands separation
  static String formatCurrency(double amount, {String currency = 'EGP'}) {
    final isNegative = amount < 0;
    final absAmount = amount.abs();
    final parts = absAmount.toStringAsFixed(amount % 1 == 0 ? 0 : 2).split('.');
    
    // Add comma separators
    final integerPart = parts[0];
    final buffer = StringBuffer();
    for (int i = 0; i < integerPart.length; i++) {
      if (i > 0 && (integerPart.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(integerPart[i]);
    }
    
    final formattedNumber = parts.length > 1 ? '${buffer.toString()}.${parts[1]}' : buffer.toString();
    final sign = isNegative ? '-' : '';
    return '$currency $sign$formattedNumber';
  }
}
