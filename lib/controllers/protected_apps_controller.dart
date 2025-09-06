import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AppModel {
  final String name;
  final String packageName;
  final RxBool isLocked;
  final RxBool isProtected;
  final String iconPath;

  AppModel({
    required this.name,
    required this.packageName,
    required bool isLocked,
    required bool isProtected,
    required this.iconPath,
  }) : isLocked = isLocked.obs,
       isProtected = isProtected.obs;

  // Factory constructor for creating AppModel instances
  factory AppModel.fromJson(Map<String, dynamic> json) {
    return AppModel(
      name: json['name'] ?? '',
      packageName: json['packageName'] ?? '',
      isLocked: json['isLocked'] ?? false,
      isProtected: json['isProtected'] ?? false,
      iconPath: json['iconPath'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'packageName': packageName,
      'isLocked': isLocked.value,
      'isProtected': isProtected.value,
      'iconPath': iconPath,
    };
  }
}

class ProtectedAppsController extends GetxController {
  final apps = <AppModel>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final isSetupMode = false.obs;
  final lockType = ''.obs;
  final fromAppLock = false.obs;

  @override
  void onInit() {
    super.onInit();
    _getRouteArguments();
    _loadApps();
  }

  void _getRouteArguments() {
    final arguments = Get.arguments ?? {};
    fromAppLock.value = arguments['fromAppLock'] ?? false;
    lockType.value = arguments['lockType'] ?? '';

    // If coming from app lock setup, show setup mode
    if (fromAppLock.value) {
      isSetupMode.value = true;
    }
  }

  void _loadApps() {
    // Mock data based on the image - popular apps
    apps.value = [
      AppModel(
        name: "Chrome",
        packageName: "com.android.chrome",
        isLocked: false,
        isProtected: false,
        iconPath: "assets/icons/chrome.jpg",
      ),
      AppModel(
        name: "Facebook",
        packageName: "com.facebook.katana",
        isLocked: false,
        isProtected: false,
        iconPath: "assets/icons/facebook.png",
      ),
      AppModel(
        name: "Instagram",
        packageName: "com.instagram.android",
        isLocked: false,
        isProtected: false,
        iconPath: "assets/icons/instagram.jpg",
      ),
      AppModel(
        name: "Snapchat",
        packageName: "com.snapchat.android",
        isLocked: false,
        isProtected: false,
        iconPath: "assets/icons/snapchat.png",
      ),
      AppModel(
        name: "Skype",
        packageName: "com.skype.raider",
        isLocked: false,
        isProtected: false,
        iconPath: "assets/icons/skype.jpg",
      ),
      AppModel(
        name: "TikTok",
        packageName: "com.zhiliaoapp.musically",
        isLocked: false,
        isProtected: false,
        iconPath: "assets/icons/tiktok.jpg",
      ),
      AppModel(
        name: "WhatsApp",
        packageName: "com.whatsapp",
        isLocked: false,
        isProtected: false,
        iconPath: "assets/icons/whatsapp.png",
      ),
      AppModel(
        name: "YouTube",
        packageName: "com.google.android.youtube",
        isLocked: false,
        isProtected: false,
        iconPath: "assets/icons/youtube.jpg",
      ),
    ];
  }

  void toggleApp(AppModel app) {
    try {
      print("Toggling app: ${app.name}, isProtected: ${app.isProtected.value}");

      // If we're in protected mode and user taps an unprotected app, reset to selection mode
      if (protectedApps.isNotEmpty && !app.isProtected.value) {
        print("Resetting to selection mode");
        resetToSelectionMode();
        return; // Don't toggle the app, just reset
      }

      // Normal toggle for selection mode
      app.isLocked.value = !app.isLocked.value;
      apps.refresh();

      // In a real app, you would save this preference
      _saveAppPreference(app);
    } catch (e) {
      errorMessage.value = "Failed to update app setting";
      Get.snackbar(
        "Error",
        "Failed to update app setting",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void _saveAppPreference(AppModel app) {
    // In a real app, save to SharedPreferences or database
    // For now, just log the change
    print("App ${app.name} lock status changed to: ${app.isLocked.value}");
  }

  // Get all locked apps
  List<AppModel> get lockedApps =>
      apps.where((app) => app.isLocked.value).toList();

  // Get all unlocked apps
  List<AppModel> get unlockedApps =>
      apps.where((app) => !app.isLocked.value).toList();

  // Get all protected apps
  List<AppModel> get protectedApps =>
      apps.where((app) => app.isProtected.value).toList();

  // Get all unprotected apps
  List<AppModel> get unprotectedApps =>
      apps.where((app) => !app.isProtected.value).toList();

  // Lock all apps
  void lockAllApps() {
    for (var app in apps) {
      app.isLocked.value = true;
    }
    apps.refresh();
  }

  // Unlock all apps
  void unlockAllApps() {
    for (var app in apps) {
      app.isLocked.value = false;
    }
    apps.refresh();
  }

  // Clear all selections (X button functionality)
  void clearAllSelections() {
    for (var app in apps) {
      app.isLocked.value = false;
    }
    apps.refresh();
  }

  // Reset to selection mode (clear protection and selections)
  void resetToSelectionMode() {
    print("Resetting to selection mode");
    for (var app in apps) {
      app.isProtected.value = false;
      app.isLocked.value = false;
    }
    apps.refresh();
  }

  // Add more apps to protection (keep existing protected apps)
  void addMoreAppsToProtection() {
    print("Adding more apps to protection");
    // Keep existing protected apps as protected
    // Clear only the locked selections
    for (var app in apps) {
      app.isLocked.value = false;
    }
    apps.refresh();
  }

  // Show confirmation dialog for making apps protected
  void showProtectionConfirmation() {
    print("showProtectionConfirmation called");
    final selectedApps = apps.where((app) => app.isLocked.value).toList();
    print("Selected apps count: ${selectedApps.length}");
    if (selectedApps.isEmpty) {
      print("No apps selected, showing snackbar");
      Get.snackbar(
        "No Apps Selected",
        "Please select apps to protect",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }
    print("Showing confirmation dialog");

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            color: Get.isDarkMode ? Colors.grey[850] : Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Unlocked padlock icon
              Container(
                width: 15.w,
                height: 15.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF07A6FF).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.lock_open_rounded,
                  color: const Color(0xFF07A6FF),
                  size: 8.w,
                ),
              ),

              SizedBox(height: 3.h),

              // Title
              Text(
                "Make Protected",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 5.w,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                ),
              ),

              SizedBox(height: 2.h),

              // Message
              Text(
                "Are you sure you want to make these apps protected?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 4.w,
                  color: Get.isDarkMode ? Colors.grey[300] : Colors.grey[600],
                ),
              ),

              SizedBox(height: 4.h),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        decoration: BoxDecoration(
                          color: Get.isDarkMode
                              ? Colors.grey[800]
                              : Colors.grey[100],
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: const Color(0xFF07A6FF),
                            width: 2,
                          ),
                        ),
                        child: Text(
                          "No",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 4.w,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF07A6FF),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 3.w),

                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                        _confirmProtection();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF07A6FF),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          "Yes",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 4.w,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmProtection() {
    // Mark selected apps as protected
    final selectedApps = apps.where((app) => app.isLocked.value).toList();
    for (var app in selectedApps) {
      app.isProtected.value = true;
    }

    // Clear selections after protection
    clearAllSelections();

    // Show success message
    final totalProtected = protectedApps.length;
    Get.snackbar(
      "Success",
      "$totalProtected apps are now protected",
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}
