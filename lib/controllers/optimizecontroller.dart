import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';

class OptimizeController extends GetxController {
  // Circular progress value (0–1)
  var junkPercentage = 0.75.obs; // example: 75% filled
  var junkSize = "3.12 GB".obs;
  final selectedTabIndex = 0.obs;

  // Loading states for animations
  var isOptimizing = false.obs;
  var isLoadingCategories = false.obs;
  var optimizationProgress = 0.0.obs;
  var showOptimizedImage = false.obs;

  // Example categories (you can replace with your real data)
  final categories = [
    {
      "title": "Duplicate Images",
      "subtitle": "658 Images",
      "size": "120.65MB",
      "image": "assets/images/flower1.png",
    },
    {
      "title": "Similar Screenshots",
      "subtitle": "125 Images",
      "size": "136.65MB",
      "image": "assets/images/flower2.png",
    },
    {
      "title": "Large Videos",
      "subtitle": "5 Videos",
      "size": "1.5GB",
      "image": "assets/images/flower3.png",
    },
    {
      "title": "Screenshots",
      "subtitle": "125 Images",
      "size": "136.65MB",
      "image": "assets/images/flower1.png",
    },
    {
      "title": "Old Documents",
      "subtitle": "125 Images",
      "size": "136.65MB",
      "image": "assets/images/flower2.png",
    },
    {
      "title": "WhatsApp Images",
      "subtitle": "125 Images",
      "size": "136.65MB",
      "image": "assets/images/flower3.png",
    },
    {
      "title": "WhatsApp Apps",
      "subtitle": "3 Apps",
      "size": "2.65GB",
      "image": "assets/images/flower1.png",
    },
  ];

  void cleanCategory(Map<String, dynamic> category) {
    // Navigate to the duplication clean view with the category title
    Get.toNamed(AppRoutes.duplicationClean, arguments: category["title"]);
  }

  @override
  void onInit() {
    super.onInit();
    _loadCategories();
  }

  void _loadCategories() async {
    isLoadingCategories.value = true;
    // Simulate loading categories
    await Future.delayed(const Duration(seconds: 1));
    isLoadingCategories.value = false;
  }

  void setSelectedTab(int index) {
    selectedTabIndex.value = index;

    switch (index) {
      case 0: // Home icon - Stay on Optimize view (current view)
        // Already on optimize view, no navigation needed
        break;
      case 1: // Feature icon - Navigate to Feature view
        Get.offAllNamed(AppRoutes.features);
        break;
      case 2: // Settings icon - Navigate to Settings view
        Get.offAllNamed(AppRoutes.settings);
        break;
    }
  }

  void optimizeStorage() async {
    // Start optimization with animated loading
    isOptimizing.value = true;
    optimizationProgress.value = 0.0;
    showOptimizedImage.value = false;

    // Play splashloader animation twice with speed 0.2-0.5
    await _playSplashAnimation();

    // Show optimized image after animation
    showOptimizedImage.value = true;
    isOptimizing.value = false;

    // Update final values
    junkSize.value = "0.12 GB";
    junkPercentage.value = 0.05;

    // Show success message
    Get.snackbar(
      'Optimization Complete!',
      'Storage cleaned successfully',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF4CAF50),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );

    // Navigate to cleaned view after a short delay
    Future.delayed(const Duration(seconds: 1), () {
      Get.toNamed(AppRoutes.cleaned);
    });
  }

  Future<void> _playSplashAnimation() async {
    // Animation duration for 2 loops at 0.2-0.5 speed
    // Reduced to 2-3 seconds total
    await Future.delayed(const Duration(milliseconds: 2500));
  }
}
