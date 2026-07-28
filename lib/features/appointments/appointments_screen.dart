import 'package:flutter/material.dart';
import '../../core/constants/app_enums.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/models/appointment_model.dart';
import '../../shared/repositories/appointment_repository.dart';
import '../../shared/widgets/appointment_card.dart';
import '../../shared/widgets/empty_state_widget.dart';
import '../../shared/widgets/loading_widget.dart';
import 'book_appointment_dialog.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen>
    with SingleTickerProviderStateMixin {
  final AppointmentRepository _appointmentRepo = MockAppointmentRepository();
  late TabController _tabController;

  List<AppointmentModel> _appointments = [];
  bool _isLoading = true;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _fetchAppointments();
  }

  Future<void> _fetchAppointments() async {
    setState(() => _isLoading = true);
    final list = await _appointmentRepo.getAppointments();
    if (mounted) {
      setState(() {
        _appointments = list;
        _isLoading = false;
      });
    }
  }

  List<AppointmentModel> _filterByStatus(AppointmentStatus? status) {
    if (status == null) return _appointments;
    return _appointments.where((a) => a.status == status).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments Schedule'),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded, color: AppColors.primary),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: isDark
              ? AppColors.textMutedDark
              : AppColors.textMutedLight,
          indicatorColor: AppColors.primary,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Confirmed'),
            Tab(text: 'In Progress'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      body: _isLoading
          ? const LoadingWidget(message: 'Loading schedule...')
          : SafeArea(
              child: Column(
                children: [
                  // Horizontal Date Picker Bar
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    color: isDark ? AppColors.cardDark : AppColors.cardLight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.calendar_today_rounded,
                                color: AppColors.primary, size: 20),
                            const SizedBox(width: 10),
                            Text(
                              '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        TextButton.icon(
                          onPressed: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: _selectedDate,
                              firstDate: DateTime(2025),
                              lastDate: DateTime(2030),
                            );
                            if (picked != null) {
                              setState(() => _selectedDate = picked);
                            }
                          },
                          icon: const Icon(Icons.edit_calendar_rounded, size: 18),
                          label: const Text('Select Date'),
                        ),
                      ],
                    ),
                  ),

                  // Tab Views
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildAppointmentList(_appointments),
                        _buildAppointmentList(
                            _filterByStatus(AppointmentStatus.confirmed)),
                        _buildAppointmentList(
                            _filterByStatus(AppointmentStatus.inProgress)),
                        _buildAppointmentList(
                            _filterByStatus(AppointmentStatus.completed)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => BookAppointmentDialog(
              onBooked: _fetchAppointments,
            ),
          );
        },
        icon: const Icon(Icons.add_task_rounded),
        label: const Text('Book Appointment'),
      ),
    );
  }

  Widget _buildAppointmentList(List<AppointmentModel> list) {
    if (list.isEmpty) {
      return EmptyStateWidget(
        title: 'No Appointments Scheduled',
        message: 'There are no appointments matching this category.',
        icon: Icons.event_available_rounded,
        buttonText: 'Book New Appointment',
        onButtonPressed: () {
          showDialog(
            context: context,
            builder: (_) => BookAppointmentDialog(
              onBooked: _fetchAppointments,
            ),
          );
        },
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final appointment = list[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: AppointmentCard(
            appointment: appointment,
            onStatusTap: () {
              _showStatusChangeSheet(appointment);
            },
          ),
        );
      },
    );
  }

  void _showStatusChangeSheet(AppointmentModel appointment) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Update Appointment Status',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...AppointmentStatus.values.map((status) {
                return ListTile(
                  title: Text(status.name.toUpperCase()),
                  onTap: () async {
                    Navigator.pop(context);
                    await _appointmentRepo.updateAppointment(
                      appointment.copyWith(status: status),
                    );
                    _fetchAppointments();
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
