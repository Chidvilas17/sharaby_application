import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_localizations.dart';
import '../../shared/repositories/patient_repository.dart';
import '../../shared/widgets/animated_glass_background.dart';
import '../../shared/widgets/custom_app_bar.dart';
import '../../shared/widgets/notification_card.dart';
import '../call_identification/call_identification_service.dart';
import '../patients/patient_detail_screen.dart';

/// Notifications Screen with timeline cards, missed call alerts, and filter options
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  int _selectedFilter = 0; // 0 = All, 1 = Unread
  final PatientRepository _patientRepository = MockPatientRepository();
  final CallIdentificationService _callService = CallIdentificationService();

  final List<Map<String, dynamic>> _notifications = [
    {
      'id': 'call_adam_001',
      'title': 'Missed Patient Call',
      'message': 'Adam Mohamed missed a call. Tap to view patient details.',
      'time': 'Just now',
      'icon': Icons.phone_missed_rounded,
      'color': AppColors.error,
      'isRead': false,
      'patientId': 'P1001',
    },
    {
      'id': '1',
      'title': 'New Pediatric Patient Registered',
      'message': 'Adam Mohamed (4 yrs) was registered by Reception.',
      'time': '5 mins ago',
      'icon': Icons.child_care_rounded,
      'color': AppColors.primaryDark,
      'isRead': false,
    },
    {
      'id': '2',
      'title': 'Pediatric Prescription Issued',
      'message': 'Dr. Ahmed Sharaby issued a new Rx for Lina Ahmed (Pediatric Asthma).',
      'time': '30 mins ago',
      'icon': Icons.description_rounded,
      'color': AppColors.accent,
      'isRead': false,
    },
    {
      'id': '3',
      'title': 'Vaccination Due Reminder',
      'message': 'MMR booster vaccination scheduled for Youssef Ali tomorrow at 10:30 AM.',
      'time': '1 hour ago',
      'icon': Icons.vaccines_rounded,
      'color': AppColors.info,
      'isRead': false,
    },
    {
      'id': '4',
      'title': 'Pediatric Visit Invoice Generated',
      'message': 'Invoice #INV-2026-089 (EGP 450) generated for Consultation.',
      'time': '3 hours ago',
      'icon': Icons.receipt_long_rounded,
      'color': AppColors.success,
      'isRead': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _syncCallLog();
  }

  Future<void> _syncCallLog() async {
    final events = await _callService.syncMissedCalls(_patientRepository);
    if (events.isNotEmpty && mounted) {
      final loc = AppLocalizations.of(context);
      setState(() {
        for (final ev in events) {
          final isMatched = ev.patientId != null;
          final title = isMatched
              ? loc.translate('missedCallTitle')
              : loc.translate('unknownCaller');
          final message = isMatched
              ? '${ev.patientName} ${loc.translate('missedCallBody')}'
              : '${loc.translate('unknownCaller')}: ${ev.phoneNumber}';

          _notifications.insert(0, {
            'id': ev.id,
            'title': title,
            'message': message,
            'time': 'Just now',
            'icon': isMatched ? Icons.phone_missed_rounded : Icons.phone_disabled_rounded,
            'color': isMatched ? AppColors.error : AppColors.warning,
            'isRead': false,
            'patientId': ev.patientId,
          });
        }
      });
    }
  }

  void _markAllAsRead() {
    final loc = AppLocalizations.of(context);
    setState(() {
      for (var n in _notifications) {
        n['isRead'] = true;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(loc.translate('markAllRead'))),
    );
  }

  Future<void> _handleNotificationTap(Map<String, dynamic> item) async {
    setState(() {
      item['isRead'] = true;
    });

    final patientId = item['patientId'] as String?;
    if (patientId != null && patientId.isNotEmpty) {
      final patient = await _patientRepository.getPatientById(patientId);
      if (patient != null && mounted) {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, anim1, anim2) =>
                PatientDetailScreen(
                  patient: patient,
                  onPatientUpdated: () {},
                ),
            transitionsBuilder: (context, anim1, anim2, child) =>
                FadeTransition(opacity: anim1, child: child),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loc = AppLocalizations.of(context);

    final filteredList = _notifications.where((n) {
      if (_selectedFilter == 1) return n['isRead'] == false;
      return true;
    }).toList();

    return Scaffold(
      appBar: CustomAppBar(
        title: loc.translate('notificationsTitle'),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all_rounded, color: AppColors.primaryDark),
            tooltip: loc.translate('markAllRead'),
            onPressed: _markAllAsRead,
          ),
        ],
      ),
      body: AnimatedGlassBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Filter Bar (All / Unread)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    _buildFilterChip(0, loc.translate('all')),
                    const SizedBox(width: 10),
                    _buildFilterChip(1, loc.translate('unread')),
                  ],
                ),
              ),
              // Notifications List
              Expanded(
                child: filteredList.isEmpty
                    ? Center(
                        child: Text(
                          loc.translate('noFilesMatch'),
                          style: TextStyle(
                            color: isDark
                                ? AppColors.textMutedDark
                                : AppColors.textMutedLight,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          final item = filteredList[index];
                          return NotificationCard(
                            title: item['title'] as String,
                            message: item['message'] as String,
                            time: item['time'] as String,
                            icon: item['icon'] as IconData,
                            iconColor: item['color'] as Color,
                            isRead: item['isRead'] as bool,
                            onTap: () => _handleNotificationTap(item),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(int index, String label) {
    final isSelected = _selectedFilter == index;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) {
        setState(() {
          _selectedFilter = index;
        });
      },
      selectedColor: AppColors.primaryDark,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : AppColors.primaryDark,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
