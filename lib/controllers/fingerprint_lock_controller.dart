import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth/local_auth.dart';

class FingerprintLockController extends GetxController {
  final isLoading = false.obs;
  final isSetupMode = true.obs;
  final isAuthenticated = false.obs;
  final errorMessage = ''.obs;
  final LocalAuthentication _localAuth = LocalAuthentication();

  @override
  void onInit() {
    super.onInit();
    _checkIfSetupNeeded();
  }

  Future<void> _checkIfSetupNeeded() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final hasFingerprint = prefs.getBool('fingerprint_lock') ?? false;
      isSetupMode.value = !hasFingerprint;
    } catch (e) {
      print('Error checking fingerprint setup: $e');
      errorMessage.value = 'Failed to check fingerprint status';
    }
  }

  Future<void> authenticateWithFingerprint() async {
    try {
      print('Attempting fingerprint authentication');
      final isAvailable = await _localAuth.canCheckBiometrics;

      if (!isAvailable) {
        Get.snackbar(
          'Biometrics Not Available',
          'Fingerprint authentication is not available on this device',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        return;
      }

      final isAuthenticated = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to continue',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      if (isAuthenticated) {
        Get.snackbar(
          'Success',
          'Fingerprint authentication successful',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        // Navigate to protected apps
        Get.toNamed("/protected-apps");
      } else {
        Get.snackbar(
          'Authentication Failed',
          'Fingerprint authentication was not successful',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Fingerprint authentication error: $e');
      Get.snackbar(
        'Error',
        'Fingerprint authentication failed: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  Future<void> setupFingerprint() async {
    try {
      print('Attempting to setup fingerprint');

      // Check if biometrics are available with proper null safety
      print('Checking device support for setup...');
      final isDeviceSupported = await _localAuth.isDeviceSupported();
      print('Device supported for setup: $isDeviceSupported');

      if (!isDeviceSupported) {
        print('Device does not support biometric authentication for setup');
        Get.snackbar(
          'Device Not Supported',
          'Biometric authentication is not supported on this device',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        return;
      }

      print('Checking biometric availability for setup...');
      final isAvailable = await _localAuth.canCheckBiometrics;
      print('Biometrics available for setup: $isAvailable');

      if (isAvailable != true) {
        print('Biometrics not available for setup on this device');
        Get.snackbar(
          'Biometrics Not Available',
          'Fingerprint authentication is not available on this device',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        return;
      }

      // Get available biometrics to ensure there are methods available
      print('Getting available biometrics for setup...');
      final availableBiometrics = await _localAuth.getAvailableBiometrics();
      print('Available biometrics for setup: $availableBiometrics');

      if (availableBiometrics.isEmpty) {
        print('No biometric methods available for setup');
        Get.snackbar(
          'No Biometrics Available',
          'No biometric authentication methods are available',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        return;
      }

      print('Starting fingerprint setup authentication...');
      // For setup, we'll just authenticate once to confirm it works
      final isAuthenticated = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to setup fingerprint lock',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      print('Setup authentication result: $isAuthenticated');
      if (isAuthenticated) {
        print('Setup authentication successful, saving settings...');
        // Save the fingerprint lock setting
        await _saveFingerprintLock();
        await _markAppLockAsSet();

        Get.snackbar(
          'Success',
          'Fingerprint lock setup successful',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Check if this is coming from app lock setup
        final arguments = Get.arguments ?? {};
        final fromAppLock = arguments['fromAppLock'] ?? false;

        if (fromAppLock) {
          // Navigate to protected apps setup
          print('Navigating to protected apps setup from app lock');
          Get.offAllNamed(
            "/protected-apps",
            arguments: {
              ...arguments,
              'lockType': 'fingerprint',
              'fromAppLock': true,
            },
          );
        } else {
          // Navigate to protected apps after setup
          Get.offAllNamed("/protected-apps");
        }
      } else {
        print('Setup authentication failed');
        Get.snackbar(
          'Setup Failed',
          'Fingerprint setup was not successful',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Fingerprint setup error: $e');
      print('Setup error stack trace: ${StackTrace.current}');
      Get.snackbar(
        'Error',
        'Fingerprint setup failed: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  Future<void> _saveFingerprintLock() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('fingerprint_lock', true);
    } catch (e) {
      print('Error saving fingerprint lock: $e');
      throw e;
    }
  }

  Future<void> _markAppLockAsSet() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('has_app_lock', true);
      await prefs.setString('lock_type', 'fingerprint');
    } catch (e) {
      print('Error marking app lock as set: $e');
      throw e;
    }
  }

  String getInstructionText() {
    return isSetupMode.value
        ? 'Register finger print'
        : 'Touch the fingerprint sensor';
  }
}
