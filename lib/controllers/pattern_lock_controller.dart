import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import '../routes/app_routes.dart';

class PatternLockController extends GetxController {
  final isLoading = false.obs;
  final isSetupMode = true.obs;
  final enteredPattern = <int>[].obs;
  final confirmPatternList = <int>[].obs;
  final isConfirming = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _checkIfSetupNeeded();
  }

  Future<void> _checkIfSetupNeeded() async {
    final prefs = await SharedPreferences.getInstance();
    final hasPattern = prefs.getString('pattern_lock') != null;
    isSetupMode.value = !hasPattern;
  }

  void addPatternPoint(int point) {
    if (enteredPattern.length < 9) {
      enteredPattern.add(point);
    }
  }

  void clearPattern() {
    enteredPattern.clear();
    confirmPatternList.clear();
    isConfirming.value = false;
    errorMessage.value = '';
  }

  Future<void> confirmPattern() async {
    if (enteredPattern.length < 4) {
      errorMessage.value = 'Pattern must be at least 4 points';
      return;
    }

    if (!isConfirming.value) {
      // First time entering pattern
      confirmPatternList.value = List.from(enteredPattern);
      isConfirming.value = true;
      enteredPattern.clear();
    } else {
      // Confirming pattern
      if (_patternsMatch(enteredPattern, confirmPatternList)) {
        await _savePattern(enteredPattern);
        await _markAppLockAsSet();
        Get.snackbar(
          'Success',
          'Pattern lock set successfully!',
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
        errorMessage.value = 'Patterns do not match. Try again.';
        clearPattern();
      }
    }
  }

  bool _patternsMatch(List<int> pattern1, List<int> pattern2) {
    if (pattern1.length != pattern2.length) return false;
    for (int i = 0; i < pattern1.length; i++) {
      if (pattern1[i] != pattern2[i]) return false;
    }
    return true;
  }

  Future<void> _savePattern(List<int> pattern) async {
    final prefs = await SharedPreferences.getInstance();
    final patternString = pattern.join(',');
    final hashedPattern = sha256.convert(utf8.encode(patternString)).toString();
    await prefs.setString('pattern_lock', hashedPattern);
  }

  Future<void> _markAppLockAsSet() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_app_lock', true);
    await prefs.setString('lock_type', 'pattern');
  }

  String getInstructionText() {
    if (isSetupMode.value) {
      return isConfirming.value
          ? 'Draw Your Pattern Again'
          : 'Draw Your Pattern';
    } else {
      return 'Enter Your Pattern';
    }
  }
}
