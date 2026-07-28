import 'package:flutter/material.dart';

/// App Theme State Provider for toggling Light / Dark themes dynamically
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}

/// InheritedWidget wrapper for ThemeProvider access across the widget tree
class ThemeInheritedWidget extends InheritedNotifier<ThemeProvider> {
  const ThemeInheritedWidget({
    super.key,
    required ThemeProvider themeProvider,
    required super.child,
  }) : super(notifier: themeProvider);

  static ThemeProvider of(BuildContext context) {
    final widget =
        context.dependOnInheritedWidgetOfExactType<ThemeInheritedWidget>();
    return widget?.notifier ?? ThemeProvider();
  }
}
