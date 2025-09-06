import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompressionSettingsController extends GetxController {
  final selectedRatio = 25.obs; // Default compression ratio

  void setCompressionRatio(int ratio) {
    selectedRatio.value = ratio;
    // You can add additional logic here, such as saving to preferences
    Get.snackbar(
      'Compression Ratio',
      'Set to ${ratio}%',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF02A4FF),
      colorText: Colors.white,
    );
  }

  void goBack() {
    Get.back();
  }
}
