import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class SettingsController extends GetxController {
  final selectedTabIndex = 2.obs; // Settings tab is active by default
  final isDarkMode = false.obs;
  final usePin = true.obs;
  final removeAfterImport = false.obs;

  void onMoreAppsTap() {
    Get.snackbar(
      'More Apps',
      'More apps from us will be displayed here',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF02A4FF),
      colorText: Colors.white,
    );
  }

  void onSignInTap() {
    Get.snackbar(
      'Sign In',
      'Sign in functionality will be implemented here',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF02A4FF),
      colorText: Colors.white,
    );
  }

  void onWidgetsTap() {
    Get.snackbar(
      'Widgets and Tips',
      'Widgets and tips will be displayed here',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF02A4FF),
      colorText: Colors.white,
    );
  }

  void onDarkModeChanged(bool value) {
    isDarkMode.value = value;
    Get.snackbar(
      'Theme Changed',
      'Dark mode ${value ? 'enabled' : 'disabled'}',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF02A4FF),
      colorText: Colors.white,
    );
  }

  void setSelectedTab(int index) {
    selectedTabIndex.value = index;

    switch (index) {
      case 0: // Home icon - Navigate to Optimize view
        Get.offAllNamed(AppRoutes.optimizeView);
        break;
      case 1: // Feature icon - Navigate to Feature view
        Get.offAllNamed(AppRoutes.features);
        break;
      case 2: // Settings icon - Stay on Settings view (current view)
        // Already on settings view, no navigation needed
        break;
    }
  }

  void onUsePinChanged(bool value) {
    usePin.value = value;
    Get.snackbar(
      'Security Updated',
      'Use Pin ${value ? 'enabled' : 'disabled'}',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF02A4FF),
      colorText: Colors.white,
    );
  }

  void onRemoveAfterImportChanged(bool value) {
    removeAfterImport.value = value;
    Get.snackbar(
      'Security Updated',
      'Remove after import ${value ? 'enabled' : 'disabled'}',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF02A4FF),
      colorText: Colors.white,
    );
  }

  void onPrivacyPolicyTap() {
    Get.snackbar(
      'Privacy Policy',
      'Privacy policy will be displayed here',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF02A4FF),
      colorText: Colors.white,
    );
  }

  void onFAQsTap() {
    Get.snackbar(
      'FAQs',
      'Frequently asked questions will be displayed here',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF02A4FF),
      colorText: Colors.white,
    );
  }

  void onContactTap() {
    Get.snackbar(
      'Contact',
      'Contact information will be displayed here',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF02A4FF),
      colorText: Colors.white,
    );
  }

  void onRateAppTap() {
    Get.snackbar(
      'Rate App',
      'App rating functionality will be implemented here',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF02A4FF),
      colorText: Colors.white,
    );
  }

  void onShareTap() {
    Get.snackbar(
      'Share',
      'Share functionality will be implemented here',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF02A4FF),
      colorText: Colors.white,
    );
  }

  void onInstagramTap() {
    Get.snackbar(
      'Instagram',
      'Instagram follow functionality will be implemented here',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF02A4FF),
      colorText: Colors.white,
    );
  }

  void onAddMoreTap() {
    Get.snackbar(
      'Add More',
      'Subscription or upgrade functionality will be implemented here',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF02A4FF),
      colorText: Colors.white,
    );
  }

  void onNavItemTap(int index) {
    selectedTabIndex.value = index;

    switch (index) {
      case 0: // Home
        Get.toNamed(AppRoutes.welcome);
        break;
      case 1: // Apps/Grid
        Get.toNamed(AppRoutes.features);
        break;
      case 2: // Settings
        // Already on settings screen
        break;
    }
  }

  void goBack() {
    Get.back();
  }
}
