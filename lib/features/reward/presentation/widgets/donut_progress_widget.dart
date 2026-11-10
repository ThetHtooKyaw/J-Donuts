import 'dart:math';
import 'package:flutter/material.dart';

class DonutProgressWidget extends StatelessWidget {
  final double current;
  final double total;
  final double size;

  const DonutProgressWidget({
    super.key,
    required this.current,
    required this.total,
    this.size = 120,
  });

  @override
  Widget build(BuildContext context) {
    final progress = total > 0 ? (current / total) : 0.0;
    final clampedProgress = progress.clamp(0.0, 1.0);
    final coloredImagePath = 'assets/images/donut_colored.png';

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Base Layer: Uncolored Donut
          Image.asset(
            'assets/images/donut_not_colored.png',
            fit: BoxFit.contain,
          ),

          // 2. Overlay Layer: Full-Color Donut clipped radially based on progress
          if (clampedProgress > 0)
            ClipPath(
              clipper: _RadialProgressClipper(progress: clampedProgress),
              child: Image.asset(coloredImagePath, fit: BoxFit.contain),
            ),
        ],
      ),
    );
  }
}

class _RadialProgressClipper extends CustomClipper<Path> {
  final double progress;

  _RadialProgressClipper({required this.progress});

  @override
  Path getClip(Size size) {
    final path = Path();

    // If progress is 100% (or 4/4), return the full bounding box to show 100% color safely
    if (progress >= 0.999) {
      path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
      return path;
    }

    final center = Offset(size.width / 2, size.height / 2);
    final radius = max(size.width, size.height);

    path.moveTo(center.dx, center.dy);

    // Start at top center (-pi / 2) and sweep clockwise by (2 * pi * progress)
    const startAngle = -pi / 2;
    final sweepAngle = 2 * pi * progress;

    path.arcTo(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
    );

    path.lineTo(center.dx, center.dy);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant _RadialProgressClipper oldClipper) {
    return oldClipper.progress != progress;
  }
}
