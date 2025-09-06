import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/secure_storage_service.dart';
import '../services/route_tracker_service.dart';
import 'intruder_snap_controller.dart';

class PatternController extends GetxController {
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  late final SecureStorageService _secureStorage;

  @override
  void onInit() {
    super.onInit();
    // Use Get.put to ensure the service is available
    _secureStorage = Get.put(SecureStorageService());
  }

  Future<void> verifyPattern(List<int> input) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      print('Attempting to verify pattern');
      final isValid = await _secureStorage.verifyPattern(input);

      if (isValid) {
        Get.snackbar(
          "Success",
          "Pattern Verified",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.toNamed("/protected-apps");
      } else {
        errorMessage.value = "Wrong Pattern";
        Get.snackbar(
          "Error",
          "Wrong Pattern",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Pattern verification error: $e');
      errorMessage.value = "Verification failed. Please try again.";
      Get.snackbar(
        "Error",
        "Verification failed. Please try again.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Method to set initial pattern (for first-time setup)
  Future<void> setInitialPattern(List<int> pattern) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      print('Attempting to set initial pattern');
      await _secureStorage.savePattern(pattern);
      Get.snackbar(
        "Success",
        "Pattern set successfully",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      _navigateBasedOnSource();
    } catch (e) {
      print('Pattern setup error: $e');
      errorMessage.value = "Failed to set pattern. Please try again.";
      Get.snackbar(
        "Error",
        "Failed to set pattern. Please try again.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void _navigateBasedOnSource() {
    final routeTracker = RouteTrackerService.instance;

    print(
      'Navigating based on source - fromIntruderSnap: ${routeTracker.isFromIntruderSnap}, fromAppLock: ${routeTracker.isFromAppLock}, fromPrivateVault: ${routeTracker.isFromPrivateVault}',
    );

    if (routeTracker.isFromIntruderSnap) {
      final intruderController = Get.put(IntruderSnapController());
      intruderController.navigateAfterLockAuthentication();
    } else if (routeTracker.isFromPrivateVault) {
      // Navigate to private vault main view after pattern setup
      print('Navigating to private vault main view from pattern setup');
      Get.offAllNamed("/private-vault-main");
    } else if (routeTracker.isFromAppLock) {
      // Navigate to protected apps setup
      print('Navigating to protected apps setup from app lock');
      Get.offAllNamed(
        "/protected-apps",
        arguments: routeTracker.getNavigationArguments(),
      );
    } else {
      // Default navigation to protected apps
      Get.offAllNamed("/protected-apps");
    }

    // Clear the route tracking after navigation
    routeTracker.clearRoute();
  }
}
