import 'package:get/get.dart';

class UnlockController extends GetxController {
  void onConfirm() {
    Get.back(result: true);
  }

  void onCancel() {
    Get.back(result: false);
  }
}
