import 'package:get/get.dart';
import '../routes/app_routes.dart';

class PrivateVaultController extends GetxController {
  final isEnabled = false.obs;
  final isLoading = false.obs;

  void enablePrivateVault() {
    // Navigate to choose lock type to secure the private vault
    Get.toNamed(AppRoutes.chooseLockType, arguments: {'from': 'private_vault'});
  }

  void goBack() {
    Get.back();
  }
}
