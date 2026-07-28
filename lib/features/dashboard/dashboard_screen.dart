import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/theme_provider.dart';
import '../../shared/models/appointment_model.dart';
import '../../shared/models/invoice_model.dart';
import '../../shared/models/patient_model.dart';
import '../../shared/repositories/appointment_repository.dart';
import '../../shared/repositories/billing_repository.dart';
import '../../shared/repositories/patient_repository.dart';
import '../../shared/widgets/appointment_card.dart';
import '../../shared/widgets/custom_search_bar.dart';
import '../../shared/widgets/invoice_card.dart';
import '../../shared/widgets/loading_widget.dart';
import '../../shared/widgets/patient_card.dart';
import '../../shared/widgets/section_header.dart';
import '../../shared/widgets/stat_card.dart';
import '../appointments/book_appointment_dialog.dart';
import '../patients/add_edit_patient_dialog.dart';
import '../prescriptions/create_prescription_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PatientRepository _patientRepo = MockPatientRepository();
  final AppointmentRepository _appointmentRepo = MockAppointmentRepository();
  final BillingRepository _billingRepo = MockBillingRepository();

  bool _isLoading = true;
  List<PatientModel> _recentPatients = [];
  List<AppointmentModel> _todaysAppointments = [];
  List<InvoiceModel> _pendingInvoices = [];

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    setState(() => _isLoading = true);
    final patients = await _patientRepo.getPatients();
    final appointments = await _appointmentRepo.getAppointments();
    final invoices = await _billingRepo.getInvoices();

    if (mounted) {
      setState(() {
        _recentPatients = patients.take(3).toList();
        _todaysAppointments = appointments;
        _pendingInvoices = invoices.where((i) => i.totalAmount > 0).take(2).toList();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeProvider = ThemeInheritedWidget.of(context);

    if (_isLoading) {
      return const Scaffold(
        body: LoadingWidget(message: 'Loading Dashboard...'),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadDashboardData,
          color: AppColors.primary,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header Row with Drawer Toggle, Greeting & Notification Bell
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.cardDark
                                  : AppColors.cardLight,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: const Icon(Icons.menu_rounded,
                                color: AppColors.primary),
                          ),
                          onPressed: () => Scaffold.of(context).openDrawer(),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Good Morning 👋",
                              style: TextStyle(
                                fontSize: 13,
                                color: isDark
                                    ? AppColors.textMutedDark
                                    : AppColors.textMutedLight,
                              ),
                            ),
                            const Text(
                              AppConstants.defaultDoctorName,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            themeProvider.isDarkMode
                                ? Icons.wb_sunny_rounded
                                : Icons.nightlight_round,
                            color: AppColors.primary,
                          ),
                          onPressed: () => themeProvider.toggleTheme(),
                        ),
                        Stack(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.notifications_none_rounded,
                                  size: 26),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("No new notifications"),
                                  ),
                                );
                              },
                            ),
                            Positioned(
                              right: 10,
                              top: 10,
                              child: Container(
                                width: 9,
                                height: 9,
                                decoration: const BoxDecoration(
                                  color: AppColors.error,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Search Bar
                const CustomSearchBar(
                  hintText: "Search patients, appointments, prescriptions...",
                ),
                const SizedBox(height: 24),

                // Hero Medical Banner
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    gradient: AppColors.heroGradient,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sharaby Clinic Center",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Today's Schedule & Patient Care Overview",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.local_hospital_rounded,
                                color: Colors.white, size: 28),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Quick Action Buttons Grid inside Hero
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => AddEditPatientDialog(
                                  onSaved: (p) => _loadDashboardData(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.person_add_rounded, size: 16),
                            label: const Text("New Patient"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => BookAppointmentDialog(
                                  onBooked: () => _loadDashboardData(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit_calendar_rounded, size: 16),
                            label: const Text("Book Appointment"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withValues(alpha: 0.2),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const CreatePrescriptionScreen(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.post_add_rounded, size: 16),
                            label: const Text("Rx Prescription"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withValues(alpha: 0.2),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Statistics Grid Cards
                const SectionHeader(title: "Clinic Metrics"),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: StatCard(
                        title: "Total Patients",
                        value: "1,248",
                        icon: Icons.people_alt_rounded,
                        color: AppColors.primary,
                        trend: "12%",
                        isPositive: true,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: StatCard(
                        title: "Today's Visits",
                        value: "${_todaysAppointments.length}",
                        icon: Icons.calendar_month_rounded,
                        color: AppColors.accent,
                        trend: "5%",
                        isPositive: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: StatCard(
                        title: "Pending Bills",
                        value: "\$3,450",
                        icon: Icons.receipt_long_rounded,
                        color: AppColors.warning,
                        trend: "2%",
                        isPositive: false,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: StatCard(
                        title: "Prescriptions",
                        value: "342",
                        icon: Icons.description_rounded,
                        color: AppColors.success,
                        trend: "8%",
                        isPositive: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // Today's Appointments Section
                SectionHeader(
                  title: "Today's Appointments",
                  actionText: "View All",
                  onActionTap: () {
                    // Handled by tab navigation
                  },
                ),
                const SizedBox(height: 12),
                if (_todaysAppointments.isEmpty)
                  const Text("No appointments scheduled for today.")
                else
                  Column(
                    children: _todaysAppointments
                        .take(2)
                        .map(
                          (apt) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: AppointmentCard(appointment: apt),
                          ),
                        )
                        .toList(),
                  ),
                const SizedBox(height: 24),

                // Recent Patients Section
                const SectionHeader(title: "Recent Patient Records"),
                const SizedBox(height: 12),
                Column(
                  children: _recentPatients
                      .map(
                        (patient) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: PatientCard(patient: patient),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 24),

                // Pending Bills Overview
                const SectionHeader(title: "Outstanding Invoices"),
                const SizedBox(height: 12),
                Column(
                  children: _pendingInvoices
                      .map(
                        (inv) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: InvoiceCard(invoice: inv),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}