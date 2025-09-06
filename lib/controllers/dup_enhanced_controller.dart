import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DupEnhancedController extends GetxController {
  // User guidance state
  final isFirstTimeUser = true.obs;
  final showUserGuide = false.obs;
  final currentGuideStep = 0.obs;

  // Image data
  final mainImage = 'assets/images/flower1.png';
  final fileName = 'File Name';
  final fileSize = '20MB';

  // Image dimensions for maximum quality
  final imageWidth = 1200.0;
  final imageHeight = 900.0;

  // High quality image paths
  final highQualityImages = [
    'assets/images/flower1.png',
    'assets/images/flower2.png',
    'assets/images/flower3.png',
  ];

  // Thumbnail images
  final thumbnails = [
    'assets/images/flower1.png',
    'assets/images/flower1.png',
    'assets/images/flower2.png',
  ];

  // Interactive state
  final isOverviewMode = false.obs;
  final selectedAction = ''.obs;

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
    _checkFirstTimeUser();
  }

  Future<void> _checkFirstTimeUser() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeenGuide = prefs.getBool('has_seen_duplicate_guide') ?? false;
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
    await prefs.setBool('has_seen_duplicate_guide', true);

    showUserGuide.value = false;
    isFirstTimeUser.value = false;

    Get.snackbar(
      'Guide Complete',
      'You\'re all set! Use swipe gestures to manage duplicates.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF02A4FF),
      colorText: Colors.white,
    );
  }

  void skipGuide() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_seen_duplicate_guide', true);

    showUserGuide.value = false;
    isFirstTimeUser.value = false;
  }

  void toggleOverviewMode() {
    isOverviewMode.value = !isOverviewMode.value;
    if (isOverviewMode.value) {
      selectedAction.value = '';
    }
  }

  void handleSwipeGesture(String direction) {
    if (!isOverviewMode.value) {
      toggleOverviewMode();
    }

    switch (direction) {
      case 'left':
        selectedAction.value = 'cancel';
        _showActionFeedback('Cancel selected');
        break;
      case 'right':
        selectedAction.value = 'delete';
        _showActionFeedback('Delete selected');
        break;
      case 'down':
        toggleOverviewMode();
        break;
    }
  }

  void handleHorizontalSwipe(double dx) {
    if (dx > 50) {
      // Swipe right - delete
      handleSwipeGesture('right');
    } else if (dx < -50) {
      // Swipe left - cancel
      handleSwipeGesture('left');
    }
  }

  void handleVerticalSwipe(double dy) {
    if (dy > 50) {
      // Swipe down - close overview
      handleSwipeGesture('down');
    }
  }

  void _showActionFeedback(String message) {
    Get.snackbar(
      'Action',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF02A4FF),
      colorText: Colors.white,
      duration: const Duration(seconds: 1),
    );
  }

  void goBack() {
    Get.back();
  }
}
