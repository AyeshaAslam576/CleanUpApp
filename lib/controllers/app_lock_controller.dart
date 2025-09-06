import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/app_routes.dart';

class AppLockController extends GetxController {
  final isLoading = false.obs;
  final selectedLockType = ''.obs;
  final isFirstTime = true.obs;
  final routeSource = ''.obs; // Track where the user came from

  @override
  void onInit() {
    super.onInit();
    _checkFirstTimeUser();
    _getRouteSource();
  }

  void _getRouteSource() {
    // Get the source route from arguments
    final arguments = Get.arguments;
    if (arguments != null && arguments['source'] != null) {
      routeSource.value = arguments['source'];
    }
  }

  Future<void> _checkFirstTimeUser() async {
    final prefs = await SharedPreferences.getInstance();
    final hasLock = prefs.getBool('has_app_lock') ?? false;
    isFirstTime.value = !hasLock;
  }

  void selectLockType(String type) {
    selectedLockType.value = type;

    // Get arguments to pass to lock setup screens
    final arguments = Get.arguments ?? {};

    // Add the lock type and source to arguments
    final setupArguments = {
      ...arguments,
      'lockType': type,
      'source': routeSource.value,
      'fromAppLock': true,
    };

    switch (type) {
      case 'fingerprint':
        Get.toNamed(AppRoutes.fingerprintSetup, arguments: setupArguments);
        break;
      case 'pin':
        Get.toNamed(AppRoutes.pinSetupNew, arguments: setupArguments);
        break;
      case 'pattern':
        Get.toNamed(AppRoutes.patternSetupNew, arguments: setupArguments);
        break;
    }
  }

  Future<void> markAppLockAsSet() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_app_lock', true);
    await prefs.setString('lock_type', selectedLockType.value);
  }

  void goBack() {
    Get.back();
  }

  // Navigate to protected apps setup after successful lock setup
  void navigateToProtectedAppsSetup() {
    final arguments = Get.arguments ?? {};
    final setupArguments = {
      ...arguments,
      'source': routeSource.value,
      'fromAppLock': true,
      'lockType': selectedLockType.value,
    };

    Get.offAllNamed(AppRoutes.protectedApps, arguments: setupArguments);
  }
}
