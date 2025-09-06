import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import '../services/route_tracker_service.dart';
import 'intruder_snap_controller.dart';

class FingerprintController extends GetxController {
  final LocalAuthentication auth = LocalAuthentication();

  Future<void> authenticate() async {
    try {
      bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to unlock',
      );

      if (didAuthenticate) {
        _navigateBasedOnSource();
      } else {
        Get.snackbar("Error", "Authentication failed");
      }
    } catch (e) {
      Get.snackbar("Error", "Biometric not available");
    }
  }

  Future<void> setupFingerprint() async {
    try {
      bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to set up fingerprint lock',
      );

      if (didAuthenticate) {
        Get.snackbar(
          "Success",
          "Fingerprint lock set successfully",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        _navigateBasedOnSource();
      } else {
        Get.snackbar("Error", "Authentication failed");
      }
    } catch (e) {
      Get.snackbar("Error", "Biometric not available");
    }
  }

  void _navigateBasedOnSource() {
    final routeTracker = RouteTrackerService.instance;

    print(
      'Navigating based on source - fromIntruderSnap: ${routeTracker.isFromIntruderSnap}, fromAppLock: ${routeTracker.isFromAppLock}, fromPrivateVault: ${routeTracker.isFromPrivateVault}',
    );

    if (routeTracker.isFromIntruderSnap) {
      // Navigate to intruder snap main view after fingerprint setup
      print('Navigating to intruder snap main view from fingerprint setup');
      // Use intruder snap controller to determine correct destination
      final intruderController = Get.put(IntruderSnapController());
      intruderController.navigateAfterLockAuthentication();
    } else if (routeTracker.isFromPrivateVault) {
      // Navigate to private vault main view after fingerprint setup
      print('Navigating to private vault main view from fingerprint setup');
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
