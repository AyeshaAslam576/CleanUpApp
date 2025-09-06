import 'package:flutter/material.dart';

class DashedCircularProgress extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final double size;
  final double strokeWidth;
  final Color progressColor;
  final Color backgroundColor;
  final Widget child;

  const DashedCircularProgress({
    super.key,
    required this.progress,
    this.size = 200.0,
    this.strokeWidth = 8.0,
    this.progressColor = const Color(0xFFFF6B35),
    this.backgroundColor = const Color(0xFFE0E0E0),
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          // Background dashed circle
          CustomPaint(
            size: Size(size, size),
            painter: DashedCirclePainter(
              progress: 1.0,
              strokeWidth: strokeWidth,
              color: backgroundColor,
            ),
          ),
          // Progress dashed circle
          CustomPaint(
            size: Size(size, size),
            painter: DashedCirclePainter(
              progress: progress,
              strokeWidth: strokeWidth,
              color: progressColor,
            ),
          ),
          // Center content
          Center(child: child),
        ],
      ),
    );
  }
}

class DashedCirclePainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color color;

  DashedCirclePainter({
    required this.progress,
    required this.strokeWidth,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Calculate dash parameters
    const dashCount = 20; // Number of dashes
    const dashLength = 8.0;
    const gapLength = 4.0;

    final circumference = 2 * 3.14159 * radius;
    final dashAngle = (dashLength / circumference) * 2 * 3.14159;
    final gapAngle = (gapLength / circumference) * 2 * 3.14159;
    final totalAngle = dashAngle + gapAngle;

    // Draw dashes
    for (int i = 0; i < dashCount; i++) {
      final startAngle = (i * totalAngle) - (3.14159 / 2); // Start from top

      // Only draw if this dash is within the progress range
      final dashProgress = (i + 1) / dashCount;
      if (dashProgress <= progress) {
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          startAngle,
          dashAngle,
          false,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
