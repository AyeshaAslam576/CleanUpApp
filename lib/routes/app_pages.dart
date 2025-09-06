import 'package:get/get.dart';
import '../views/welcome_view.dart';
import '../views/feature_view.dart';
import '../views/optimizeview.dart';
import '../views/settings_view.dart';
import '../views/choose_lock_type_view.dart';
import '../views/fingerprint_lock_view.dart';
import '../views/pattern_lock_view.dart';
import '../views/pin_lock_view.dart';
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
import '../views/duplicate_photos_view.dart';
import '../views/optimize_storage_view.dart';
import '../views/clean_email_view.dart';
import '../views/subscription_view.dart';
import '../views/free_trial_view.dart';
import '../views/protected_apps_view.dart';
import '../views/fullscreen_ad_view.dart';
import '../views/unclock_dialogue.dart';
import '../views/intruder_snap_no_snaps_view.dart';
import '../views/intruder_snap_gallery_view.dart';
import '../views/intruder_snap_detail_view.dart';
import '../views/intruder_snap_settings_view.dart';

class AppPages {
  static final routes = [
    // Core Navigation
    GetPage(name: '/welcome', page: () => const WelcomeView()),
    GetPage(name: '/features', page: () => const FeatureView()),
    GetPage(name: '/optimize', page: () => const OptimizeView()),
    GetPage(name: '/settings', page: () => const SettingsView()),

    // App Lock & Security
    GetPage(name: '/choose-lock-type', page: () => const ChooseLockTypeView()),
    GetPage(
      name: '/fingerprint-setup',
      page: () => const FingerprintLockView(),
    ),
    GetPage(name: '/pattern-setup', page: () => const PatternLockView()),
    GetPage(name: '/pin-setup', page: () => const PinLockView()),

    // Storage & Cleanup
    GetPage(name: '/duplicate-photos', page: () => const DuplicatePhotosView()),
    GetPage(
      name: '/duplication-clean',
      page: () => const DuplicationCleanView(categoryTitle: 'Duplicate Images'),
    ),
    GetPage(name: '/dup-enhanced', page: () => const DupEnhancedView()),
    GetPage(name: '/cleaned', page: () => const CleanedView()),
    GetPage(
      name: '/optimize_storage_view',
      page: () => const OptimizeStorageView(),
    ),
    GetPage(name: '/clean_email_view', page: () => const CleanEmailView()),

    // Media & Compression
    GetPage(name: '/media-manager', page: () => const MediaManagerView()),
    GetPage(
      name: '/media-compression',
      page: () => const MediaCompressionView(),
    ),
    GetPage(
      name: '/compression-progress',
      page: () => const CompressionProgressView(),
    ),
    GetPage(
      name: '/compression-complete',
      page: () => const CompressionCompleteView(),
    ),
    GetPage(
      name: '/compression-settings',
      page: () => const CompressionSettingsView(),
    ),
    GetPage(
      name: '/charging-animation',
      page: () => const ChargingAnimationView(),
    ),
    GetPage(name: '/email-cleaner', page: () => const EmailCleanerView()),

    // Contacts & Scanning
    GetPage(name: '/contacts', page: () => const ContactsView()),
    GetPage(name: '/contact-scanning', page: () => const ContactScanningView()),
    GetPage(name: '/intruder-snap', page: () => const IntruderSnapView()),
    GetPage(
      name: '/intruder-snap-no-snaps',
      page: () => const IntruderSnapNoSnapsView(),
    ),
    GetPage(
      name: '/intruder-snap-gallery',
      page: () => const IntruderSnapGalleryView(),
    ),
    GetPage(
      name: '/intruder-snap-detail',
      page: () => const IntruderSnapDetailView(),
    ),
    GetPage(
      name: '/intruder-snap-settings',
      page: () => const IntruderSnapSettingsView(),
    ),

    // Private Vault
    GetPage(name: '/private-vault', page: () => const PrivateVaultView()),
    GetPage(
      name: '/private-vault-main',
      page: () => const PrivateVaultMainView(),
    ),

    // Additional Features
    GetPage(name: '/subscription_view', page: () => const Subscription()),
    GetPage(name: '/free_trial_view', page: () => const FreeTrialView()),
    GetPage(name: '/protected-apps', page: () => ProtectedAppsView()),
    GetPage(name: '/fullscreen-ad', page: () => FullscreenAdView()),
    GetPage(name: '/unlock-dialogue', page: () => UnlockDialog()),

    // Legacy Routes (for backward compatibility)
    GetPage(name: '/duplicate-photos', page: () => const DuplicatePhotosView()),
    GetPage(name: '/pin', page: () => const PinLockView()),
    GetPage(name: '/pattern', page: () => const PatternLockView()),
    GetPage(name: '/fingerprint', page: () => const FingerprintLockView()),
    GetPage(name: '/pin-setup-new', page: () => const PinLockView()),
    GetPage(name: '/pattern-setup-new', page: () => const PatternLockView()),
    GetPage(
      name: '/fingerprint-setup-new',
      page: () => const FingerprintLockView(),
    ),
  ];
}
