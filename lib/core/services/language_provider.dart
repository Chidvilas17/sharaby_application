import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Centralized Language Provider supporting English & Arabic with RTL switching & persistence
class LanguageProvider extends ChangeNotifier {
  static const String _prefLanguageKey = 'selected_language_code';

  Locale _locale = const Locale('en');

  Locale get locale => _locale;
  bool get isArabic => _locale.languageCode == 'ar';
  TextDirection get textDirection =>
      isArabic ? TextDirection.rtl : TextDirection.ltr;

  LanguageProvider() {
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString(_prefLanguageKey) ?? 'en';
    _locale = Locale(langCode);
    notifyListeners();
  }

  Future<void> setLanguage(String languageCode) async {
    if (_locale.languageCode == languageCode) return;
    _locale = Locale(languageCode);
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefLanguageKey, languageCode);
  }

  void toggleLanguage() {
    if (isArabic) {
      setLanguage('en');
    } else {
      setLanguage('ar');
    }
  }
}

/// InheritedWidget wrapper for easy access to LanguageProvider anywhere in widget tree
class LanguageInheritedWidget extends InheritedWidget {
  final LanguageProvider languageProvider;

  const LanguageInheritedWidget({
    super.key,
    required this.languageProvider,
    required super.child,
  });

  static LanguageProvider of(BuildContext context) {
    final widget =
        context.dependOnInheritedWidgetOfExactType<LanguageInheritedWidget>();
    assert(widget != null, 'No LanguageInheritedWidget found in context');
    return widget!.languageProvider;
  }

  @override
  bool updateShouldNotify(covariant LanguageInheritedWidget oldWidget) {
    return oldWidget.languageProvider != languageProvider;
  }
}
