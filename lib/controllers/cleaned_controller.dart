
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class CleanedController extends GetxController {
  final cleanedSize = "450 MBs".obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _startAutoNavigation();
  }

  void _startAutoNavigation() {
    // Auto-navigate to optimize screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(AppRoutes.optimizeView);
    });
  }

  void goToOptimize() {
    Get.offAllNamed(AppRoutes.optimizeView);
  }

  void goBack() {
    Get.offAllNamed(AppRoutes.optimizeView);
  }
}
