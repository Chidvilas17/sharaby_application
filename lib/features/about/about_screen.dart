import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/medical_card.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('About Application'),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded, color: AppColors.primary),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Logo & Branding Hero
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  gradient: AppColors.heroGradient,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.local_hospital_rounded, size: 54, color: AppColors.primary),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      AppConstants.appName,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Version ${AppConstants.appVersion}',
                      style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // App Specs Card
              MedicalCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'System Information',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const ListTile(
                      leading: Icon(Icons.cloud_done_rounded, color: AppColors.success),
                      title: Text('Authentication Backend'),
                      subtitle: Text('Firebase Authentication'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.dns_rounded, color: AppColors.primary),
                      title: Text('Target API Backend'),
                      subtitle: Text('ASP.NET Core Web API + MS SQL Server Express'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.developer_mode_rounded, color: AppColors.accent),
                      title: Text('Framework & Design System'),
                      subtitle: Text('Flutter • Material 3 • Glassmorphism Architecture'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Expandable Privacy & Terms
              MedicalCard(
                child: ExpansionTile(
                  leading: const Icon(Icons.privacy_tip_rounded, color: AppColors.primary),
                  title: const Text('Privacy Policy & Data Security'),
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Sharaby Center Clinic System enforces end-to-end data encryption for patient health records in accordance with medical data privacy guidelines.',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              MedicalCard(
                child: ExpansionTile(
                  leading: const Icon(Icons.gavel_rounded, color: AppColors.accent),
                  title: const Text('Terms of Service'),
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Authorized clinical personnel only. Unauthorized access, export, or distribution of patient records is strictly prohibited.',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}