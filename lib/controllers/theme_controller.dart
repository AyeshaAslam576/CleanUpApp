import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.find();

  final isDarkMode = false.obs;
  final isSystemTheme = true.obs;

  @override
  void onInit() {
    super.onInit();
    print('🎨 ThemeController initialized');
    _loadThemePreference();
    _listenToSystemTheme();
  }

  void _listenToSystemTheme() {
    // Listen to system theme changes
    WidgetsBinding
        .instance
        .platformDispatcher
        .onPlatformBrightnessChanged = () {
      if (isSystemTheme.value) {
        final brightness =
            WidgetsBinding.instance.platformDispatcher.platformBrightness;
        isDarkMode.value = brightness == Brightness.dark;
        print(
          '🌓 System theme changed: ${brightness == Brightness.dark ? "Dark" : "Light"}',
        );
        // Obx will automatically rebuild when reactive variables change
      }
    };
  }

  Future<void> _loadThemePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDark = prefs.getBool('is_dark_mode') ?? false;
      final isSystem = prefs.getBool('is_system_theme') ?? true;

      isSystemTheme.value = isSystem;

      if (isSystem) {
        // Use system theme
        final brightness =
            WidgetsBinding.instance.platformDispatcher.platformBrightness;
        isDarkMode.value = brightness == Brightness.dark;
        Get.changeThemeMode(ThemeMode.system);
        print(
          '🎨 Loading system theme: ${brightness == Brightness.dark ? "Dark" : "Light"}',
        );
      } else {
        // Use saved preference
        isDarkMode.value = isDark;
        Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
        print('🎨 Loading saved theme: ${isDark ? "Dark" : "Light"}');
      }
      // Obx will automatically rebuild when reactive variables change
    } catch (e) {
      print('Error loading theme preference: $e');
    }
  }

  Future<void> toggleTheme() async {
    try {
      isDarkMode.value = !isDarkMode.value;
      isSystemTheme.value = false;

      // Save preference
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_dark_mode', isDarkMode.value);
      await prefs.setBool('is_system_theme', false);

      // Apply theme
      Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
      // Obx will automatically rebuild when reactive variables change

      Get.snackbar(
        'Theme Changed',
        isDarkMode.value ? 'Dark theme enabled' : 'Light theme enabled',
        snackPosition: SnackPosition.TOP,
        backgroundColor: isDarkMode.value ? Colors.grey[800] : Colors.white,
        colorText: isDarkMode.value ? Colors.white : Colors.black,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      print('Error toggling theme: $e');
    }
  }

  Future<void> setTheme(bool isDark) async {
    try {
      isDarkMode.value = isDark;
      isSystemTheme.value = false;

      // Save preference
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_dark_mode', isDark);
      await prefs.setBool('is_system_theme', false);

      // Apply theme
      Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
      // Obx will automatically rebuild when reactive variables change
    } catch (e) {
      print('Error setting theme: $e');
    }
  }

  Future<void> useSystemTheme() async {
    try {
      isSystemTheme.value = true;

      // Save preference
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_system_theme', true);

      // Apply system theme
      Get.changeThemeMode(ThemeMode.system);

      // Update dark mode based on current system theme
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      isDarkMode.value = brightness == Brightness.dark;
      // Obx will automatically rebuild when reactive variables change

      Get.snackbar(
        'System Theme',
        'Using system theme preference',
        snackPosition: SnackPosition.TOP,
        backgroundColor: isDarkMode.value ? Colors.grey[800] : Colors.white,
        colorText: isDarkMode.value ? Colors.white : Colors.black,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      print('Error setting system theme: $e');
    }
  }

  // Get current theme mode for UI
  String get currentThemeText {
    if (isSystemTheme.value) {
      return 'System';
    }
    return isDarkMode.value ? 'Dark' : 'Light';
  }

  // Get theme icon
  IconData get themeIcon {
    if (isSystemTheme.value) {
      return Icons.brightness_auto;
    }
    return isDarkMode.value ? Icons.dark_mode : Icons.light_mode;
  }
}
