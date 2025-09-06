import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../controllers/settings_controller.dart';
import '../controllers/theme_controller.dart';
import '../routes/app_routes.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.put(SettingsController());
    final themeController = Get.find<ThemeController>();
    final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () async {
        Get.offNamed(AppRoutes.features);
        return false;
      },
      child: Obx(() {
        // Listen to theme changes
        themeController.isDarkMode.value;
        themeController.isSystemTheme.value;

        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              'Setting',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onBackground,
              ),
            ),
            leading: IconButton(
              onPressed: () => Get.offNamed(AppRoutes.features),
              icon: Icon(
                Icons.arrow_back,
                color: theme.colorScheme.onBackground,
                size: 24,
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Premium Banner
                  _buildPremiumBanner(theme),

                  const SizedBox(height: 30),

                  // For Developer Section
                  _buildSectionHeader('For Developer', theme),
                  const SizedBox(height: 16),
                  _buildSettingOption(
                    icon: Icons.stars,
                    title: 'More Apps From Us',
                    onTap: () => _showComingSoon('More Apps'),
                    theme: theme,
                  ),

                  const SizedBox(height: 30),

                  // Email & Account Section
                  _buildSectionHeader('Email & Account', theme),
                  const SizedBox(height: 16),
                  _buildSettingOption(
                    icon: Icons.login,
                    title: 'Sign In',
                    onTap: () => _showComingSoon('Sign In'),
                    theme: theme,
                  ),

                  const SizedBox(height: 30),

                  // Utilities Section
                  _buildSectionHeader('Utilities', theme),
                  const SizedBox(height: 16),
                  _buildSettingOption(
                    icon: Icons.widgets,
                    title: 'Widgets and Tips',
                    onTap: () => _showComingSoon('Widgets and Tips'),
                    theme: theme,
                  ),

                  const SizedBox(height: 30),

                  // Theme Section
                  _buildSectionHeader('Theme', theme),
                  const SizedBox(height: 16),
                  _buildToggleOption(
                    icon: Icons.dark_mode,
                    title: 'Dark Mode',
                    value: themeController.isDarkMode.value,
                    onChanged: (value) => themeController.setTheme(value),
                    theme: theme,
                  ),

                  const SizedBox(height: 30),

                  // Security Section
                  _buildSectionHeader('Security', theme),
                  const SizedBox(height: 16),
                  _buildToggleOption(
                    icon: Icons.lock,
                    title: 'Use Pin',
                    value: true, // Default to enabled
                    onChanged: (value) => _showComingSoon('Use Pin'),
                    theme: theme,
                  ),
                  const SizedBox(height: 12),
                  _buildToggleOption(
                    icon: Icons.delete,
                    title: 'Remove After Import',
                    value: false, // Default to disabled
                    onChanged: (value) =>
                        _showComingSoon('Remove After Import'),
                    theme: theme,
                  ),

                  const SizedBox(height: 30),

                  // Support Section
                  _buildSectionHeader('Support', theme),
                  const SizedBox(height: 16),
                  _buildSettingOption(
                    icon: Icons.privacy_tip,
                    title: 'Privacy Policy',
                    onTap: () => _showPrivacyPolicy(),
                    theme: theme,
                  ),
                  const SizedBox(height: 12),
                  _buildSettingOption(
                    icon: Icons.help,
                    title: 'FAQs',
                    onTap: () => _showComingSoon('FAQs'),
                    theme: theme,
                  ),
                  const SizedBox(height: 12),
                  _buildSettingOption(
                    icon: Icons.headset_mic,
                    title: 'Contact',
                    onTap: () => _showComingSoon('Contact'),
                    theme: theme,
                  ),

                  const SizedBox(height: 20),

                  // Additional Options
                  _buildSettingOption(
                    icon: Icons.star,
                    title: 'Rate the App',
                    onTap: () => _showComingSoon('Rate the App'),
                    theme: theme,
                  ),
                  const SizedBox(height: 12),
                  _buildSettingOption(
                    icon: Icons.share,
                    title: 'Share',
                    onTap: () => _showComingSoon('Share'),
                    theme: theme,
                  ),
                  const SizedBox(height: 12),
                  _buildSettingOption(
                    icon: Icons.camera_alt,
                    title: 'Follow on Instagram',
                    onTap: () => _showComingSoon('Follow on Instagram'),
                    theme: theme,
                  ),

                  const SizedBox(height: 100), // Space for bottom navigation
                ],
              ),
            ),
          ),
          bottomNavigationBar: _buildBottomNavigationBar(
            settingsController,
            theme,
          ),
        );
      }),
    );
  }

  Widget _buildPremiumBanner(ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFC72D), Color(0xFFFFC72D33)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Unlock Unlimited Access',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enjoy unlimited access with all clean features',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFC107),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Add More',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Robot image
          Container(
            width: 80,
            height: 80,
            child: Image.asset('assets/images/robot.png', fit: BoxFit.contain),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, ThemeData theme) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: theme.colorScheme.onSurface,
      ),
    );
  }

  Widget _buildSettingOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required ThemeData theme,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: theme.colorScheme.onSurface.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleOption({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    required ThemeData theme,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: theme.colorScheme.primary,
            inactiveThumbColor: Colors.grey[400],
            inactiveTrackColor: Colors.grey[300],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(
    SettingsController controller,
    ThemeData theme,
  ) {
    return Container(
      height: 8.h,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(0.7),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(
            icon: Icons.home,
            index: 0,
            controller: controller,
            theme: theme,
          ),
          _buildNavItem(
            icon: Icons.grid_view,
            index: 1,
            controller: controller,
            theme: theme,
          ),
          _buildNavItem(
            icon: Icons.settings,
            index: 2,
            controller: controller,
            theme: theme,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required int index,
    required SettingsController controller,
    required ThemeData theme,
  }) {
    return Obx(() {
      final isSelected = controller.selectedTabIndex.value == index;

      return GestureDetector(
        onTap: () => controller.setSelectedTab(index),
        child: Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            color: isSelected ? theme.colorScheme.primary : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              icon,
              color: isSelected
                  ? Colors.white
                  : theme.colorScheme.onSurface.withOpacity(0.7),
              size: 6.w,
            ),
          ),
        ),
      );
    });
  }

  void _showComingSoon(String feature) {
    Get.snackbar(
      'Coming Soon',
      '$feature feature will be available soon!',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  void _showPrivacyPolicy() {
    Get.dialog(
      AlertDialog(
        title: Text(
          'Privacy Policy',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        content: Text(
          'Your privacy is important to us. This app collects minimal data necessary for functionality and does not share personal information with third parties.',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Close',
              style: GoogleFonts.poppins(
                color: Theme.of(Get.context!).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
