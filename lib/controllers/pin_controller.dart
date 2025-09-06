import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/secure_storage_service.dart';
import '../services/route_tracker_service.dart';
import 'intruder_snap_controller.dart';

class PinController extends GetxController {
  final enteredPin = <String>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  late final SecureStorageService _secureStorage;

  @override
  void onInit() {
    super.onInit();
    // Use Get.put to ensure the service is available
    _secureStorage = Get.put(SecureStorageService());
  }

  void addDigit(String digit) {
    if (enteredPin.length < 4) {
      enteredPin.add(digit);
      errorMessage.value = ''; // Clear error when user types

      if (enteredPin.length == 4) {
        verifyPin();
      }
    }
  }

  void deletePin() {
    if (enteredPin.isNotEmpty) {
      enteredPin.removeLast();
      errorMessage.value = ''; // Clear error when user deletes
    }
  }

  Future<void> verifyPin() async {
    if (enteredPin.length != 4) return;

    isLoading.value = true;
    errorMessage.value = '';

    try {
      print('Attempting to verify PIN');
      final pin = enteredPin.join();
      final isValid = await _secureStorage.verifyPin(pin);

      if (isValid) {
        Get.snackbar(
          "Success",
          "PIN Verified",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.toNamed("/protected-apps");
      } else {
        errorMessage.value = "Invalid PIN";
        Get.snackbar(
          "Error",
          "Invalid PIN",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        enteredPin.clear();
      }
    } catch (e) {
      print('PIN verification error: $e');
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

  // Method for PIN setup (first time)
  Future<void> setupPin() async {
    if (enteredPin.length != 4) return;

    isLoading.value = true;
    errorMessage.value = '';

    try {
      print('Attempting to setup PIN');
      final pin = enteredPin.join();
      await _secureStorage.savePin(pin);

      Get.snackbar(
        "Success",
        "PIN set successfully",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      _navigateBasedOnSource();
    } catch (e) {
      print('PIN setup error: $e');
      errorMessage.value = "Failed to set PIN. Please try again.";
      Get.snackbar(
        "Error",
        "Failed to set PIN. Please try again.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Method to set initial PIN (for first-time setup)
  Future<void> setInitialPin(String pin) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      print('Attempting to set initial PIN');
      await _secureStorage.savePin(pin);
      Get.snackbar(
        "Success",
        "PIN set successfully",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      print('Initial PIN setup error: $e');
      errorMessage.value = "Failed to set PIN. Please try again.";
      Get.snackbar(
        "Error",
        "Failed to set PIN. Please try again.",
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
      // Navigate to intruder snap main view after PIN setup
      print('Navigating to intruder snap main view from PIN setup');
      // Use intruder snap controller to determine correct destination
      final intruderController = Get.put(IntruderSnapController());
      intruderController.navigateAfterLockAuthentication();
    } else if (routeTracker.isFromPrivateVault) {
      // Navigate to private vault main view after PIN setup
      print('Navigating to private vault main view from PIN setup');
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
