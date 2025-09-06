import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/compression_progress_controller.dart';
import '../controllers/theme_controller.dart';

class CompressionProgressView extends StatelessWidget {
  const CompressionProgressView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CompressionProgressController());
    final themeController = Get.find<ThemeController>();
    final theme = Theme.of(context);

    return Obx(() {
      // Listen to theme changes
      themeController.isDarkMode.value;
      themeController.isSystemTheme.value;

      return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Media Compression',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onBackground,
            ),
          ),
          leading: IconButton(
            onPressed: controller.goBack,
            icon: Icon(
              Icons.arrow_back,
              color: theme.colorScheme.onBackground,
              size: 24,
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              const Spacer(),
              // Progress indicator
              Center(
                child: Obx(() => _buildProgressIndicator(controller, theme)),
              ),
              const SizedBox(height: 30),
              // Progress text
              Obx(() => _buildProgressText(controller, theme)),
              const Spacer(),
              // Banner ad placeholder
              Container(
                width: double.infinity,
                height: 60,
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: theme.colorScheme.outline.withOpacity(0.3),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Banner Ad Display',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildProgressIndicator(
    CompressionProgressController controller,
    ThemeData theme,
  ) {
    return SizedBox(
      width: 200,
      height: 200,
      child: CustomPaint(
        painter: SemiCircularProgressPainter(
          progress: controller.progress.value,
          color: theme.colorScheme.primary,
          backgroundColor: theme.colorScheme.outline.withOpacity(0.3),
        ),
      ),
    );
  }

  Widget _buildProgressText(
    CompressionProgressController controller,
    ThemeData theme,
  ) {
    return Column(
      children: [
        Text(
          'Compressing',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${controller.currentItem.value}/${controller.totalItems.value}',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}

class SemiCircularProgressPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color backgroundColor;

  SemiCircularProgressPainter({
    required this.progress,
    required this.color,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 20;

    // Background circle
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;

    // Draw semi-circle background
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.14159 / 2, // Start from top
      3.14159, // Half circle
      false,
      backgroundPaint,
    );

    // Progress circle
    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    // Draw progress
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.14159 / 2, // Start from top
      3.14159 * progress, // Progress portion
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
