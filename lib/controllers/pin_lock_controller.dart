import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../routes/app_routes.dart';

class PinLockController extends GetxController {
  final isLoading = false.obs;
  final isSetupMode = true.obs;
  final enteredPin = <String>[].obs;
  final confirmPinList = <String>[].obs;
  final isConfirming = false.obs;
  final errorMessage = ''.obs;
  final maxPinLength = 5;

  @override
  void onInit() {
    super.onInit();
    _checkIfSetupNeeded();
  }

  Future<void> _checkIfSetupNeeded() async {
    final prefs = await SharedPreferences.getInstance();
    final hasPin = prefs.getString('pin_lock') != null;
    isSetupMode.value = !hasPin;
  }

  void addDigit(String digit) {
    if (enteredPin.length < maxPinLength) {
      enteredPin.add(digit);
    }
  }

  void deleteDigit() {
    if (enteredPin.isNotEmpty) {
      enteredPin.removeLast();
    }
  }

  void clearPin() {
    enteredPin.clear();
    confirmPinList.clear();
    isConfirming.value = false;
    errorMessage.value = '';
  }

  Future<void> confirmPin() async {
    if (enteredPin.length < 4) {
      errorMessage.value = 'PIN must be at least 4 digits';
      return;
    }

    if (!isConfirming.value) {
      // First time entering PIN
      confirmPinList.value = List.from(enteredPin);
      isConfirming.value = true;
      enteredPin.clear();
    } else {
      // Confirming PIN
      if (_pinsMatch(enteredPin, confirmPinList)) {
        await _savePin(enteredPin);
        await _markAppLockAsSet();
        Get.snackbar(
          'Success',
          'PIN lock set successfully!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        // Navigate to private vault main if coming from private vault setup
        if (Get.arguments != null && Get.arguments['from'] == 'private_vault') {
          Get.offAllNamed(AppRoutes.privateVaultMain);
        } else {
          Get.toNamed(AppRoutes.optimizeView);
        }
      } else {
        errorMessage.value = 'PINs do not match. Try again.';
        clearPin();
      }
    }
  }

  bool _pinsMatch(List<String> pin1, List<String> pin2) {
    if (pin1.length != pin2.length) return false;
    for (int i = 0; i < pin1.length; i++) {
      if (pin1[i] != pin2[i]) return false;
    }
    return true;
  }

  Future<void> _savePin(List<String> pin) async {
    final prefs = await SharedPreferences.getInstance();
    final pinString = pin.join('');
    final hashedPin = sha256.convert(utf8.encode(pinString)).toString();
    await prefs.setString('pin_lock', hashedPin);
  }

  Future<void> _markAppLockAsSet() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_app_lock', true);
    await prefs.setString('lock_type', 'pin');
  }

  String getInstructionText() {
    if (isSetupMode.value) {
      return isConfirming.value ? 'Confirm Your PIN' : 'Create Your PIN';
    } else {
      return 'Enter Your PIN';
    }
  }

  void goBack() {
    try {
      print('Attempting to go back from PIN lock screen');
      Get.back();
    } catch (e) {
      print('Error going back: $e');
      Get.snackbar(
        'Navigation Error',
        'Failed to go back: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  Future<void> verifyPin() async {
    try {
      print('Attempting to verify PIN');

      if (enteredPin.length < 4) {
        errorMessage.value = 'PIN must be at least 4 digits';
        return;
      }

      if (isSetupMode.value) {
        // In setup mode, use confirmPin logic
        await confirmPin();
      } else {
        // In verification mode, check against stored PIN
        final prefs = await SharedPreferences.getInstance();
        final storedPinHash = prefs.getString('pin_lock');

        if (storedPinHash != null) {
          final enteredPinString = enteredPin.join('');
          final enteredPinHash = sha256
              .convert(utf8.encode(enteredPinString))
              .toString();

          if (enteredPinHash == storedPinHash) {
            // PIN is correct
            Get.snackbar(
              'Success',
              'PIN verified successfully!',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
            // Navigate to next screen
            Get.toNamed(AppRoutes.optimizeView);
          } else {
            // PIN is incorrect
            errorMessage.value = 'Incorrect PIN. Try again.';
            clearPin();
          }
        } else {
          errorMessage.value = 'No PIN set. Please set up a PIN first.';
        }
      }
    } catch (e) {
      print('PIN verification error: $e');
      errorMessage.value = 'Verification failed. Please try again.';
      Get.snackbar(
        'Error',
        'Verification failed. Please try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }
}
