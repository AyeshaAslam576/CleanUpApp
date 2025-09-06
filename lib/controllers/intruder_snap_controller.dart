import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntruderSnapController extends GetxController {
  final isEnabled = false.obs;
  final isLoading = false.obs;
  final hasSnaps = false.obs;
  final wrongPasswordAttempts = 1.obs;
  final currentSnapIndex = 0.obs;

  // User guidance state
  final isFirstTimeUser = true.obs;
  final showUserGuide = false.obs;
  final currentGuideStep = 0.obs;

  // Gallery will use flower images directly from assets
  final intruderSnaps = <Map<String, dynamic>>[].obs;

  // Guide steps for first-time users
  final guideSteps = [
    'Swipe left to cancel',
    'Swipe right to delete',
    'Swipe down to close overview',
    'Use fast swipe for quick actions',
  ];

  @override
  void onInit() {
    super.onInit();
    _loadIntruderSnapStatus();
    _checkFirstTimeUser();
  }

  Future<void> _loadIntruderSnapStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final enabled = prefs.getBool('intruder_snap_enabled') ?? false;
      final attempts = prefs.getInt('wrong_password_attempts') ?? 1;

      isEnabled.value = enabled;
      hasSnaps.value = true; // Always show gallery view
      wrongPasswordAttempts.value = attempts;
    } catch (e) {
      print('Error loading intruder snap status: $e');
    }
  }

  Future<void> enableIntruderSnap() async {
    try {
      isLoading.value = true;

      // Save to preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('intruder_snap_enabled', true);

      isEnabled.value = true;

      Get.snackbar(
        'Success',
        'Intruder Snap has been enabled',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      // Navigate based on user status
      _navigateToMainIntruderSnapView();
    } catch (e) {
      print('Error enabling intruder snap: $e');
      Get.snackbar(
        'Error',
        'Failed to enable Intruder Snap',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void _navigateToMainIntruderSnapView() {
    // Always go to gallery view after lock setup
    print('Navigating to gallery view after lock setup');
    Get.offAllNamed('/intruder-snap-gallery');
  }

  // Method to handle navigation after successful lock authentication
  void navigateAfterLockAuthentication() {
    // This method will be called after successful lock setup/authentication
    // Navigate based on user status
    _navigateToMainIntruderSnapView();
  }

  Future<void> disableIntruderSnap() async {
    try {
      isLoading.value = true;

      // Save to preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('intruder_snap_enabled', false);

      isEnabled.value = false;

      Get.snackbar(
        'Success',
        'Intruder Snap has been disabled',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      print('Error disabling intruder snap: $e');
      Get.snackbar(
        'Error',
        'Failed to disable Intruder Snap',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void handleMenuAction(String action) {
    switch (action) {
      case 'disable':
        showDisableConfirmation();
        break;
      case 'empty':
        showEmptySnapsConfirmation();
        break;
      case 'setting':
        Get.toNamed('/intruder-snap-settings');
        break;
    }
  }

  void showOptionsMenu() {
    // This will be handled by the PopupMenuButton in the view
  }

  void showDisableConfirmation() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.security, color: Colors.blue, size: 24),
            SizedBox(width: 12),
            Text(
              'Disable Intruder Snap',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to disable Intruder Snap',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Yes',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              disableIntruderSnap();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Text(
              'No',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showEmptySnapsConfirmation() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Empty All Snaps',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        content: Text(
          'Are you sure you want to delete all intruder snaps? This action cannot be undone.',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              emptyAllSnaps();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Text(
              'Delete All',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void emptyAllSnaps() {
    intruderSnaps.clear();
    hasSnaps.value = false;
    Get.snackbar(
      'Success',
      'All intruder snaps have been deleted',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  void cancelAction() {
    Get.back();
  }

  void deleteSnap(int index) {
    if (index >= 0 && index < intruderSnaps.length) {
      intruderSnaps.removeAt(index);
      if (intruderSnaps.isEmpty) {
        hasSnaps.value = false;
      }
      Get.snackbar(
        'Success',
        'Intruder snap deleted',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      Get.back();
    }
  }

  void closeOverview() {
    Get.back();
  }

  void switchToSnap(int index) {
    if (index >= 0 && index < intruderSnaps.length) {
      currentSnapIndex.value = index;
      // Navigate to detail view with new snap
      Get.offNamed(
        '/intruder-snap-detail',
        arguments: {'snap': intruderSnaps[index], 'index': index},
      );
    }
  }

  Future<void> setWrongPasswordAttempts(int attempts) async {
    try {
      wrongPasswordAttempts.value = attempts;

      // Save to preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('wrong_password_attempts', attempts);

      Get.snackbar(
        'Success',
        'Wrong password attempts setting updated',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      print('Error saving wrong password attempts setting: $e');
      Get.snackbar(
        'Error',
        'Failed to save setting',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  void goBack() {
    Get.back();
  }

  Future<void> _checkFirstTimeUser() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeenGuide = prefs.getBool('has_seen_intruder_guide') ?? false;
    isFirstTimeUser.value = !hasSeenGuide;

    if (isFirstTimeUser.value) {
      showUserGuide.value = true;
    }
  }

  void nextGuideStep() {
    if (currentGuideStep.value < guideSteps.length - 1) {
      currentGuideStep.value++;
    } else {
      _completeUserGuide();
    }
  }

  void previousGuideStep() {
    if (currentGuideStep.value > 0) {
      currentGuideStep.value--;
    }
  }

  void _completeUserGuide() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_seen_intruder_guide', true);

    showUserGuide.value = false;
    isFirstTimeUser.value = false;

    Get.snackbar(
      'Guide Complete',
      'You\'re all set! Use swipe gestures to manage intruder snaps.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF02A4FF),
      colorText: Colors.white,
    );
  }

  void skipGuide() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_seen_intruder_guide', true);

    showUserGuide.value = false;
    isFirstTimeUser.value = false;
  }
}
