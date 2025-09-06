import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../repositories/storage_repository.dart';
import '../routes/app_routes.dart';

class WelcomeController extends GetxController {
  late final StorageRepository _storageRepository;

  final usedGB = 0.obs;
  final totalGB = 128.obs;
  final usedPercentage = 0.0.obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Use Get.put to ensure the repository is available
    _storageRepository = Get.put(StorageRepository());
    _loadStorageInfo();
  }

  Future<void> _loadStorageInfo() async {
    isLoading.value = true;
    try {
      final storageInfo = await _storageRepository.getStorageInfo();
      usedGB.value = storageInfo.usedGB;
      totalGB.value = storageInfo.totalGB;
      usedPercentage.value = storageInfo.usedPercentage;
    } catch (e) {
      errorMessage.value = 'Failed to load storage information';
      // Use default values
      usedGB.value = 100;
      totalGB.value = 128;
      usedPercentage.value = 100 / 128;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> navigateToNextScreen() async {
    try {
      // Navigate to duplicate photos screen (first in the flow)
      print('Attempting to navigate to: ${AppRoutes.duplicatePhotos}');
      Get.toNamed(AppRoutes.duplicatePhotos);
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

  Future<void> requestPermissions() async {
    // In a real app, you would request storage permissions here
    // For now, we'll just show a message
    Get.snackbar(
      'Permissions',
      'Storage access granted',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}
