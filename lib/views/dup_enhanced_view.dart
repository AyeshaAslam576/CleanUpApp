import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/dup_enhanced_controller.dart';
import '../controllers/theme_controller.dart';

class DupEnhancedView extends StatelessWidget {
  const DupEnhancedView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DupEnhancedController());
    final themeController = Get.find<ThemeController>();
    final theme = Theme.of(context);

    return Obx(() {
      // Listen to theme changes
      themeController.isDarkMode.value;
      themeController.isSystemTheme.value;

      return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: theme.colorScheme.primary,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: theme.colorScheme.onPrimary),
            onPressed: controller.goBack,
          ),
          title: Text(
            'Duplicate Images',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ),
        body: Stack(
          children: [
            // Main content with thumbnails at bottom
            Column(
              children: [
                // Main content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Main image card
                        _buildMainImageCard(controller, theme),
                        const SizedBox(height: 20),
                        // Thumbnails section
                        _buildThumbnailsSection(controller, theme),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // User guide overlay
            if (controller.showUserGuide.value)
              _buildUserGuideOverlay(controller, theme),
          ],
        ),
      );
    });
  }

  Widget _buildMainImageCard(
    DupEnhancedController controller,
    ThemeData theme,
  ) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.onSurface.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Main image
            Image.asset(
              'assets/images/flower1.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            // Image info overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      theme.colorScheme.onSurface.withOpacity(0.8),
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          controller.fileName,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                        Text(
                          '${controller.fileSize} • ${controller.imageWidth.toInt()}x${controller.imageHeight.toInt()}',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: theme.colorScheme.onPrimary.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.onPrimary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Duplicate',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnailsSection(
    DupEnhancedController controller,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Similar Images (${controller.thumbnails.length})',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.thumbnails.length,
            itemBuilder: (context, index) {
              final thumbnail = controller.thumbnails[index];
              final isSelected =
                  index == 0; // First thumbnail is selected by default

              return GestureDetector(
                onTap: () {
                  // Handle thumbnail selection
                  Get.snackbar(
                    'Thumbnail Selected',
                    'Thumbnail ${index + 1} selected',
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: theme.colorScheme.primary,
                    colorText: theme.colorScheme.onPrimary,
                  );
                },
                child: Container(
                  width: 100,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? theme.colorScheme.primary
                          : Colors.transparent,
                      width: 3,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        Image.asset(
                          thumbnail,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        if (isSelected)
                          Container(
                            color: theme.colorScheme.primary.withOpacity(0.3),
                            child: Center(
                              child: Icon(
                                Icons.check_circle,
                                color: theme.colorScheme.onPrimary,
                                size: 24,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildUserGuideOverlay(
    DupEnhancedController controller,
    ThemeData theme,
  ) {
    return Container(
      color: theme.colorScheme.onSurface.withOpacity(0.8),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.gesture, size: 48, color: theme.colorScheme.primary),
              const SizedBox(height: 16),
              Text(
                'Welcome to Duplicate Management!',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                controller.guideSteps[controller.currentGuideStep.value],
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  if (controller.currentGuideStep.value > 0)
                    Expanded(
                      child: TextButton(
                        onPressed: controller.previousGuideStep,
                        child: Text(
                          'Previous',
                          style: GoogleFonts.poppins(
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  if (controller.currentGuideStep.value > 0)
                    const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: controller.nextGuideStep,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        controller.currentGuideStep.value <
                                controller.guideSteps.length - 1
                            ? 'Next'
                            : 'Got it!',
                        style: GoogleFonts.poppins(
                          color: theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
