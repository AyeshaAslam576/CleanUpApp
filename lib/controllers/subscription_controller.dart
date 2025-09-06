import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class SubscriptionController extends GetxController {
  final isLoading = false.obs;
  final isFreeTrialEnabled = true.obs;
  final isSubscribed = false.obs;
  final usedGB = 76.obs;
  final totalGB = 100.obs;
  final usedPercentage = 0.76.obs;
  final trialDays = 7.obs;
  final pricePerWeek = 2200.0.obs;
  final isTrialEnabled = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSubscriptionData();
  }

  Future<void> _loadSubscriptionData() async {
    isLoading.value = true;
    try {
      // Simulate loading subscription data
      await Future.delayed(const Duration(milliseconds: 500));
      // Mock data - user has free trial enabled
      isFreeTrialEnabled.value = true;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load subscription data',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void toggleFreeTrial() {
    isFreeTrialEnabled.value = !isFreeTrialEnabled.value;

    Get.snackbar(
      'Updated',
      'Free trial ${isFreeTrialEnabled.value ? 'enabled' : 'disabled'}',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }

  void toggleTrial(bool value) {
    isTrialEnabled.value = value;
  }

  Future<void> subscribe() async {
    isLoading.value = true;
    try {
      // Simulate subscription process
      await Future.delayed(const Duration(seconds: 2));

      isSubscribed.value = true;
      Get.snackbar(
        'Success',
        'Subscription activated!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Navigate to main app after successful subscription
      Get.toNamed(AppRoutes.optimizeView);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to subscribe',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void restorePurchase() {
    Get.snackbar(
      'Info',
      'Restore purchase feature coming soon',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }

  void skipSubscription() {
    // Navigate to main app without subscription
    Get.toNamed(AppRoutes.optimizeView);
  }
}
