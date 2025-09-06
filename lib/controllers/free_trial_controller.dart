import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class FreeTrialController extends GetxController {
  var isEnabled = false.obs;

  void toggleTrial(bool value) {
    try {
      print('Attempting to toggle trial: $value');
      isEnabled.value = value;

      if (value) {
        // ✅ Switch enable hote hi subscription screen pe move
        print('Attempting to navigate to: ${AppRoutes.subscription}');
        Get.toNamed(AppRoutes.subscription);
      }
    } catch (e) {
      print('Error in toggleTrial: $e');
      Get.snackbar(
        'Error',
        'Failed to toggle trial: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }
}
