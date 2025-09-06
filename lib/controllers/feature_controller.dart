import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../services/route_tracker_service.dart';
import 'theme_controller.dart';
import '../utils/app_theme.dart';

class FeatureController extends GetxController {
  final selectedTabIndex = 1.obs; // Apps tab is active by default

  // Core features data
  final coreFeatures = [
    {
      'icon': Icons.lock,
      'title': 'Application Lock',
      'color': Colors.blue,
      'route': 'app_lock',
    },
    {
      'icon': Icons.person,
      'title': 'Contacts',
      'color': Colors.orange,
      'route': 'contacts',
    },
    {
      'icon': Icons.camera_alt,
      'title': 'Intruder Snaps',
      'color': Colors.red,
      'route': 'intruder_snaps',
    },
    {
      'icon': Icons.security,
      'title': 'Private Vault',
      'color': Colors.red,
      'route': 'private_vault',
    },
    {
      'icon': Icons.folder_copy_rounded,
      'title': 'Manage Files',
      'color': Colors.purple,
      'route': 'manage_files',
    },
    {
      'icon': Icons.grid_view_rounded,
      'title': 'Unused Apps',
      'color': Colors.orange,
      'route': 'unused_apps',
    },
  ];

  // Top features data
  final topFeatures = [
    {
      'imagePath': 'assets/images/charginganimator.png',
      'title': 'Charging Animation',
      'color': Colors.blue,
      'route': 'charging_animation',
    },
    {
      'imagePath': 'assets/images/mailclean.png',
      'title': 'Email Clean Up',
      'color': Colors.blue,
      'route': 'email_cleanup',
    },
    {
      'imagePath': 'assets/images/compression.png',
      'title': 'Compression',
      'color': Colors.green,
      'route': 'compression',
    },
  ];

  void setSelectedTab(int index) {
    selectedTabIndex.value = index;

    // Navigate to the appropriate view based on the selected tab
    switch (index) {
      case 0: // Home icon - Navigate to Optimize view
        Get.offAllNamed(AppRoutes.optimizeView);
        break;
      case 1: // Feature icon - Stay on Feature view (current view)
        // Already on feature view, no navigation needed
        break;
      case 2: // Settings icon - Navigate to Settings view
        Get.offAllNamed(AppRoutes.settings);
        break;
    }
  }

  void onFeatureTap(String route) {
    try {
      print('Attempting to navigate to feature: $route');
      // Navigate to specific feature routes
      switch (route) {
        case 'app_lock':
          // Set route source for app lock
          RouteTrackerService.instance.setRouteSource(
            source: 'app_lock',
            setupType: 'app_lock',
          );
          Get.toNamed(AppRoutes.chooseLockType);
          break;
        case 'contacts':
          Get.toNamed(AppRoutes.contacts);
          break;
        case 'intruder_snaps':
          Get.toNamed(AppRoutes.intruderSnap);
          break;
        case 'private_vault':
          // Set route source for private vault
          RouteTrackerService.instance.setRouteSource(
            source: 'private_vault',
            setupType: 'private_vault',
          );
          Get.toNamed(AppRoutes.chooseLockType);
          break;
        case 'manage_files':
          Get.toNamed(AppRoutes.mediaManager);
          break;
        case 'unused_apps':
          // Navigate to unused apps
          Get.snackbar(
            'Coming Soon',
            'Unused apps feature will be available soon',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.blue,
            colorText: Colors.white,
          );
          break;
        case 'charging_animation':
          Get.toNamed(AppRoutes.chargingAnimation);
          break;
        case 'email_cleanup':
          Get.toNamed(AppRoutes.emailCleaner);
          break;
        case 'compression':
          _showCompressionDialog();
          break;
        default:
          print('Unknown route: $route');
          Get.snackbar(
            'Navigation Error',
            'Unknown feature route: $route',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
      }
    } catch (e) {
      print('Navigation error in onFeatureTap: $e');
      Get.snackbar(
        'Navigation Error',
        'Failed to navigate to feature: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  void onNavItemTap(int index) {
    try {
      print('Attempting to navigate to nav item: $index');
      setSelectedTab(index);

      switch (index) {
        case 0: // Home
          Get.toNamed(AppRoutes.welcome);
          break;
        case 1: // Apps/Grid
          Get.toNamed(AppRoutes.optimizeView);
          break;
        case 2: // Settings
          Get.toNamed(AppRoutes.settings);
          break;
        default:
          print('Unknown nav index: $index');
          Get.snackbar(
            'Navigation Error',
            'Unknown navigation index: $index',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
      }
    } catch (e) {
      print('Navigation error in onNavItemTap: $e');
      Get.snackbar(
        'Navigation Error',
        'Failed to navigate to nav item: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  void closeBannerAd() {
    // Handle banner ad close
    Get.snackbar(
      'Ad Closed',
      'Banner advertisement closed',
      snackPosition: SnackPosition.TOP,
    );
  }

  void _showCompressionDialog() {
    final themeController = Get.find<ThemeController>();
    final theme = Get.context != null
        ? Theme.of(Get.context!)
        : AppTheme.lightTheme;

    Get.dialog(
      Obx(() {
        // Listen to theme changes
        themeController.isDarkMode.value;
        themeController.isSystemTheme.value;

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Media icon with stacked photo and video icons
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Photo icon (background)
                      Icon(
                        Icons.photo,
                        size: 40,
                        color: theme.colorScheme.primary.withOpacity(0.6),
                      ),
                      // Video icon (on top, slightly offset)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.videocam,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Title
                Text(
                  'Select Media',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),

                // Instruction
                Text(
                  'Please Select or Capture Media for Compression',
                  style: TextStyle(
                    fontSize: 14,
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // Action buttons
                Row(
                  children: [
                    // Camera button
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.back(); // Close dialog
                          Get.snackbar(
                            'Camera Feature',
                            'Camera feature coming soon!',
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: theme.colorScheme.primary,
                            colorText: Colors.white,
                            duration: const Duration(seconds: 2),
                          );
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.outline.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: theme.colorScheme.outline.withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.camera_alt,
                                color: theme.colorScheme.onSurface.withOpacity(
                                  0.7,
                                ),
                                size: 18,
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  'Camera',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: theme.colorScheme.onSurface
                                        .withOpacity(0.7),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Gallery button
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.back(); // Close dialog
                          Get.toNamed(AppRoutes.mediaCompression);
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.photo_library,
                                color: theme.colorScheme.onPrimary,
                                size: 18,
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  'Gallery',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: theme.colorScheme.onPrimary,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
      barrierDismissible: true,
    );
  }
}
