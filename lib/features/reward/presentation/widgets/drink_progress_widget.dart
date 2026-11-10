import 'dart:math';
import 'package:flutter/material.dart';

class DrinkProgressWidget extends StatelessWidget {
  final String imagePath;
  final double current;
  final double total;
  final double size;

  const DrinkProgressWidget({
    super.key,
    required this.imagePath,
    required this.current,
    required this.total,
    this.size = 140,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: size,
      height: size + 10,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Drink Image in the center
          Positioned(
            bottom: 4,
            child: SizedBox(
              width: size * 0.8,
              height: size * 0.8,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) =>
                    const Icon(Icons.local_cafe, size: 40, color: Colors.brown),
              ),
            ),
          ),

          // Progress Arc (Curved Arc)
          Positioned(
            top: -20,
            child: CustomPaint(
              size: Size(size, size),
              painter: _CurvedArcPainter(
                progress: (current / total).clamp(0.0, 1.0),
                activeColor: theme.colorScheme.onSecondaryContainer,
                trackColor: theme.colorScheme.onInverseSurface.withOpacity(0.3),
                strokeWidth: 12.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CurvedArcPainter extends CustomPainter {
  final double progress;
  final Color activeColor;
  final Color trackColor;
  final double strokeWidth;

  _CurvedArcPainter({
    required this.progress,
    required this.activeColor,
    required this.trackColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2 + 5);
    final radius = (size.width / 2) - 22.0;

    const startAngle = pi; // 180 degrees
    const sweepAngle = pi; // 180 degrees (half circle)

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = activeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Draw background track arc (top half)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      trackPaint,
    );

    // Draw active progress arc (top half)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CurvedArcPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.activeColor != activeColor ||
        oldDelegate.trackColor != trackColor;
  }
}
