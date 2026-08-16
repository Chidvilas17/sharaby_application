import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_decorations.dart';
import '../../features/navigation/main_navigation_shell.dart';

/// Glassmorphism Rounded Back Button with Blue Glow and Smooth Animation
class ModernBackButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Color? iconColor;

  const ModernBackButton({
    super.key,
    this.onPressed,
    this.iconColor,
  });

  @override
  State<ModernBackButton> createState() => _ModernBackButtonState();
}

class _ModernBackButtonState extends State<ModernBackButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        if (widget.onPressed != null) {
          widget.onPressed!();
        } else if (Navigator.canPop(context)) {
          Navigator.pop(context);
        } else {
          MainNavigationShell.of(context)?.returnToDashboard();
        }
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: 42,
          height: 42,
          margin: const EdgeInsets.all(6),
          decoration: AppDecorations.glossyIconBoxDecoration(
            color: AppColors.primaryDark,
            isDark: isDark,
            isCircle: true,
          ),
          child: Center(
            child: Icon(
              isRtl ? Icons.arrow_forward_ios_rounded : Icons.arrow_back_ios_new_rounded,
              size: 18,
              color: widget.iconColor ??
                  (isDark ? AppColors.textPrimaryDark : AppColors.primaryDark),
            ),
          ),
        ),
      ),
    );
  }
}

