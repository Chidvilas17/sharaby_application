import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Continuous 60 FPS Animated Background inspired by Apple VisionOS & Google Gemini
class AnimatedGlassBackground extends StatefulWidget {
  final Widget child;

  const AnimatedGlassBackground({
    super.key,
    required this.child,
  });

  @override
  State<AnimatedGlassBackground> createState() => _AnimatedGlassBackgroundState();
}

class _AnimatedGlassBackgroundState extends State<AnimatedGlassBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        // Base Dynamic Ambient Gradient Background
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? const [
                        Color(0xFF0B132B),
                        Color(0xFF0F172A),
                        Color(0xFF1E293B),
                      ]
                    : const [
                        Color(0xFFF0F9FF),
                        Color(0xFFE0F2FE),
                        Color(0xFFBAE6FD),
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),

        // Continuous Moving Ambient Lights Painter
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: _BackgroundLightPainter(
                  progress: _controller.value,
                  isDark: isDark,
                ),
              );
            },
          ),
        ),

        // Content
        Positioned.fill(
          child: widget.child,
        ),
      ],
    );
  }
}

class _BackgroundLightPainter extends CustomPainter {
  final double progress;
  final bool isDark;

  _BackgroundLightPainter({
    required this.progress,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final angle = progress * 2 * math.pi;

    // Light Circle 1 - Top Left moving orbit
    final c1x = size.width * 0.3 + math.sin(angle) * (size.width * 0.25);
    final c1y = size.height * 0.2 + math.cos(angle) * (size.height * 0.15);
    final paint1 = Paint()
      ..color = isDark
          ? AppColors.primary.withValues(alpha: 0.15)
          : AppColors.primary.withValues(alpha: 0.25)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 80);
    canvas.drawCircle(Offset(c1x, c1y), size.width * 0.45, paint1);

    // Light Circle 2 - Bottom Right counter orbit
    final c2x = size.width * 0.7 - math.cos(angle) * (size.width * 0.2);
    final c2y = size.height * 0.7 - math.sin(angle) * (size.height * 0.2);
    final paint2 = Paint()
      ..color = isDark
          ? AppColors.accent.withValues(alpha: 0.12)
          : AppColors.accent.withValues(alpha: 0.28)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 90);
    canvas.drawCircle(Offset(c2x, c2y), size.width * 0.5, paint2);

    // Light Circle 3 - Center floating Cyan glow
    final c3x = size.width * 0.5 + math.sin(angle * 1.5) * (size.width * 0.15);
    final c3y = size.height * 0.45 + math.cos(angle * 1.5) * (size.height * 0.15);
    final paint3 = Paint()
      ..color = isDark
          ? const Color(0xFF38BDF8).withValues(alpha: 0.08)
          : const Color(0xFFE0F2FE).withValues(alpha: 0.35)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 60);
    canvas.drawCircle(Offset(c3x, c3y), size.width * 0.35, paint3);
  }

  @override
  bool shouldRepaint(covariant _BackgroundLightPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.isDark != isDark;
  }
}
