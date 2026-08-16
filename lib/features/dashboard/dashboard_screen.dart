import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_decorations.dart';
import '../../core/theme/theme_provider.dart';
import '../../core/utils/app_localizations.dart';
import '../../shared/models/appointment_model.dart';
import '../../shared/models/invoice_model.dart';
import '../../shared/models/patient_model.dart';
import '../../shared/models/prescription_model.dart';
import '../../shared/repositories/appointment_repository.dart';
import '../../shared/repositories/billing_repository.dart';
import '../../shared/repositories/patient_repository.dart';
import '../../shared/repositories/prescription_repository.dart';
import '../../shared/widgets/animated_glass_background.dart';
import '../../shared/widgets/custom_search_bar.dart';
import '../../shared/widgets/glass_card.dart';
import '../../shared/widgets/invoice_card.dart';
import '../../shared/widgets/loading_widget.dart';
import '../../shared/widgets/medical_banner.dart';
import '../../shared/widgets/patient_card.dart';
import '../../shared/widgets/prescription_card.dart';
import '../../shared/widgets/section_header.dart';
import '../../shared/widgets/stat_card.dart';
import '../navigation/main_navigation_shell.dart';
import '../notifications/notifications_screen.dart';
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
  final PrescriptionRepository _prescriptionRepo = MockPrescriptionRepository();

  bool _isLoading = true;
  List<PatientModel> _recentPatients = [];
  List<AppointmentModel> _todaysAppointments = [];
  List<PrescriptionModel> _recentPrescriptions = [];
  List<InvoiceModel> _recentInvoices = [];

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
    final rxList = await _prescriptionRepo.getPrescriptions();

    if (mounted) {
      setState(() {
        _recentPatients = patients.take(3).toList();
        _todaysAppointments = appointments;
        _recentPrescriptions = rxList.take(2).toList();
        _recentInvoices = invoices.take(2).toList();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeProvider = ThemeInheritedWidget.of(context);
    final loc = AppLocalizations.of(context);

    if (_isLoading) {
      return Scaffold(
        body: LoadingWidget(message: loc.translate('medicalBannerTitle')),
      );
    }

    return Scaffold(
      body: AnimatedGlassBackground(
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: _loadDashboardData,
            color: AppColors.primary,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Header: Hamburger Drawer, Doctor Greeting, Theme Toggle & Notification Badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: AppDecorations.glossyIconBoxDecoration(
                                color: AppColors.primaryDark,
                                isDark: isDark,
                                isCircle: true,
                              ),
                              child: const Icon(
                                Icons.menu_rounded,
                                color: AppColors.primaryDark,
                                size: 22,
                              ),
                            ),
                            onPressed: () => Scaffold.of(context).openDrawer(),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                loc.translate('greetingDay'),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: isDark
                                      ? AppColors.textMutedDark
                                      : AppColors.textMutedLight,
                                ),
                              ),
                              const Text(
                                AppConstants.defaultDoctorName,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -0.3,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          // Theme Switcher Button
                          IconButton(
                            icon: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: AppDecorations.glossyIconBoxDecoration(
                                color: AppColors.primaryDark,
                                isDark: isDark,
                                isCircle: true,
                              ),
                              child: Icon(
                                themeProvider.isDarkMode
                                    ? Icons.wb_sunny_rounded
                                    : Icons.nightlight_round,
                                color: AppColors.primaryDark,
                                size: 20,
                              ),
                            ),
                            onPressed: () => themeProvider.toggleTheme(),
                          ),
                          const SizedBox(width: 6),
                          // Notifications Button with Unread Badge
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, anim1, anim2) =>
                                      const NotificationsScreen(),
                                  transitionsBuilder:
                                      (context, animation, secondaryAnimation, child) => FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  ),
                                ),
                              );
                            },
                            child: Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: AppDecorations.glossyIconBoxDecoration(
                                    color: AppColors.primaryDark,
                                    isDark: isDark,
                                    isCircle: true,
                                  ),
                                  child: const Icon(
                                    Icons.notifications_none_rounded,
                                    color: AppColors.primaryDark,
                                    size: 22,
                                  ),
                                ),
                                Positioned(
                                  right: 6,
                                  top: 6,
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
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Search Bar
                  CustomSearchBar(
                    hintText: loc.translate('searchPlaceholder'),
                  ),
                  const SizedBox(height: 20),

                  // Medical Banner (Replaces "Book Appointment" per requirements)
                  MedicalBanner(
                    title: loc.translate('medicalBannerTitle'),
                    subtitle: loc.translate('medicalBannerSubtitle'),
                  ),
                  const SizedBox(height: 24),

                  // Quick Actions Row
                  Text(
                    loc.translate('quickActions'),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildQuickActionTile(
                        context: context,
                        label: loc.translate('actionAddPatient'),
                        icon: Icons.person_add_alt_1_rounded,
                        color: AppColors.primaryDark,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => AddEditPatientDialog(
                              onSaved: (p) => _loadDashboardData(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 10),
                      _buildQuickActionTile(
                        context: context,
                        label: loc.translate('actionNewPrescription'),
                        icon: Icons.post_add_rounded,
                        color: AppColors.accent,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CreatePrescriptionScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 10),
                      _buildQuickActionTile(
                        context: context,
                        label: loc.translate('actionViewReports'),
                        icon: Icons.analytics_rounded,
                        color: AppColors.success,
                        onTap: () {
                          MainNavigationShell.of(context)?.selectTab(5);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Statistics Grid Cards
                  Text(
                    loc.translate('clinicOverview'),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    shrinkWrap: true,
                    childAspectRatio: 1.15,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      StatCard(
                        title: loc.translate('statTotalPatients'),
                        value: "1,248",
                        icon: Icons.people_alt_rounded,
                        color: AppColors.primaryDark,
                        trend: "+12%",
                        isPositive: true,
                      ),
                      StatCard(
                        title: loc.translate('statAppointments'),
                        value: "${_todaysAppointments.length}",
                        icon: Icons.calendar_month_rounded,
                        color: AppColors.accent,
                        trend: "+5%",
                        isPositive: true,
                      ),
                      StatCard(
                        title: loc.translate('statPrescriptions'),
                        value: "342",
                        icon: Icons.description_rounded,
                        color: AppColors.success,
                        trend: "+8%",
                        isPositive: true,
                      ),
                      StatCard(
                        title: loc.translate('statBilling'),
                        value: "EGP 45,800",
                        isFinancial: true,
                        icon: Icons.account_balance_wallet_rounded,
                        color: AppColors.info,
                        trend: "+15%",
                        isPositive: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Today's Activity Log Section
                  SectionHeader(
                    title: loc.translate('todaysActivity'),
                  ),
                  const SizedBox(height: 12),
                  GlassCard(
                    padding: const EdgeInsets.all(16),
                    borderRadius: 20,
                    child: Column(
                      children: [
                        _buildActivityItem(
                          context: context,
                          icon: Icons.check_circle_rounded,
                          color: AppColors.success,
                          title: 'Pediatric Visit Completed',
                          subtitle: 'Patient Adam Mohamed • 09:30 AM',
                        ),
                        const Divider(height: 16),
                        _buildActivityItem(
                          context: context,
                          icon: Icons.access_time_filled_rounded,
                          color: AppColors.warning,
                          title: 'Growth Check In Progress',
                          subtitle: 'Patient Lina Ahmed • 11:00 AM',
                        ),
                        const Divider(height: 16),
                        _buildActivityItem(
                          context: context,
                          icon: Icons.receipt_long_rounded,
                          color: AppColors.primaryDark,
                          title: 'Payment Received (EGP 450)',
                          subtitle: 'Invoice #INV-2026-042 • 11:45 AM',
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Recent Patients Section
                  SectionHeader(
                    title: loc.translate('recentPatients'),
                    actionText: loc.translate('viewAll'),
                    onActionTap: () {
                      MainNavigationShell.of(context)?.selectTab(1);
                    },
                  ),
                  const SizedBox(height: 12),
                  Column(
                    children: _recentPatients
                        .map(
                          (patient) => PatientCard(patient: patient),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 20),

                  // Recent Prescriptions Section
                  SectionHeader(
                    title: loc.translate('recentPrescriptions'),
                    actionText: loc.translate('viewAll'),
                    onActionTap: () {
                      MainNavigationShell.of(context)?.selectTab(3);
                    },
                  ),
                  const SizedBox(height: 12),
                  Column(
                    children: _recentPrescriptions
                        .map(
                          (rx) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: PrescriptionCard(prescription: rx),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 20),

                  // Recent Billing Invoices
                  SectionHeader(
                    title: loc.translate('recentBilling'),
                    actionText: loc.translate('viewAll'),
                    onActionTap: () {
                      MainNavigationShell.of(context)?.selectTab(4);
                    },
                  ),

                  const SizedBox(height: 12),
                  Column(
                    children: _recentInvoices
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
      ),
    );
  }

  Widget _buildQuickActionTile({
    required BuildContext context,
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Expanded(
      child: GlassCard(
        onTap: onTap,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        borderRadius: 20,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(11),
              decoration: AppDecorations.glossyIconBoxDecoration(
                color: color,
                isDark: isDark,
                borderRadius: 16,
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textPrimaryDark : AppColors.primaryDark,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem({
    required BuildContext context,
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(9),
          decoration: AppDecorations.glossyIconBoxDecoration(
            color: color,
            isDark: isDark,
            borderRadius: 14,
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 11.5,
                  color: AppColors.textMutedLight,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}