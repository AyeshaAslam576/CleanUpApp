import 'package:get/get.dart';
import '../routes/app_routes.dart';

class CompressionCompleteController extends GetxController {
  void goBack() {
    // Navigate back to the media compression view
    Get.offAllNamed(AppRoutes.mediaCompression);
  }
}
