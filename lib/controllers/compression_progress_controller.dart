import 'package:get/get.dart';
import 'dart:async';
import '../routes/app_routes.dart';

class CompressionProgressController extends GetxController {
  final progress = 0.0.obs; // Progress from 0.0 to 1.0
  final currentItem = 0.obs; // Current item being processed
  final totalItems = 102.obs; // Total number of items to process

  @override
  void onInit() {
    super.onInit();
    _startCompression();
  }

  void _startCompression() {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (progress.value < 1.0) {
        progress.value += 0.01;
        currentItem.value = (progress.value * totalItems.value).round();
      } else {
        timer.cancel();
        // Navigate to completion screen after a short delay
        Future.delayed(const Duration(seconds: 1), () {
          Get.offAllNamed(AppRoutes.compressionComplete);
        });
      }
    });
  }

  void goBack() {
    Get.back();
  }
}
