import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_decorations.dart';
import '../../core/utils/app_localizations.dart';
import '../app_help/app_help_screen.dart';
import '../doctor_assistant/doctor_assistant_screen.dart';
import '../doctor_help/doctor_help_screen.dart';
import '../doctor_tools/doctor_tools_screen.dart';

/// Collapsible 4-Option Floating Assistant FAB Widget
class CollapsibleAssistantFab extends StatefulWidget {
  const CollapsibleAssistantFab({super.key});

  @override
  State<CollapsibleAssistantFab> createState() =>
      _CollapsibleAssistantFabState();
}

class _CollapsibleAssistantFabState extends State<CollapsibleAssistantFab>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _expandAnimation;
  late Animation<double> _rotationAnimation;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 240),
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.125).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  void _collapseAndNavigate(Widget targetScreen) {
    if (_isExpanded) {
      _toggleMenu();
    }
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, anim1, anim2) => targetScreen,
        transitionsBuilder: (context, anim1, anim2, child) {
          return FadeTransition(opacity: anim1, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loc = AppLocalizations.of(context);
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8, right: 8, left: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            isRtl ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          // Staggered Vertical List of 4 Glossy Options
          if (_isExpanded || _controller.isAnimating)
            SizeTransition(
              sizeFactor: _expandAnimation,
              alignment: Alignment.bottomCenter,
              child: FadeTransition(
                opacity: _expandAnimation,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: isRtl
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                    children: [
                      // Option 1: AI Medical Help (Existing fixed clinical Q&A)
                      _buildOptionTile(
                        context: context,
                        title: loc.translate('aiMedicalHelpTitle'),
                        subtitle: loc.translate('aiMedicalHelpSub'),
                        icon: Icons.auto_awesome_rounded,
                        iconColor: AppColors.primaryDark,
                        isDark: isDark,
                        onTap: () =>
                            _collapseAndNavigate(const DoctorHelpScreen()),
                      ),
                      const SizedBox(height: 10),

                      // Option 2: App Help (Application usage guide)
                      _buildOptionTile(
                        context: context,
                        title: loc.translate('appHelpTitle'),
                        subtitle: loc.translate('appHelpSub'),
                        icon: Icons.help_center_rounded,
                        iconColor: AppColors.accent,
                        isDark: isDark,
                        onTap: () =>
                            _collapseAndNavigate(const AppHelpScreen()),
                      ),
                      const SizedBox(height: 10),

                      // Option 3: Doctor Tools (Placeholder)
                      _buildOptionTile(
                        context: context,
                        title: loc.translate('doctorToolsTitle'),
                        subtitle: loc.translate('doctorToolsSub'),
                        icon: Icons.medical_services_rounded,
                        iconColor: AppColors.warning,
                        isDark: isDark,
                        onTap: () =>
                            _collapseAndNavigate(const DoctorToolsScreen()),
                      ),
                      const SizedBox(height: 10),

                      // Option 4: Doctor Assistant (Placeholder)
                      _buildOptionTile(
                        context: context,
                        title: loc.translate('doctorAssistantTitle'),
                        subtitle: loc.translate('doctorAssistantSub'),
                        icon: Icons.psychology_rounded,
                        iconColor: AppColors.success,
                        isDark: isDark,
                        onTap: () => _collapseAndNavigate(
                            const DoctorAssistantScreen()),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Main Collapsed Trigger Button
          GestureDetector(
            onTap: _toggleMenu,
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.white,
                  width: 1.5,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 6,
                    offset: Offset(0, -2),
                  ),
                  BoxShadow(
                    color: AppColors.primaryDark,
                    blurRadius: 18,
                    spreadRadius: 0,
                    offset: Offset(0, 6),
                  ),
                  BoxShadow(
                    color: AppColors.glowBlue,
                    blurRadius: 12,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RotationTransition(
                    turns: _rotationAnimation,
                    child: Icon(
                      _isExpanded
                          ? Icons.close_rounded
                          : Icons.auto_awesome_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    loc.translate('assistantFabHelp'),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 270,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: AppDecorations.glassBoxDecoration(
          isDark: isDark,
          borderRadius: 18,
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.6),
            width: 1.2,
          ),
          shadows: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.4)
                  : AppColors.primaryDark.withValues(alpha: 0.15),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
            const BoxShadow(
              color: AppColors.glowBlue,
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: AppDecorations.glossyIconBoxDecoration(
                color: iconColor,
                isDark: isDark,
                borderRadius: 12,
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark
                          ? AppColors.textMutedDark
                          : AppColors.textMutedLight,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
