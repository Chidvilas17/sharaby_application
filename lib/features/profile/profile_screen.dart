import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_localizations.dart';
import '../../shared/widgets/animated_glass_background.dart';
import '../../shared/widgets/custom_app_bar.dart';
import '../../shared/widgets/glass_card.dart';
import '../../shared/widgets/gradient_button.dart';
import '../../shared/widgets/profile_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _doctorName = AppConstants.defaultDoctorName;
  final String _doctorTitle = AppConstants.defaultDoctorTitle;
  String _phone = AppConstants.clinicPhone;
  String _email = 'dr.sharaby@sharabyclinic.com';
  String _address = AppConstants.clinicAddress;

  void _showEditProfileModal() {
    final nameCtrl = TextEditingController(text: _doctorName);
    final phoneCtrl = TextEditingController(text: _phone);
    final emailCtrl = TextEditingController(text: _email);
    final addressCtrl = TextEditingController(text: _address);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final loc = AppLocalizations.of(context);
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: GlassCard(
            borderRadius: 28,
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        loc.translate('editProfile'),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.textPrimaryDark : AppColors.primaryDark,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Avatar Picture Picker with Official Logo
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.shadowBlue,
                                blurRadius: 16,
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 38,
                            backgroundColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Image.asset(
                                'assets/images/logo.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: AppColors.primaryDark,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Name Field
                  TextField(
                    controller: nameCtrl,
                    decoration: InputDecoration(
                      labelText: loc.translate('fullName'),
                      prefixIcon: const Icon(Icons.person_outline, color: AppColors.primary),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Phone Field
                  TextField(
                    controller: phoneCtrl,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: loc.translate('phone'),
                      prefixIcon: const Icon(Icons.phone_outlined, color: AppColors.primary),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Email Field
                  TextField(
                    controller: emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: loc.translate('email'),
                      prefixIcon: const Icon(Icons.email_outlined, color: AppColors.primary),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Address Field
                  TextField(
                    controller: addressCtrl,
                    decoration: InputDecoration(
                      labelText: loc.translate('address'),
                      prefixIcon: const Icon(Icons.location_on_outlined, color: AppColors.primary),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Save Button
                  GradientButton(
                    text: loc.translate('saveChanges').toUpperCase(),
                    icon: Icons.check_circle_rounded,
                    onPressed: () {
                      setState(() {
                        _doctorName = nameCtrl.text.trim();
                        _phone = phoneCtrl.text.trim();
                        _email = emailCtrl.text.trim();
                        _address = addressCtrl.text.trim();
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: AppColors.success,
                          content: Text(loc.translate('profileUpdated')),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: loc.translate('navProfile'),
      ),
      body: AnimatedGlassBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              children: [
                // Header Card with Avatar & Glowing Badge
                GlassCard(
                  borderRadius: 28,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: AppColors.heroGradient,
                            ),
                            child: CircleAvatar(
                              radius: 46,
                              backgroundColor: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  'assets/images/logo.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 2,
                            right: 2,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: AppColors.accent,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.verified_rounded,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Text(
                        _doctorName,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.primaryDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _doctorTitle,
                        style: TextStyle(
                          color: isDark
                              ? AppColors.textMutedDark
                              : AppColors.textMutedLight,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.medical_services_rounded,
                              color: AppColors.primaryDark,
                              size: 14,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              loc.translate('doctorRole'),
                              style: const TextStyle(
                                color: AppColors.primaryDark,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Profile Tiles
                ProfileTile(
                  label: loc.translate('fullName'),
                  value: _doctorName,
                  icon: Icons.person_outline_rounded,
                  onTap: _showEditProfileModal,
                ),
                ProfileTile(
                  label: loc.translate('phone'),
                  value: _phone,
                  icon: Icons.phone_outlined,
                  onTap: _showEditProfileModal,
                ),
                ProfileTile(
                  label: loc.translate('email'),
                  value: _email,
                  icon: Icons.email_outlined,
                  onTap: _showEditProfileModal,
                ),
                ProfileTile(
                  label: loc.translate('address'),
                  value: _address,
                  icon: Icons.location_on_outlined,
                  onTap: _showEditProfileModal,
                ),
                const SizedBox(height: 16),

                // Edit Profile Action Button
                GradientButton(
                  text: loc.translate('editProfile').toUpperCase(),
                  icon: Icons.edit_rounded,
                  onPressed: _showEditProfileModal,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}