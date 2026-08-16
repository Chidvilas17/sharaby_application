import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_decorations.dart';


/// Custom painter to draw dual-tone glossy rim highlights (bright white top-left, soft sky-blue bottom-right)
class GlossyBorderPainter extends CustomPainter {
  final double borderRadius;
  final double borderWidth;
  final bool isDark;

  GlossyBorderPainter({
    required this.borderRadius,
    this.borderWidth = 1.5,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..shader = LinearGradient(
        colors: isDark
            ? [
                Colors.white.withValues(alpha: 0.35),
                const Color(0x6038BDF8),
                const Color(0x300284C7),
              ]
            : [
                Colors.white.withValues(alpha: 0.95), // Bright white top-left highlight
                const Color(0xB038BDF8),             // Sky blue
                const Color(0x600284C7),             // Azure bottom-right
              ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect);

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant GlossyBorderPainter oldDelegate) {
    return oldDelegate.borderRadius != borderRadius ||
        oldDelegate.borderWidth != borderWidth ||
        oldDelegate.isDark != isDark;
  }
}

/// Custom painter to draw top-half glossy reflection shine
class GlassShinePainter extends CustomPainter {
  final double borderRadius;

  GlassShinePainter({required this.borderRadius});

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    final shineHeight = size.height * 0.42;
    final shineRect = Rect.fromLTWH(0, 0, size.width, shineHeight);

    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.white.withValues(alpha: 0.35),
          Colors.white.withValues(alpha: 0.08),
          Colors.white.withValues(alpha: 0.0),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(shineRect);

    canvas.save();
    canvas.clipRRect(rrect);
    canvas.drawRect(shineRect, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant GlassShinePainter oldDelegate) {
    return oldDelegate.borderRadius != borderRadius;
  }
}

/// Reusable Glassmorphism & Soft Neumorphic Card with top reflection & press feedback
class GlassCard extends StatefulWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final Color? customColor;
  final Border? border;
  final VoidCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.borderRadius = 22,
    this.padding = const EdgeInsets.all(20),
    this.margin,
    this.customColor,
    this.border,
    this.onTap,
  });

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Widget cardContent = Container(
      decoration: AppDecorations.glassBoxDecoration(
        isDark: isDark,
        borderRadius: widget.borderRadius,
        customColor: widget.customColor,
        border: widget.border ?? Border.all(color: Colors.transparent, width: 0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: CustomPaint(
            foregroundPainter: GlossyBorderPainter(
              borderRadius: widget.borderRadius,
              isDark: isDark,
            ),
            child: CustomPaint(
              painter: GlassShinePainter(borderRadius: widget.borderRadius),
              child: Padding(
                padding: widget.padding,
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );

    if (widget.margin != null) {
      cardContent = Padding(
        padding: widget.margin!,
        child: cardContent,
      );
    }

    if (widget.onTap != null) {
      return GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _isPressed ? 0.97 : 1.0,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOutCubic,
          child: cardContent,
        ),
      );
    }
    return cardContent;
  }
}

