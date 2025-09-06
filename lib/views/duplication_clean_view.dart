import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/duplicate_photos_controller.dart';
import '../controllers/theme_controller.dart';

class DuplicationCleanView extends StatelessWidget {
  final String categoryTitle;

  const DuplicationCleanView({super.key, required this.categoryTitle});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DuplicatePhotosController());
    final themeController = Get.find<ThemeController>();
    final theme = Theme.of(context);
    final categoryTitle = Get.arguments as String? ?? this.categoryTitle;

    return Obx(() {
      // Listen to theme changes
      themeController.isDarkMode.value;
      themeController.isSystemTheme.value;

      return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            categoryTitle,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onBackground,
            ),
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
            onPressed: controller.goBack,
            icon: Icon(Icons.arrow_back, color: theme.colorScheme.onBackground),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Header with back button and title

              // Summary section
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Total size row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Size',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                        Text(
                          controller.totalSize.value,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Blue banner with selection info
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Delete your duplicate images to save',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Obx(
                                () => Text(
                                  '${controller.selectedCount.value} Image/${controller.selectedSize.value} Selected',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Obx(
                            () => Text(
                              controller.isSelectionMode.value
                                  ? '💡 Tap images to select • Tap selected to view details'
                                  : '💡 Long press to enable selection • Tap to view details',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Duplicate images list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: controller.duplicateGroups.length,
                  itemBuilder: (context, groupIndex) {
                    final group = controller.duplicateGroups[groupIndex];
                    return _buildDateGroup(group, controller, theme);
                  },
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),

        // Floating action button for cleanup
        floatingActionButton: Obx(
          () => controller.isSelectionMode.value
              ? Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Cancel button
                      Container(
                        margin: const EdgeInsets.only(right: 16),
                        child: FloatingActionButton(
                          onPressed: controller.disableSelectionMode,
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          elevation: 4,
                          child: const Icon(Icons.close, size: 24),
                        ),
                      ),
                      // Delete button
                      FloatingActionButton(
                        onPressed: controller.startCleanup,
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        elevation: 4,
                        child: const Icon(Icons.delete, size: 24),
                      ),
                    ],
                  ),
                )
              : Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: FloatingActionButton.extended(
                    onPressed: controller.startCleanup,
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: Colors.white,
                    elevation: 4,
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.cleaning_services, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Start Clean up',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    });
  }

  Widget _buildDateGroup(
    Map<String, dynamic> group,
    DuplicatePhotosController controller,
    ThemeData theme,
  ) {
    final date = group['date'] as String;
    final images = group['images'] as List<Map<String, dynamic>>;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date header with expand/collapse arrow
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.keyboard_arrow_up,
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  date,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Images grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemCount: images.length,
            itemBuilder: (context, imageIndex) {
              final image = images[imageIndex];
              return _buildImageTile(image, controller, theme);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildImageTile(
    Map<String, dynamic> image,
    DuplicatePhotosController controller,
    ThemeData theme,
  ) {
    final imageId = image['id'] as String;
    final imagePath = image['path'] as String;

    return Obx(() {
      final isSelected = controller.selectedImages.contains(imageId);

      return GestureDetector(
        onTap: () => controller.handleImageTap(imageId, image),
        onLongPress: () => controller.enableSelectionMode(),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected
                  ? theme.colorScheme.primary
                  : Colors.transparent,
              width: 2,
            ),
          ),
          child: Stack(
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              // Selection indicator
              if (isSelected)
                Positioned(
                  top: 4,
                  right: 4,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                ),

              // Tap indicator (subtle overlay)
              Positioned(
                bottom: 4,
                left: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(
                    Icons.touch_app,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
