import 'package:flutter/material.dart';
import '../../shared/widgets/bottom_nav_bar.dart';
import '../../shared/widgets/custom_drawer.dart';
import '../about/about_screen.dart';
import '../appointments/appointments_screen.dart';
import '../billing/billing_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../doctor_help/widgets/doctor_help_floating_button.dart';
import '../documents/documents_screen.dart';
import '../notifications/notifications_screen.dart';
import '../patients/patient_list_screen.dart';
import '../prescriptions/prescriptions_screen.dart';
import '../profile/profile_screen.dart';
import '../reports/reports_screen.dart';
import '../settings/settings_screen.dart';

/// Navigation Shell holding active page state and coordinating Drawer & BottomNavBar
class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  static MainNavigationShellState? of(BuildContext context) {
    return context.findAncestorStateOfType<MainNavigationShellState>();
  }

  @override
  State<MainNavigationShell> createState() => MainNavigationShellState();
}

class MainNavigationShellState extends State<MainNavigationShell> {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  final List<Widget> _pages = const [
    DashboardScreen(),
    PatientListScreen(),
    AppointmentsScreen(),
    PrescriptionsScreen(),
    BillingScreen(),
    ReportsScreen(),
    DocumentsScreen(),
    NotificationsScreen(),
    ProfileScreen(),
    SettingsScreen(),
    AboutScreen(),
  ];

  void selectTab(int index) {
    if (index >= 0 && index < _pages.length) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  void returnToDashboard() {
    if (_currentIndex != 0) {
      setState(() {
        _currentIndex = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show Bottom Navigation Bar for primary 5 tabs (Dashboard, Patients, Appointments, Prescriptions, Billing)
    final bool showBottomNav = _currentIndex < 5;

    return PopScope(
      canPop: _currentIndex == 0 && !Navigator.canPop(context),
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          } else if (_currentIndex != 0) {
            returnToDashboard();
          }
        }
      },
      child: Scaffold(
        drawer: CustomDrawer(
          selectedIndex: _currentIndex,
          onItemSelected: selectTab,
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        floatingActionButton: const DoctorHelpFloatingButton(),
        bottomNavigationBar: showBottomNav
            ? BottomNavBar(
                selectedIndex: _currentIndex,
                onTabSelected: selectTab,
              )
            : null,
      ),
    );
  }
}


