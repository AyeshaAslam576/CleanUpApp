import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class OptimizeStorageController extends GetxController {
  final usedGB = 7.obs;
  final totalGB = 128.obs;
  final isLoading = false.obs;

  // Storage category percentages
  final appsPercentage = 0.25.obs;
  final osPercentage = 0.20.obs;
  final mediaPercentage = 0.15.obs;
  final systemPercentage = 0.10.obs;
  final unusedPercentage = 0.30.obs;

  @override
  void onInit() {
    super.onInit();
    _loadStorageData();
  }

  Future<void> _loadStorageData() async {
    isLoading.value = true;
    try {
      // Simulate loading storage data with our animated spinner
      await Future.delayed(const Duration(seconds: 3));
      // Data is already set in observables
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load storage data',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Method to manually trigger loading for demonstration
  void refreshStorageData() async {
    await _loadStorageData();
  }

  void navigateToNext() {
    try {
      print('Attempting to navigate to: ${AppRoutes.cleanEmail}');
      Get.toNamed(AppRoutes.cleanEmail);
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

  void optimizeStorage() {
    Get.snackbar(
      'Info',
      'Storage optimization feature coming soon',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }
}
