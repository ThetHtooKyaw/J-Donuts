import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// Decoded images are cached per asset path so rebuilding the widget (e.g. on a
// tab switch) does not re-read and re-decode the PNG on the UI isolate.
final Map<String, Future<ui.Image>> _uiImageCache = {};

Future<ui.Image> loadUiImage(String assetPath) {
  return _uiImageCache.putIfAbsent(assetPath, () async {
    final data = await rootBundle.load(assetPath);
    final bytes = data.buffer.asUint8List();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    return frame.image;
  });
}

class DonutRingProgressWidget extends StatelessWidget {
  final double currentPoints;
  final double maxPoints;
  final double size;
  final String centerText;

  const DonutRingProgressWidget({
    super.key,
    required this.currentPoints,
    required this.maxPoints,
    required this.size,
    this.centerText = '680,000',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strokeWidth = 60.0;
    final progress = (currentPoints / maxPoints).clamp(0.0, 1.0);
    final formattedPoints = currentPoints.toInt().toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );

    return SizedBox(
      width: size,
      height: size,
      child: FutureBuilder<ui.Image>(
        future: loadUiImage('assets/images/donut_texture.png'),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
              width: size,
              height: size,
              child: const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            );
          }

          final uiImage = snapshot.data!;

          return Stack(
            alignment: Alignment.center,
            children: [
              // Background Gray Track (Uncompleted part)
              CustomPaint(
                size: Size(size, size),
                painter: _DonutArcPainter(
                  progress: 1.0, // Full circle for track
                  color: theme.colorScheme.onInverseSurface.withOpacity(0.2),
                  strokeWidth: strokeWidth,
                ),
              ),

              // Foreground Textured Progress Arc masked with an Image Texture
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return ui.ImageShader(
                    uiImage,
                    TileMode.repeated,
                    TileMode.repeated,
                    Matrix4.identity()
                        .scaled(
                          bounds.width / uiImage.width,
                          bounds.height / uiImage.height,
                        )
                        .storage,
                  );
                },
                blendMode: BlendMode.srcIn,
                child: CustomPaint(
                  size: Size(size, size),
                  painter: _DonutArcPainter(
                    progress: progress.clamp(0.0, 1.0),
                    color: Colors.white,
                    strokeWidth: strokeWidth - 12,
                  ),
                ),
              ),

              // Center White Content Container & Text
              Container(
                width: size * 0.6,
                height: size * 0.6,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Total points",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),

                    Text(
                      formattedPoints,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _DonutArcPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  _DonutArcPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    if (progress > 0) {
      canvas.drawArc(
        rect,
        -pi / 2, // Start from top center
        2 * pi * progress,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DonutArcPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
