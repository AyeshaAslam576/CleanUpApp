import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/compression_settings_controller.dart';
import '../controllers/theme_controller.dart';

class CompressionSettingsView extends StatelessWidget {
  const CompressionSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CompressionSettingsController());
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
            'Media Compression Settings',
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
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                // Title
                Text(
                  'Select Compression Ratio',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 40),
                // Compression ratio options
                Obx(() => _buildCompressionOptions(controller, theme)),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildCompressionOptions(
    CompressionSettingsController controller,
    ThemeData theme,
  ) {
    return Column(
      children: [
        _buildRatioOption(controller, 25, '25%', theme),
        const SizedBox(height: 20),
        _buildRatioOption(controller, 50, '50%', theme),
        const SizedBox(height: 20),
        _buildRatioOption(controller, 75, '75%', theme),
      ],
    );
  }

  Widget _buildRatioOption(
    CompressionSettingsController controller,
    int ratio,
    String label,
    ThemeData theme,
  ) {
    return GestureDetector(
      onTap: () => controller.setCompressionRatio(ratio),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: controller.selectedRatio.value == ratio
              ? theme.colorScheme.primary.withOpacity(0.1)
              : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: controller.selectedRatio.value == ratio
                ? theme.colorScheme.primary
                : theme.colorScheme.outline.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: controller.selectedRatio.value == ratio
                    ? theme.colorScheme.primary
                    : theme.colorScheme.surface,
                shape: BoxShape.circle,
                border: Border.all(
                  color: controller.selectedRatio.value == ratio
                      ? theme.colorScheme.primary
                      : theme.colorScheme.outline.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: controller.selectedRatio.value == ratio
                  ? Icon(
                      Icons.check,
                      color: theme.colorScheme.onPrimary,
                      size: 16,
                    )
                  : null,
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: controller.selectedRatio.value == ratio
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
