import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/services/language_provider.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'core/utils/app_localizations.dart';
import 'features/splash/splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const SharabyCenterAppRoot());
}

class SharabyCenterAppRoot extends StatefulWidget {
  const SharabyCenterAppRoot({super.key});

  @override
  State<SharabyCenterAppRoot> createState() => _SharabyCenterAppRootState();
}

class _SharabyCenterAppRootState extends State<SharabyCenterAppRoot> {
  final ThemeProvider _themeProvider = ThemeProvider();
  final LanguageProvider _languageProvider = LanguageProvider();

  @override
  Widget build(BuildContext context) {
    return ThemeInheritedWidget(
      themeProvider: _themeProvider,
      child: LanguageInheritedWidget(
        languageProvider: _languageProvider,
        child: ListenableBuilder(
          listenable: Listenable.merge([_themeProvider, _languageProvider]),
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Sharaby Center',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: _themeProvider.themeMode,
              locale: _languageProvider.locale,
              supportedLocales: const [
                Locale('en', ''),
                Locale('ar', ''),
              ],
              localizationsDelegates: const [
                AppLocalizationsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              home: const SplashScreen(),
            );
          },
        ),
      ),
    );
  }
}