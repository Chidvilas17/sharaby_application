import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_localizations.dart';
import '../../shared/widgets/animated_glass_background.dart';
import '../../shared/widgets/custom_app_bar.dart';
import '../../shared/widgets/notification_card.dart';

/// Notifications Screen with timeline cards and filter options
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  int _selectedFilter = 0; // 0 = All, 1 = Unread

  final List<Map<String, dynamic>> _notifications = [
    {
      'id': '1',
      'title': 'New Patient Added',
      'message': 'Mohamed Ali was registered as a new patient by Reception.',
      'time': '5 mins ago',
      'icon': Icons.person_add_alt_1_rounded,
      'color': AppColors.primaryDark,
      'isRead': false,
    },
    {
      'id': '2',
      'title': 'Prescription Created',
      'message': 'Dr. Ahmed Sharaby generated a new Rx for Sarah Mansour.',
      'time': '30 mins ago',
      'icon': Icons.description_rounded,
      'color': AppColors.accent,
      'isRead': false,
    },
    {
      'id': '3',
      'title': 'Appointment Scheduled',
      'message': 'Dental checkup appointment confirmed for tomorrow at 10:30 AM.',
      'time': '1 hour ago',
      'icon': Icons.calendar_month_rounded,
      'color': AppColors.info,
      'isRead': false,
    },
    {
      'id': '4',
      'title': 'Billing Invoice Generated',
      'message': 'Invoice #INV-2026-089 (EGP 1,200) generated successfully.',
      'time': '3 hours ago',
      'icon': Icons.receipt_long_rounded,
      'color': AppColors.success,
      'isRead': true,
    },
    {
      'id': '5',
      'title': 'Patient Profile Updated',
      'message': 'Khaled Mahmoud updated contact phone number and address.',
      'time': 'Yesterday',
      'icon': Icons.edit_note_rounded,
      'color': AppColors.warning,
      'isRead': true,
    },
  ];

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
                            onTap: () {
                              setState(() {
                                item['isRead'] = true;
                              });
                            },
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
