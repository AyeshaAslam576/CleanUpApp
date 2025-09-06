import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class DuplicatePhotosController extends GetxController {
  final selectedImages = <String>{}.obs;
  final totalSize = "500MB".obs;
  final selectedCount = 0.obs;
  final selectedSize = "0MB".obs;

  // Selection mode state
  final isSelectionMode = false.obs;

  // Simple photos list for the duplicate view
  final photos = <String>[
    'assets/images/flower1.png',
    'assets/images/flower2.png',
    'assets/images/flower3.png',
    'assets/images/flower1.png',
    'assets/images/flower2.png',
    'assets/images/flower3.png',
  ];

  // Selection state for each photo
  final selected = <int, bool>{}.obs;

  // Duplicate images data grouped by date
  final duplicateGroups = [
    {
      'date': '2025 07 22',
      'images': [
        {'id': '1', 'path': 'assets/images/flower1.png', 'size': '2.5MB'},
        {'id': '2', 'path': 'assets/images/flower1.png', 'size': '2.5MB'},
      ],
    },
    {
      'date': '2025 06 22',
      'images': [
        {'id': '3', 'path': 'assets/images/flower2.png', 'size': '3.2MB'},
        {'id': '4', 'path': 'assets/images/flower2.png', 'size': '3.2MB'},
        {'id': '5', 'path': 'assets/images/flower3.png', 'size': '4.1MB'},
        {'id': '6', 'path': 'assets/images/flower3.png', 'size': '4.1MB'},
        {'id': '7', 'path': 'assets/images/flower3.png', 'size': '4.1MB'},
        {'id': '8', 'path': 'assets/images/flower3.png', 'size': '4.1MB'},
        {'id': '9', 'path': 'assets/images/flower1.png', 'size': '2.5MB'},
        {'id': '10', 'path': 'assets/images/flower1.png', 'size': '2.5MB'},
        {'id': '11', 'path': 'assets/images/flower1.png', 'size': '2.5MB'},
        {'id': '12', 'path': 'assets/images/flower1.png', 'size': '2.5MB'},
        {'id': '13', 'path': 'assets/images/flower1.png', 'size': '2.5MB'},
        {'id': '14', 'path': 'assets/images/flower2.png', 'size': '3.2MB'},
        {'id': '15', 'path': 'assets/images/flower2.png', 'size': '3.2MB'},
        {'id': '16', 'path': 'assets/images/flower2.png', 'size': '3.2MB'},
      ],
    },
    {
      'date': '2025 05 22',
      'images': [
        {'id': '17', 'path': 'assets/images/flower2.png', 'size': '3.2MB'},
        {'id': '18', 'path': 'assets/images/flower2.png', 'size': '3.2MB'},
        {'id': '19', 'path': 'assets/images/flower3.png', 'size': '4.1MB'},
        {'id': '20', 'path': 'assets/images/flower3.png', 'size': '4.1MB'},
        {'id': '21', 'path': 'assets/images/flower1.png', 'size': '2.5MB'},
        {'id': '22', 'path': 'assets/images/flower1.png', 'size': '2.5MB'},
      ],
    },
  ].obs;

  void toggleImageSelection(String imageId) {
    if (selectedImages.contains(imageId)) {
      selectedImages.remove(imageId);
    } else {
      selectedImages.add(imageId);
    }
    _updateSelectionStats();
  }

  void enableSelectionMode() {
    isSelectionMode.value = true;
  }

  void disableSelectionMode() {
    isSelectionMode.value = false;
    selectedImages.clear();
    _updateSelectionStats();
  }

  void handleImageTap(String imageId, Map<String, dynamic> image) {
    if (isSelectionMode.value) {
      // In selection mode, toggle selection
      toggleImageSelection(imageId);
    } else {
      // Not in selection mode, navigate to enhanced view
      navigateToEnhancedView(image);
    }
  }

  void toggleSelection(int index) {
    selected[index] = !(selected[index] ?? false);
  }

  void selectAllImages() {
    for (var group in duplicateGroups) {
      for (var image in group['images'] as List<Map<String, dynamic>>) {
        final imageId = image['id'];
        if (imageId != null) {
          selectedImages.add(imageId);
        }
      }
    }
    _updateSelectionStats();
  }

  void clearSelection() {
    selectedImages.clear();
    _updateSelectionStats();
  }

  void _updateSelectionStats() {
    selectedCount.value = selectedImages.length;

    // Calculate total size of selected images
    double totalSizeInMB = 0;
    for (var group in duplicateGroups) {
      for (var image in group['images'] as List<Map<String, dynamic>>) {
        final imageId = image['id'];
        if (imageId != null && selectedImages.contains(imageId)) {
          final sizeStr = image['size'];
          if (sizeStr != null) {
            try {
              double sizeInMB = double.parse(
                sizeStr.toString().replaceAll('MB', ''),
              );
              totalSizeInMB += sizeInMB;
            } catch (e) {
              print('Error parsing size: $sizeStr');
            }
          }
        }
      }
    }

    selectedSize.value = "${totalSizeInMB.toStringAsFixed(0)}MB";
  }

  void startCleanup() {
    if (selectedImages.isEmpty) {
      Get.snackbar(
        'No Images Selected',
        'Please select images to clean up',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    Get.snackbar(
      'Cleanup Started',
      'Deleting ${selectedCount.value} duplicate images (${selectedSize.value})',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    // Simulate cleanup process
    Future.delayed(const Duration(seconds: 2), () {
      // Remove selected images from the list
      for (var group in duplicateGroups) {
        final images = group['images'] as List<Map<String, dynamic>>;
        images.removeWhere((image) {
          final imageId = image['id'];
          return imageId != null && selectedImages.contains(imageId);
        });
      }

      // Clear selection
      selectedImages.clear();
      _updateSelectionStats();

      // Navigate to cleaned view
      Get.toNamed(AppRoutes.cleaned);
    });
  }

  void goBack() {
    Get.back();
  }

  void navigateToNext() {
    try {
      print('Attempting to navigate to: ${AppRoutes.optimizeStorage}');
      Get.toNamed(AppRoutes.optimizeStorage);
    } catch (e) {
      print('Navigation error: $e');
      Get.snackbar(
        'Navigation Error',
        'Failed to navigate: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  void navigateToEnhancedView(Map<String, dynamic> image) {
    try {
      // Navigate to the enhanced duplicate view
      Get.toNamed(AppRoutes.dupEnhanced);
    } catch (e) {
      print('Navigation error: $e');
      Get.snackbar(
        'Navigation Error',
        'Failed to navigate to enhanced view: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }
}
