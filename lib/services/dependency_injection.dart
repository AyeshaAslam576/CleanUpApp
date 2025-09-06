import 'package:get/get.dart';
import '../controllers/welcome_controller.dart';
import '../controllers/feature_controller.dart';
import '../controllers/optimizecontroller.dart';
import '../controllers/settings_controller.dart';
import '../controllers/choose_lock_controller.dart';
import '../controllers/fingerprint_lock_controller.dart';
import '../controllers/pattern_controller.dart';
import '../controllers/pin_controller.dart';
import '../controllers/cleaned_controller.dart';
import '../controllers/contacts_controller.dart';
import '../controllers/contact_scanning_controller.dart';
import '../controllers/intruder_snap_controller.dart';
import '../controllers/private_vault_controller.dart';
import '../controllers/private_vault_main_controller.dart';
import '../controllers/media_manager_controller.dart';
import '../controllers/media_compression_controller.dart';
import '../controllers/compression_progress_controller.dart';
import '../controllers/compression_complete_controller.dart';
import '../controllers/compression_settings_controller.dart';
import '../controllers/charging_animation_controller.dart';
import '../controllers/email_cleaner_controller.dart';
import '../controllers/duplicate_photos_controller.dart';
import '../controllers/optimize_storage_controller.dart';
import '../controllers/clean_email_controller.dart';
import '../controllers/subscription_controller.dart';
import '../controllers/free_trial_controller.dart';
import '../controllers/protected_apps_controller.dart';
import '../controllers/theme_controller.dart';
import 'route_tracker_service.dart';

class DependencyInjection {
  static Future<void> init() async {
    // Core Controllers
    Get.lazyPut<WelcomeController>(() => WelcomeController(), fenix: true);
    Get.lazyPut<FeatureController>(() => FeatureController(), fenix: true);
    Get.lazyPut<OptimizeController>(() => OptimizeController(), fenix: true);
    Get.lazyPut<SettingsController>(() => SettingsController(), fenix: true);

    // App Lock & Security Controllers
    Get.lazyPut<ChooseLockController>(
      () => ChooseLockController(),
      fenix: true,
    );
    Get.lazyPut<FingerprintLockController>(
      () => FingerprintLockController(),
      fenix: true,
    );
    Get.lazyPut<PatternController>(() => PatternController(), fenix: true);
    Get.lazyPut<PinController>(() => PinController(), fenix: true);

    // Storage & Cleanup Controllers
    Get.lazyPut<CleanedController>(() => CleanedController(), fenix: true);
    Get.lazyPut<ContactsController>(() => ContactsController(), fenix: true);
    Get.lazyPut<ContactScanningController>(
      () => ContactScanningController(),
      fenix: true,
    );
    Get.lazyPut<IntruderSnapController>(
      () => IntruderSnapController(),
      fenix: true,
    );
    Get.lazyPut<PrivateVaultController>(
      () => PrivateVaultController(),
      fenix: true,
    );
    Get.lazyPut<PrivateVaultMainController>(
      () => PrivateVaultMainController(),
      fenix: true,
    );

    // Media & Compression Controllers
    Get.lazyPut<MediaManagerController>(
      () => MediaManagerController(),
      fenix: true,
    );
    Get.lazyPut<MediaCompressionController>(
      () => MediaCompressionController(),
      fenix: true,
    );
    Get.lazyPut<CompressionProgressController>(
      () => CompressionProgressController(),
      fenix: true,
    );
    Get.lazyPut<CompressionCompleteController>(
      () => CompressionCompleteController(),
      fenix: true,
    );
    Get.lazyPut<CompressionSettingsController>(
      () => CompressionSettingsController(),
      fenix: true,
    );
    Get.lazyPut<ChargingAnimationController>(
      () => ChargingAnimationController(),
      fenix: true,
    );
    Get.lazyPut<EmailCleanerController>(
      () => EmailCleanerController(),
      fenix: true,
    );

    // Additional Controllers
    Get.lazyPut<DuplicatePhotosController>(
      () => DuplicatePhotosController(),
      fenix: true,
    );
    Get.lazyPut<OptimizeStorageController>(
      () => OptimizeStorageController(),
      fenix: true,
    );
    Get.lazyPut<CleanEmailController>(
      () => CleanEmailController(),
      fenix: true,
    );
    Get.lazyPut<SubscriptionController>(
      () => SubscriptionController(),
      fenix: true,
    );
    Get.lazyPut<FreeTrialController>(() => FreeTrialController(), fenix: true);
    Get.lazyPut<ProtectedAppsController>(
      () => ProtectedAppsController(),
      fenix: true,
    );

    // Theme Controller - Initialize immediately for system theme detection
    Get.put<ThemeController>(ThemeController(), permanent: true);

    // Route Tracker Service - Initialize immediately for global access
    Get.put<RouteTrackerService>(RouteTrackerService(), permanent: true);
  }
}
