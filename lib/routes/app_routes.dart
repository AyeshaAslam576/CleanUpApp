import 'package:get/get.dart';
import 'package:mycleanupapp/views/optimizeview.dart';
import '../views/choose_lock_view.dart';
import '../views/choose_lock_type_view.dart';
import '../views/fingerprint_lock_view.dart';
import '../views/fullscreen_ad_view.dart';
import '../views/pattern_lock_view.dart';
import '../views/pin_lock_view.dart';
import '../views/pin_setup_view.dart';
import '../views/protected_apps_view.dart';
import '../views/welcome_view.dart';
import '../views/duplicate_photos_view.dart';
import '../views/optimize_storage_view.dart';
import '../views/clean_email_view.dart';
import '../views/free_trial_view.dart';
import '../views/subscription_view.dart';
import '../views/feature_view.dart';
import '../views/duplication_clean_view.dart';
import '../views/dup_enhanced_view.dart';
import '../views/cleaned_view.dart';
import '../views/contacts_view.dart';
import '../views/contact_scanning_view.dart';
import '../views/intruder_snap_view.dart';
import '../views/private_vault_view.dart';
import '../views/private_vault_main_view.dart';
import '../views/media_manager_view.dart';
import '../views/media_compression_view.dart';
import '../views/compression_progress_view.dart';
import '../views/compression_complete_view.dart';
import '../views/compression_settings_view.dart';
import '../views/charging_animation_view.dart';
import '../views/email_cleaner_view.dart';
import '../views/settings_view.dart';
import 'app_pages.dart';

class AppRoutes {
  // Core Navigation Routes
  static const String welcome = '/welcome';
  static const String features = '/features';
  static const String optimizeView = '/optimize';
  static const String settings = '/settings';

  // App Lock & Security Routes
  static const String chooseLockType = '/choose-lock-type';
  static const String fingerprintSetup = '/fingerprint-setup';
  static const String patternSetupNew = '/pattern-setup';
  static const String pinSetupNew = '/pin-setup';

  // Storage & Cleanup Routes
  static const String duplicationClean = '/duplication-clean';
  static const String dupEnhanced = '/dup-enhanced';
  static const String cleaned = '/cleaned';

  // Contacts & Privacy Routes
  static const String contacts = '/contacts';
  static const String contactScanning = '/contact-scanning';
  static const String intruderSnap = '/intruder-snap';

  // Private Vault Routes
  static const String privateVault = '/private-vault';
  static const String privateVaultMain = '/private-vault-main';

  // Media Management Routes
  static const String mediaManager = '/media-manager';
  static const String mediaCompression = '/media-compression';
  static const String compressionProgress = '/compression-progress';
  static const String compressionComplete = '/compression-complete';
  static const String compressionSettings = '/compression-settings';

  // Special Features Routes
  static const String chargingAnimation = '/charging-animation';
  static const String emailCleaner = '/email-cleaner';

  // Legacy Routes (for backward compatibility)
  static const String duplicatePhotos = '/duplicate-photos';
  static const String optimizeStorage = '/optimize_storage_view';
  static const String cleanEmail = '/clean_email_view';
  static const String freeTrial = '/free_trial_view';
  static const String subscription = '/subscription_view';
  static const chooseLock = "/choose_lock_view";
  static const pin = "/pin_lock_view";
  static const pinSetup = "/pin-setup";
  static const pattern = "/pattern_lock_view";
  static const patternSetup = "/pattern-setup";
  static const fingerprint = "/fingerprint_lock_view";
  static const protectedApps = "/protected_apps_view";
  static const fullscreenAd = "/fullscreen_ad_view";

  // Get all routes from AppPages
  static final routes = AppPages.routes;
}
