import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../controllers/intruder_snap_controller.dart';
import '../controllers/theme_controller.dart';

class IntruderSnapSettingsView extends StatelessWidget {
  const IntruderSnapSettingsView({super.key});

  void _handleBackNavigation() {
    print('Settings view back button pressed');
    // Navigate back to gallery view
    Get.offNamed('/intruder-snap-gallery');
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(IntruderSnapController());
    final themeController = Get.find<ThemeController>();
    final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () async {
        _handleBackNavigation();
        return false; // Prevent default back behavior since we handle it manually
      },
      child: Obx(() {
        // Listen to theme changes
        themeController.isDarkMode.value;
        themeController.isSystemTheme.value;

        return Scaffold(
          backgroundColor: theme.colorScheme.primary,
          body: SafeArea(
            child: Column(
              children: [
                // Header
                Container(
                  color: theme.colorScheme.surface,
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: _handleBackNavigation,
                        icon: Icon(
                          Icons.arrow_back,
                          color: theme.colorScheme.onSurface,
                        ),
                        iconSize: 7.w,
                      ),
                      Text(
                        'Intruder Snaps Setting',
                        style: GoogleFonts.poppins(
                          fontSize: 6.w,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),

                // Main Content
                Expanded(
                  child: Container(
                    color: theme.colorScheme.surface,
                    child: Padding(
                      padding: EdgeInsets.all(6.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 2.h),

                          // Heading
                          Text(
                            'Select Incorrect Entries',
                            style: GoogleFonts.poppins(
                              fontSize: 5.5.w,
                              fontWeight: FontWeight.w700,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),

                          SizedBox(height: 4.h),

                          // Options
                          _buildOption(
                            context: context,
                            title: 'Wrong Password 1 time',
                            isSelected:
                                controller.wrongPasswordAttempts.value == 1,
                            onTap: () => controller.setWrongPasswordAttempts(1),
                          ),

                          SizedBox(height: 2.h),

                          _buildOption(
                            context: context,
                            title: 'Wrong Password 2 time',
                            isSelected:
                                controller.wrongPasswordAttempts.value == 2,
                            onTap: () => controller.setWrongPasswordAttempts(2),
                          ),

                          SizedBox(height: 2.h),

                          _buildOption(
                            context: context,
                            title: 'Wrong Password 3 time',
                            isSelected:
                                controller.wrongPasswordAttempts.value == 3,
                            onTap: () => controller.setWrongPasswordAttempts(3),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Ad Banner
          bottomNavigationBar: Container(
            width: double.infinity,
            height: 15.h,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/Adbanner.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 2.h,
                  right: 3.w,
                  child: Text(
                    'Banner Ad Display',
                    style: GoogleFonts.poppins(
                      fontSize: 3.5.w,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildOption({
    required BuildContext context,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 4.5.w,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const Spacer(),
            Container(
              width: 6.w,
              height: 6.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.outline.withOpacity(0.3),
              ),
              child: isSelected
                  ? Icon(Icons.check, color: Colors.white, size: 4.w)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
