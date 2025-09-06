import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../controllers/subscription_controller.dart';
import '../controllers/theme_controller.dart';

class Subscription extends StatelessWidget {
  const Subscription({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubscriptionController());
    final themeController = Get.find<ThemeController>();
    final theme = Theme.of(context);

    return Obx(() {
      // Listen to theme changes
      themeController.isDarkMode.value;
      themeController.isSystemTheme.value;

      return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              child: Column(
                children: [
                  Text(
                    "Clean Your Storage",
                    style: GoogleFonts.inter(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onBackground,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    "Get rid of what you do not need",
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 4.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildIcon("assets/images/photos.png", "Photos", theme),
                      _buildIcon("assets/images/icloud.jpg", "iCloud", theme),
                    ],
                  ),
                  SizedBox(height: 2.h),

                  // Storage Progress Card
                  Container(
                    width: 80.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: theme.dividerColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          width: 80.w * 0.75, // 75% progress
                          height: 5.h,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                theme.colorScheme.secondary.withOpacity(0.7),
                                theme.colorScheme.secondary,
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                  Text(
                    "7 of 128GB Used",
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onBackground,
                    ),
                  ),

                  SizedBox(height: 5.h),

                  // Cleanup Pro Container
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: theme.brightness == Brightness.light
                          ? const Color(0xFFE1E5EF)
                          : theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: theme.colorScheme.outline.withOpacity(0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Cleanup Pro",
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          "Smart Cleaning, video compressor, secret storage, manage contracts, no ads and limits",
                          style: GoogleFonts.inter(
                            fontSize: 11.sp,
                            color: theme.colorScheme.onSurfaceVariant,
                            height: 1.4,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Obx(
                          () => Text(
                            "Free for ${controller.trialDays.value} days, then Rs ${controller.pricePerWeek.value.toStringAsFixed(2)}/week",
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 1.h),

                  // Free trial toggle
                  Container(
                    decoration: BoxDecoration(
                      color: theme.brightness == Brightness.light
                          ? const Color(0xFFE1E5EF)
                          : theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: theme.colorScheme.outline.withOpacity(0.2),
                      ),
                    ),
                    child: Obx(
                      () => SwitchListTile(
                        value: controller.isTrialEnabled.value,
                        onChanged: controller.toggleTrial,
                        activeColor: theme.brightness == Brightness.light
                            ? const Color(0xFF4F83E9)
                            : theme.colorScheme.primary,
                        title: Text(
                          "Free trial enabled",
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 2.h),

                  // Price Info
                  Obx(
                    () => Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Due Today:",
                              style: GoogleFonts.inter(
                                fontSize: 13.sp,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            Text(
                              "Rs 0.0",
                              style: GoogleFonts.inter(
                                fontSize: 13.sp,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Then:",
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            Text(
                              "Rs ${controller.pricePerWeek.value.toStringAsFixed(2)}/week",
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 2.h),

                  // CTA button
                  SizedBox(
                    width: double.infinity,
                    height: 7.h,
                    child: ElevatedButton(
                      onPressed: controller.subscribe,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Get Started",
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 1.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.lock,
                        size: 5.w,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        "Secured with Apple",
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h), // Bottom padding for safety
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildIcon(String path, String label, ThemeData theme) {
    return Column(
      children: [
        Container(
          width: 25.w,
          height: 25.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.colorScheme.outline.withOpacity(0.2),
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: EdgeInsets.all(4.w),
          child: Image.asset(path, fit: BoxFit.contain),
        ),
        SizedBox(height: 1.h),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onBackground,
          ),
        ),
      ],
    );
  }
}
