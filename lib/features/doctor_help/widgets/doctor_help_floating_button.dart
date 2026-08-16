import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../doctor_help_screen.dart';

/// Floating Glossy AI Help Button accessible across main app screens
class DoctorHelpFloatingButton extends StatefulWidget {
  final VoidCallback? onTap;

  const DoctorHelpFloatingButton({
    super.key,
    this.onTap,
  });

  @override
  State<DoctorHelpFloatingButton> createState() =>
      _DoctorHelpFloatingButtonState();
}

class _DoctorHelpFloatingButtonState extends State<DoctorHelpFloatingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 140),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap(BuildContext context) {
    _controller.forward().then((_) {
      _controller.reverse();
      if (widget.onTap != null) {
        widget.onTap!();
      } else {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, anim1, anim2) => const DoctorHelpScreen(),
            transitionsBuilder: (context, anim1, anim2, child) {
              return FadeTransition(opacity: anim1, child: child);
            },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleTap(context),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.primaryGradient,
            border: Border.all(
              color: Colors.white,
              width: 1.8,
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
                blurRadius: 14,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: const Center(
            child: Icon(
              Icons.auto_awesome_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
