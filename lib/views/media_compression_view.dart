import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../controllers/media_compression_controller.dart';
import '../controllers/theme_controller.dart';
import '../routes/app_routes.dart';

class MediaCompressionView extends StatelessWidget {
  const MediaCompressionView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MediaCompressionController());
    final themeController = Get.find<ThemeController>();
    final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () async {
        Get.offNamed(AppRoutes.features);
        return false;
      },
      child: Obx(() {
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
              onPressed: () => Get.offNamed(AppRoutes.features),
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
                // Header information
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Selected Media',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        '7.66 GB',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),

                // Blue banner
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Compress your videos and save storage up to the 50%',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: theme.colorScheme.onPrimary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '1.66 GB',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.compressionSettings),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.onPrimary.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.settings,
                            color: theme.colorScheme.onPrimary,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Media list
                Expanded(child: _buildMediaList(controller, theme)),
              ],
            ),
          ),
          bottomNavigationBar: _buildBottomActionBar(controller, theme),
        );
      }),
    );
  }

  Widget _buildMediaList(
    MediaCompressionController controller,
    ThemeData theme,
  ) {
    final media = controller.getMediaData();
    final groupedMedia = _groupByDate(media);

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: groupedMedia.length,
      itemBuilder: (context, index) {
        final date = groupedMedia.keys.elementAt(index);
        final mediaForDate = groupedMedia[date]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Text(
                    date,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: theme.colorScheme.onSurface.withOpacity(0.5),
                    size: 20,
                  ),
                ],
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemCount: mediaForDate.length,
              itemBuilder: (context, mediaIndex) {
                final mediaItem = mediaForDate[mediaIndex];
                return _buildMediaItem(mediaItem, controller, theme);
              },
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }

  Widget _buildMediaItem(
    Map<String, dynamic> media,
    MediaCompressionController controller,
    ThemeData theme,
  ) {
    return Obx(
      () => GestureDetector(
        onTap: () => controller.toggleMediaSelection(media['id']),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(media['thumbnail']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Play icon for videos
            if (media['type'] == 'video')
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            // File size overlay
            Positioned(
              bottom: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  media['size'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            // Selection indicator
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: controller.selectedMedia.contains(media['id'])
                      ? theme.colorScheme.primary
                      : theme.colorScheme.surface,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: controller.selectedMedia.contains(media['id'])
                        ? theme.colorScheme.primary
                        : theme.colorScheme.outline.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: controller.selectedMedia.contains(media['id'])
                    ? Icon(
                        Icons.check,
                        color: theme.colorScheme.onPrimary,
                        size: 16,
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomActionBar(
    MediaCompressionController controller,
    ThemeData theme,
  ) {
    return Container(
      height: 8.h,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(0.7),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Home button
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.features),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.home, color: Colors.white, size: 24),
            ),
          ),
          // Compress button
          Expanded(
            child: Obx(
              () => GestureDetector(
                onTap: controller.selectedMedia.isNotEmpty
                    ? () => controller.startCompression()
                    : null,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                    vertical: 2.5.h,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: controller.selectedMedia.isNotEmpty
                        ? theme.colorScheme.primary
                        : theme.colorScheme.outline.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.compress,
                        color: controller.selectedMedia.isNotEmpty
                            ? theme.colorScheme.onPrimary
                            : theme.colorScheme.onSurface.withOpacity(0.5),
                        size: 20,
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          "Compress",
                          style: TextStyle(
                            color: controller.selectedMedia.isNotEmpty
                                ? theme.colorScheme.onPrimary
                                : theme.colorScheme.onSurface.withOpacity(0.5),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Map<String, List<Map<String, dynamic>>> _groupByDate(
    List<Map<String, dynamic>> items,
  ) {
    final grouped = <String, List<Map<String, dynamic>>>{};
    for (final item in items) {
      final date = item['date'] as String;
      if (!grouped.containsKey(date)) {
        grouped[date] = [];
      }
      grouped[date]!.add(item);
    }
    return grouped;
  }
}
