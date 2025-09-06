import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../controllers/media_manager_controller.dart';
import '../controllers/theme_controller.dart';
import '../routes/app_routes.dart';

class MediaManagerView extends StatelessWidget {
  const MediaManagerView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MediaManagerController());
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
              'Media Manager',
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
            actions: [
              PopupMenuButton<String>(
                icon: Icon(
                  Icons.more_vert,
                  color: theme.colorScheme.onBackground,
                  size: 24,
                ),
                onSelected: (value) {
                  switch (value) {
                    case 'sort':
                      Get.snackbar(
                        'Sort',
                        'Sorting options coming soon',
                        snackPosition: SnackPosition.TOP,
                      );
                      break;
                    case 'filter':
                      Get.snackbar(
                        'Filter',
                        'Filter options coming soon',
                        snackPosition: SnackPosition.TOP,
                      );
                      break;
                  }
                },
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem<String>(
                    value: 'sort',
                    child: Text(
                      'Sort by',
                      style: TextStyle(color: theme.colorScheme.onBackground),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'filter',
                    child: Text(
                      'Filter',
                      style: TextStyle(color: theme.colorScheme.onBackground),
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                // Tabs section
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildTab('Photos', 0, controller),
                        _buildTab('Videos', 1, controller),
                        _buildTab('Documents', 2, controller),
                      ],
                    ),
                  ),
                ),

                // Main content area
                Expanded(child: Obx(() => _buildContentForTab(controller))),

                // Bottom action bar - dynamic based on selection mode
                Obx(() => _buildBottomActionBar(controller)),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildTab(String title, int index, MediaManagerController controller) {
    return Obx(
      () => GestureDetector(
        onTap: () => controller.setSelectedTab(index),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: controller.selectedTabIndex.value == index
                ? Theme.of(Get.context!).colorScheme.primary
                : Colors.transparent,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: controller.selectedTabIndex.value == index
                  ? Colors.white
                  : Theme.of(
                      Get.context!,
                    ).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContentForTab(MediaManagerController controller) {
    switch (controller.selectedTabIndex.value) {
      case 0:
        return _buildPhotosContent(controller);
      case 1:
        return _buildVideosContent(controller);
      case 2:
        return _buildDocumentsContent(controller);
      default:
        return _buildPhotosContent(controller);
    }
  }

  Widget _buildPhotosContent(MediaManagerController controller) {
    final photos = controller.getPhotosData();
    final groupedPhotos = _groupByDate(photos);

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: groupedPhotos.length,
      itemBuilder: (context, index) {
        final date = groupedPhotos.keys.elementAt(index);
        final photosForDate = groupedPhotos[date]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                date,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(
                    Get.context!,
                  ).colorScheme.onSurface.withOpacity(0.7),
                ),
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
              itemCount: photosForDate.length,
              itemBuilder: (context, photoIndex) {
                final photo = photosForDate[photoIndex];
                return _buildPhotoItem(photo, controller);
              },
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }

  Widget _buildVideosContent(MediaManagerController controller) {
    final videos = controller.getVideosData();
    final groupedVideos = _groupByDate(videos);

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: groupedVideos.length,
      itemBuilder: (context, index) {
        final date = groupedVideos.keys.elementAt(index);
        final videosForDate = groupedVideos[date]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                date,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(
                    Get.context!,
                  ).colorScheme.onSurface.withOpacity(0.7),
                ),
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
              itemCount: videosForDate.length,
              itemBuilder: (context, videoIndex) {
                final video = videosForDate[videoIndex];
                return _buildVideoItem(video, controller);
              },
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }

  Widget _buildDocumentsContent(MediaManagerController controller) {
    final documents = controller.getDocumentsData();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: documents.length + 1, // +1 for "Select All" option
      itemBuilder: (context, index) {
        if (index == 0) {
          return _buildSelectAllOption(controller);
        }

        final document = documents[index - 1];
        return _buildDocumentItem(document, controller);
      },
    );
  }

  Widget _buildPhotoItem(
    Map<String, dynamic> photo,
    MediaManagerController controller,
  ) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          if (controller.isSelectionMode.value) {
            controller.toggleFileSelection(photo['id']);
          } else {
            controller.toggleSelectionMode();
          }
        },
        onLongPress: () => controller.toggleSelectionMode(),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(photo['image']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            if (controller.isSelectionMode.value)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: controller.selectedFiles.contains(photo['id'])
                        ? Theme.of(Get.context!).colorScheme.primary
                        : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: controller.selectedFiles.contains(photo['id'])
                          ? Theme.of(Get.context!).colorScheme.primary
                          : Colors.grey[400]!,
                      width: 2,
                    ),
                  ),
                  child: controller.selectedFiles.contains(photo['id'])
                      ? const Icon(Icons.check, color: Colors.white, size: 16)
                      : null,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoItem(
    Map<String, dynamic> video,
    MediaManagerController controller,
  ) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          if (controller.isSelectionMode.value) {
            controller.toggleFileSelection(video['id']);
          } else {
            controller.toggleSelectionMode();
          }
        },
        onLongPress: () => controller.toggleSelectionMode(),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(video['thumbnail']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Play icon overlay - positioned at bottom right
            Positioned(
              bottom: 8,
              right: 8,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 20,
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
                  video['size'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            // Selection indicator
            if (controller.isSelectionMode.value)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: controller.selectedFiles.contains(video['id'])
                        ? Theme.of(Get.context!).colorScheme.primary
                        : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: controller.selectedFiles.contains(video['id'])
                          ? Theme.of(Get.context!).colorScheme.primary
                          : Colors.grey[400]!,
                      width: 2,
                    ),
                  ),
                  child: controller.selectedFiles.contains(video['id'])
                      ? const Icon(Icons.check, color: Colors.white, size: 16)
                      : null,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentItem(
    Map<String, dynamic> document,
    MediaManagerController controller,
  ) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          if (controller.isSelectionMode.value) {
            controller.toggleFileSelection(document['id']);
          } else {
            controller.toggleSelectionMode();
          }
        },
        onLongPress: () => controller.toggleSelectionMode(),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2F0F5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.description,
                  color: Colors.blueAccent,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      document['name'],
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(Get.context!).colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      document['size'],
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Theme.of(
                          Get.context!,
                        ).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              if (controller.isSelectionMode.value)
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: controller.selectedFiles.contains(document['id'])
                        ? Theme.of(Get.context!).colorScheme.primary
                        : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: controller.selectedFiles.contains(document['id'])
                          ? Theme.of(Get.context!).colorScheme.primary
                          : Colors.grey[400]!,
                      width: 2,
                    ),
                  ),
                  child: controller.selectedFiles.contains(document['id'])
                      ? const Icon(Icons.check, color: Colors.white, size: 16)
                      : null,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectAllOption(MediaManagerController controller) {
    return Obx(
      () => GestureDetector(
        onTap: controller.selectAllFiles,
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(Get.context!).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(
                Get.context!,
              ).colorScheme.outline.withOpacity(0.3),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color:
                      controller.selectedFiles.length ==
                          controller.getDocumentsData().length
                      ? Theme.of(Get.context!).colorScheme.primary
                      : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color:
                        controller.selectedFiles.length ==
                            controller.getDocumentsData().length
                        ? Theme.of(Get.context!).colorScheme.primary
                        : Colors.grey[400]!,
                    width: 2,
                  ),
                ),
                child:
                    controller.selectedFiles.length ==
                        controller.getDocumentsData().length
                    ? const Icon(Icons.check, color: Colors.white, size: 16)
                    : null,
              ),
              const SizedBox(width: 16),
              Text(
                'Select All',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(Get.context!).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomActionBar(MediaManagerController controller) {
    if (controller.isSelectionMode.value) {
      // Selection mode action bar
      return Container(
        height: 60,
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Cancel button (left)
            Expanded(
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                ),
                child: IconButton(
                  onPressed: controller.toggleSelectionMode,
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black87,
                    size: 24,
                  ),
                ),
              ),
            ),
            // Move button (right)
            Expanded(
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Theme.of(Get.context!).colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: IconButton(
                  onPressed: controller.moveSelectedFiles,
                  icon: const Icon(
                    Icons.logout_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      // Normal mode action bar - matches the floating nav design from optimize/feature screens
      return Container(
        height: 8.h,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20.w),
        decoration: BoxDecoration(
          color: Theme.of(Get.context!).colorScheme.surface.withOpacity(0.7),
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
                margin: EdgeInsets.symmetric(horizontal: 20),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.home, color: Colors.white, size: 24),
              ),
            ),
            // Add Files button
            GestureDetector(
              onTap: controller.addFiles,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                margin: EdgeInsets.symmetric(horizontal: 0),
                decoration: BoxDecoration(
                  color: Theme.of(Get.context!).colorScheme.primary,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.add, color: Colors.white, size: 24),
                    Text(
                      "Add Files",
                      style: TextStyle(
                        color: Theme.of(
                          Get.context!,
                        ).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
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
