import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChargingAnimationController extends GetxController {
  final selectedAnimation = ''.obs;

  void selectAnimation(String animationName) {
    selectedAnimation.value = animationName;

    // Show success message and navigate back
    Get.snackbar(
      'Animation Selected',
      '$animationName has been set as your charging animation',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF02A4FF),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );

    // Navigate back after showing the message
    Future.delayed(const Duration(seconds: 2), () {
      Get.back();
    });
  }

  void goBack() {
    Get.back();
  }
}
