import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';
import '../utils/app_theme.dart';

class PrivateVaultMainController extends GetxController {
  final selectedTabIndex = 0.obs; // Photos tab is selected by default
  final hasSecuredFiles = true.obs; // Has secured files to show
  final isSelectionMode = false.obs; // Not in selection mode initially
  final selectedFiles = <String>{}.obs; // Set of selected file IDs
  final isVideoPlaying = false.obs; // Video play/pause state

  void setSelectedTab(int index) {
    selectedTabIndex.value = index;
  }

  void showMenu() {
    // This method is no longer needed as we'll use PopupMenuButton directly
  }

  void addFiles() {
    Get.dialog(_buildAddFilesDialog(), barrierDismissible: true);
  }

  Widget _buildAddFilesDialog() {
    final themeController = Get.find<ThemeController>();
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: themeController.isDarkMode.value
              ? AppTheme.darkCard
              : AppTheme.lightCard,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Files icon without container
            Icon(
              Icons.folder_open,
              color: AppTheme.primaryBlue,
              size: 60,
            ),
            const SizedBox(height: 16),

            // Title - adopts theme color
            Text(
              'Add Files',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: themeController.isDarkMode.value
                    ? AppTheme.darkText
                    : AppTheme.lightText,
              ),
            ),
            const SizedBox(height: 8),

            // Description - adopts theme color
            Text(
              'Capture image or select files from gallery to add.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: themeController.isDarkMode.value
                    ? AppTheme.darkTextSecondary
                    : AppTheme.lightTextSecondary,
              ),
            ),
            const SizedBox(height: 20),

            // Action buttons
            Row(
              children: [
                // Camera button
                Expanded(
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: themeController.isDarkMode.value
                          ? AppTheme.darkSurface
                          : const Color(0xFFF0F0F0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                        Get.snackbar(
                          'Camera',
                          'Camera feature coming soon',
                          snackPosition: SnackPosition.TOP,
                        );
                      },
                      icon: Icon(
                        Icons.camera_alt,
                        color: themeController.isDarkMode.value
                            ? AppTheme.darkText
                            : Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Open Gallery button
                Expanded(
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryBlue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Get.back();
                        Get.snackbar(
                          'Gallery',
                          'Gallery picker will open',
                          snackPosition: SnackPosition.TOP,
                        );
                      },
                      child: const Text(
                        'Open Gallery',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void goBack() {
    Get.back();
  }

  void toggleSelectionMode() {
    isSelectionMode.value = !isSelectionMode.value;
    if (!isSelectionMode.value) {
      selectedFiles.clear();
    }
  }

  void toggleFileSelection(String fileId) {
    if (selectedFiles.contains(fileId)) {
      selectedFiles.remove(fileId);
    } else {
      selectedFiles.add(fileId);
    }

    // If no files selected, exit selection mode
    if (selectedFiles.isEmpty) {
      isSelectionMode.value = false;
    }
  }

  void selectAllFiles() {
    // Get all file IDs for current tab
    final allFileIds = _getAllFileIdsForCurrentTab();
    selectedFiles.addAll(allFileIds);
  }

  void moveSelectedFiles() {
    if (selectedFiles.isNotEmpty) {
      Get.snackbar(
        'Move Files',
        'Moving ${selectedFiles.length} selected files...',
        snackPosition: SnackPosition.TOP,
      );
      // Exit selection mode after moving
      isSelectionMode.value = false;
      selectedFiles.clear();
    }
  }

  void toggleVideoPlayPause() {
    isVideoPlaying.value = !isVideoPlaying.value;
    Get.snackbar(
      'Video',
      isVideoPlaying.value ? 'Video playing' : 'Video paused',
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 1),
    );
  }

  List<String> _getAllFileIdsForCurrentTab() {
    // Return sample file IDs based on current tab
    switch (selectedTabIndex.value) {
      case 0: // Photos
        return [
          'photo_1',
          'photo_2',
          'photo_3',
          'photo_4',
          'photo_5',
          'photo_6',
        ];
      case 1: // Videos
        return [
          'video_1',
          'video_2',
          'video_3',
          'video_4',
          'video_5',
          'video_6',
        ];
      case 2: // Documents
        return ['doc_1', 'doc_2', 'doc_3', 'doc_4', 'doc_5'];
      default:
        return [];
    }
  }

  // Sample data for different tabs
  List<Map<String, dynamic>> getPhotosData() {
    return [
      {
        'id': 'photo_1',
        'date': '2022 07 22',
        'image': 'assets/images/flower1.png',
      },
      {
        'id': 'photo_2',
        'date': '2022 07 22',
        'image': 'assets/images/flower2.png',
      },
      {
        'id': 'photo_3',
        'date': '2022 06 22',
        'image': 'assets/images/flower3.png',
      },
      {
        'id': 'photo_4',
        'date': '2022 06 22',
        'image': 'assets/images/flower1.png',
      },
      {
        'id': 'photo_5',
        'date': '2022 06 22',
        'image': 'assets/images/flower2.png',
      },
      {
        'id': 'photo_6',
        'date': '2022 05 22',
        'image': 'assets/images/flower3.png',
      },
    ];
  }

  List<Map<String, dynamic>> getVideosData() {
    return [
      {
        'id': 'video_1',
        'date': '2025 07 22',
        'thumbnail': 'assets/images/flower1.png',
        'size': '1.2GB',
      },
      {
        'id': 'video_2',
        'date': '2025 07 22',
        'thumbnail': 'assets/images/flower2.png',
        'size': '856MB',
      },
      {
        'id': 'video_3',
        'date': '2025 06 22',
        'thumbnail': 'assets/images/flower3.png',
        'size': '2.1GB',
      },
      {
        'id': 'video_4',
        'date': '2025 06 22',
        'thumbnail': 'assets/images/flower1.png',
        'size': '1.5GB',
      },
      {
        'id': 'video_5',
        'date': '2025 06 22',
        'thumbnail': 'assets/images/flower2.png',
        'size': '987MB',
      },
      {
        'id': 'video_6',
        'date': '2025 05 22',
        'thumbnail': 'assets/images/flower3.png',
        'size': '1.8GB',
      },
    ];
  }

  List<Map<String, dynamic>> getDocumentsData() {
    return [
      {'id': 'doc_1', 'name': 'Document Name', 'size': '2.4GB'},
      {'id': 'doc_2', 'name': 'Large File name', 'size': '2.4GB'},
      {'id': 'doc_3', 'name': 'Important Document', 'size': '1.8GB'},
      {'id': 'doc_4', 'name': 'Project File', 'size': '3.2GB'},
      {'id': 'doc_5', 'name': 'Report.pdf', 'size': '856MB'},
    ];
  }
}
