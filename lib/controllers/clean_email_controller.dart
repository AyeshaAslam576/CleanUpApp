import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class CleanEmailController extends GetxController {
  final isLoading = false.obs;
  final spamCount = 0.obs;
  final isCleaning = false.obs;
  final spamEmails = 4378.obs;
  final spamPercentage = 0.76.obs;

  @override
  void onInit() {
    super.onInit();
    _loadEmailData();
  }

  Future<void> _loadEmailData() async {
    isLoading.value = true;
    try {
      // Simulate loading email data
      await Future.delayed(const Duration(seconds: 1));
      spamCount.value = 4378; // Mock data from the screenshot
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load email data',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> cleanEmails() async {
    isCleaning.value = true;
    try {
      // Simulate email cleaning process
      await Future.delayed(const Duration(seconds: 2));

      Get.snackbar(
        'Success',
        'Cleaned ${spamCount.value} spam emails',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      spamCount.value = 0;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to clean emails',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isCleaning.value = false;
    }
  }

  void navigateToNext() {
    try {
      print('Attempting to navigate to: ${AppRoutes.freeTrial}');
      Get.toNamed(AppRoutes.freeTrial);
    } catch (e) {
      print('Navigation error in CleanEmailController: $e');
      Get.snackbar(
        'Navigation Error',
        'Failed to navigate: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }
}
