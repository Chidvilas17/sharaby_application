import 'package:flutter/material.dart';

/// Financial Security Manager providing per-session security code verification (default PIN 1234)
class FinancialSecurityService extends ChangeNotifier {
  static final FinancialSecurityService _instance = FinancialSecurityService._internal();
  factory FinancialSecurityService() => _instance;
  FinancialSecurityService._internal();

  bool _isRevealed = false;
  String _correctPin = '1234';

  bool get isRevealed => _isRevealed;

  /// Attempts to unlock financial values with provided PIN
  bool unlock(String pin) {
    if (pin == _correctPin) {
      _isRevealed = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  /// Lock values again
  void lock() {
    _isRevealed = false;
    notifyListeners();
  }

  /// Reset on user logout
  void resetOnLogout() {
    _isRevealed = false;
    notifyListeners();
  }

  /// Update PIN (for future backend authentication integration)
  void setPin(String newPin) {
    _correctPin = newPin;
  }
}

class FinancialSecurityInheritedWidget extends InheritedNotifier<FinancialSecurityService> {
  const FinancialSecurityInheritedWidget({
    super.key,
    required FinancialSecurityService securityService,
    required super.child,
  }) : super(notifier: securityService);

  static FinancialSecurityService of(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<FinancialSecurityInheritedWidget>();
    return widget?.notifier ?? FinancialSecurityService();
  }
}
