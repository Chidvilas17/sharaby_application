import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:sharaby_center_clinic/features/dashboard/dashboard_screen.dart';
import 'package:sharaby_center_clinic/features/patients/patients_screen.dart';
import 'package:sharaby_center_clinic/features/prescriptions/prescriptions_screen.dart';
import 'package:sharaby_center_clinic/features/billing/billing_screen.dart';
import 'package:sharaby_center_clinic/features/reports/reports_screen.dart';
import 'package:sharaby_center_clinic/features/documents/documents_screen.dart';
import 'package:sharaby_center_clinic/features/profile/profile_screen.dart';
import 'package:sharaby_center_clinic/features/settings/settings_screen.dart';
import 'package:sharaby_center_clinic/features/about/about_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text("Sharaby Center"),
            accountEmail: Text(user?.email ?? "No Email"),
            currentAccountPicture: const CircleAvatar(
              child: Icon(
                Icons.person,
                size: 40,
              ),
            ),
          ),

          // Dashboard
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text("Dashboard"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const DashboardScreen(),
                ),
              );
            },
          ),

          // Patients
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text("Patients"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PatientsScreen(),
                ),
              );
            },
          ),

          // Prescriptions
          ListTile(
            leading: const Icon(Icons.medication),
            title: const Text("Prescriptions"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrescriptionsScreen(),
                ),
              );
            },
          ),

          // Billing
          ListTile(
            leading: const Icon(Icons.receipt_long),
            title: const Text("Billing"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BillingScreen(),
                ),
              );
            },
          ),

          // Reports
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text("Reports"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ReportsScreen(),
                ),
              );
            },
          ),

          // Documents
          ListTile(
            leading: const Icon(Icons.folder),
            title: const Text("Documents"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DocumentsScreen(),
                ),
              );
            },
          ),

          const Divider(),

          // Profile
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text("Profile"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
          ),

          // Settings
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),

          // About
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("About"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutScreen(),
                ),
              );
            },
          ),

          const Divider(),

          // Logout
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () async {
              Navigator.pop(context);
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}