import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../controllers/free_trial_controller.dart';
import '../controllers/theme_controller.dart';

class FreeTrialView extends StatelessWidget {
  const FreeTrialView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FreeTrialController());
    final themeController = Get.find<ThemeController>();
    final theme = Theme.of(context);

    return Obx(() {
      // Listen to theme changes
      themeController.isDarkMode.value;
      themeController.isSystemTheme.value;

      return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 🔥 Stretch Switch width only
                Obx(
                  () => Switch(
                    value: controller.isEnabled.value,
                    activeColor: theme.colorScheme.primary,
                    inactiveThumbColor: theme.colorScheme.surface,
                    inactiveTrackColor: theme.colorScheme.outline,
                    onChanged: controller.toggleTrial,
                  ),
                ),

                SizedBox(height: 3.h),

                // Texts
                Obx(
                  () => Column(
                    children: [
                      Text(
                        "7-days free trail",
                        style: GoogleFonts.inter(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        controller.isEnabled.value
                            ? "is enabled"
                            : "is disabled",
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.onBackground,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 4.h),
              ],
            ),
          ),
        ),
      );
    });
  }
}
