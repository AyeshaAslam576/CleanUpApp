import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../services/secure_storage_service.dart';

class ChooseLockController extends GetxController {
  late final SecureStorageService _secureStorage;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Use Get.put to ensure the service is available
    _secureStorage = Get.put(SecureStorageService());
  }

  Future<void> selectLock(String type) async {
    isLoading.value = true;

    try {
      print('Attempting to select lock type: $type');
      if (type == "pin") {
        // Check if PIN is already set
        final hasPin = await _secureStorage.isPinSet();
        if (hasPin) {
          Get.toNamed(AppRoutes.pin); // Go to verification
        } else {
          Get.toNamed(AppRoutes.pinSetupNew); // Go to setup
        }
      } else if (type == "pattern") {
        // Check if pattern is already set
        final hasPattern = await _secureStorage.getPattern() != null;
        if (hasPattern) {
          Get.toNamed(AppRoutes.pattern); // Go to verification
        } else {
          Get.toNamed(AppRoutes.patternSetupNew); // Go to setup
        }
      } else if (type == "fingerprint") {
        Get.toNamed(AppRoutes.fingerprint);
      } else {
        print('Unknown lock type: $type');
        Get.snackbar(
          'Error',
          'Unknown lock type: $type',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Error selecting lock type: $e');
      Get.snackbar(
        'Error',
        'Failed to check lock status: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
