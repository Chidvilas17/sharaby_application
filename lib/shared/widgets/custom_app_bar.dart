import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../features/navigation/main_navigation_shell.dart';
import 'modern_back_button.dart';

/// Reusable Glassmorphism Custom Top AppBar.
/// - On root Dashboard screen: shows a hamburger menu button to open drawer.
/// - On secondary screens & pushed sub-screens: shows a modern back button.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool? showBackButton; // null = auto-detect based on navigator state

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.showBackButton, // leave null for automatic behaviour
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final canPop = Navigator.canPop(context);
    final shell = MainNavigationShell.of(context);
    final isSecondaryTab = shell != null && shell.currentIndex != 0;

    Widget? leadingWidget = leading;

    if (leadingWidget == null) {
      final wantsBack = showBackButton ?? (canPop || isSecondaryTab);

      if (wantsBack) {
        // Sub-screen or secondary tab: show glassmorphism back button
        leadingWidget = const ModernBackButton();
      } else {
        // Root screen inside IndexedStack: show hamburger to open drawer
        leadingWidget = _DrawerMenuButton(isDark: isDark);
      }
    }


    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: false,
      automaticallyImplyLeading: false,
      leading: leadingWidget,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: isDark ? AppColors.textPrimaryDark : AppColors.primaryDark,
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// Glassmorphism hamburger button that opens the scaffold drawer
class _DrawerMenuButton extends StatefulWidget {
  final bool isDark;
  const _DrawerMenuButton({required this.isDark});

  @override
  State<_DrawerMenuButton> createState() => _DrawerMenuButtonState();
}

class _DrawerMenuButtonState extends State<_DrawerMenuButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.9).animate(
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
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        Scaffold.of(context).openDrawer();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnim,
        child: Container(
          width: 42,
          height: 42,
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: widget.isDark
                ? AppColors.glassSurfaceDark
                : AppColors.glassSurfaceLight,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.35),
              width: 1.5,
            ),
            boxShadow: const [
              BoxShadow(
                color: AppColors.glowBlue,
                blurRadius: 10,
                spreadRadius: -1,
              ),
              BoxShadow(
                color: AppColors.shadowBlue,
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Icon(
            Icons.menu_rounded,
            size: 20,
            color: widget.isDark ? AppColors.textPrimaryDark : AppColors.primaryDark,
          ),
        ),
      ),
    );
  }
}
