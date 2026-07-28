import 'package:flutter/material.dart';
import '../../shared/widgets/bottom_nav_bar.dart';
import '../../shared/widgets/custom_drawer.dart';
import '../about/about_screen.dart';
import '../appointments/appointments_screen.dart';
import '../billing/billing_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../documents/documents_screen.dart';
import '../patients/patient_list_screen.dart';
import '../prescriptions/prescriptions_screen.dart';
import '../profile/profile_screen.dart';
import '../reports/reports_screen.dart';
import '../settings/settings_screen.dart';

/// Navigation Shell holding the active page state and coordinating Drawer & BottomNavBar
class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    DashboardScreen(),
    PatientListScreen(),
    AppointmentsScreen(),
    PrescriptionsScreen(),
    BillingScreen(),
    ReportsScreen(),
    DocumentsScreen(),
    ProfileScreen(),
    SettingsScreen(),
    AboutScreen(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Show Bottom Navigation Bar only for the primary 5 tabs (Dashboard, Patients, Appointments, Prescriptions, Billing)
    final bool showBottomNav = _currentIndex < 5;

    return Scaffold(
      drawer: CustomDrawer(
        selectedIndex: _currentIndex,
        onItemSelected: _onTabSelected,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: showBottomNav
          ? BottomNavBar(
              selectedIndex: _currentIndex,
              onTabSelected: _onTabSelected,
            )
          : null,
    );
  }
}
