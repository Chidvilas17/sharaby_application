import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    return ThemeInheritedWidget(
      themeProvider: _themeProvider,
      child: ListenableBuilder(
        listenable: _themeProvider,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Sharaby Center',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: _themeProvider.themeMode,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}