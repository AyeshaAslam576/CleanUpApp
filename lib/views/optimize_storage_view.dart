import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../controllers/optimize_storage_controller.dart';
import '../controllers/theme_controller.dart';

class OptimizeStorageView extends StatelessWidget {
  const OptimizeStorageView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OptimizeStorageController());
    final themeController = Get.find<ThemeController>();
    final theme = Theme.of(context);

    return Obx(() {
      // Listen to theme changes
      themeController.isDarkMode.value;
      themeController.isSystemTheme.value;

      return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Column(
              children: [
                SizedBox(height: 6.h),

                // Progress Stepper
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStepCircle(context, isActive: true),
                    _buildStepCircle(context, isActive: true),
                    _buildStepCircle(context, isActive: false),
                  ],
                ),

                SizedBox(height: 5.h),

                // Title
                Text(
                  "Optimize iPhone Storage",
                  style: GoogleFonts.inter(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onBackground,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 2.h),

                // Subtitle
                Text(
                  "Eliminate duplicate photos instantly and reclaim your storage!",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 5.h),

                // Icons Row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildIcon("assets/images/photos.png", "Photos", theme),
                      _buildIcon("assets/images/icloud.jpg", "iCloud", theme),
                    ],
                  ),
                ),

                SizedBox(height: 7.h),

                // Storage Info Card
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "iPhone",
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      "${controller.usedGB.value} of ${controller.totalGB.value}GB Used",
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                // Storage bar
                SizedBox(
                  height: 8.w,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Row(
                      children: [
                        Flexible(
                          flex: (controller.appsPercentage * 1000).toInt(),
                          child: Container(
                            height: 8.w,
                            color: const Color(0xFFE53935),
                          ), // Apps
                        ),
                        Flexible(
                          flex: (controller.osPercentage * 1000).toInt(),
                          child: Container(
                            height: 8.w,
                            color: const Color(0xFFFFA726),
                          ), // OS
                        ),
                        Flexible(
                          flex: (controller.mediaPercentage * 1000).toInt(),
                          child: Container(
                            height: 8.w,
                            color: const Color(0xFFFFCC03),
                          ), // Media
                        ),
                        Flexible(
                          flex: (controller.systemPercentage * 1000).toInt(),
                          child: Container(
                            height: 8.w,
                            color: const Color(0xFF2CCB55),
                          ), // System
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                // Storage Legend
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 3.w,
                  runSpacing: 1.h,
                  children: [
                    _buildLegendItem(context, const Color(0xFFE53935), "Apps"),
                    _buildLegendItem(context, const Color(0xFFFFA726), "OS"),
                    _buildLegendItem(context, const Color(0xFFFFCC03), "Media"),
                    _buildLegendItem(
                      context,
                      const Color(0xFF2CCB55),
                      "System data",
                    ),
                  ],
                ),

                Spacer(),

                // Next Button
                SizedBox(
                  width: double.infinity,
                  height: 7.h,
                  child: ElevatedButton(
                    onPressed: controller.navigateToNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      "Next",
                      style: GoogleFonts.inter(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 3.h),

                // Terms and Policy
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                      height: 1.6,
                    ),
                    children: [
                      TextSpan(
                        text: "Terms of Use",
                        style: TextStyle(
                          color: theme.colorScheme.onBackground,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          decorationColor: theme.brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      const TextSpan(text: " and "),
                      TextSpan(
                        text: "Privacy Policy",
                        style: TextStyle(
                          color: theme.colorScheme.onBackground,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          decorationColor: theme.brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      const TextSpan(text: "."),
                    ],
                  ),
                ),

                SizedBox(height: 2.h),
              ],
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
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: theme.colorScheme.outline.withOpacity(0.2),
            ),
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

  Widget _buildStepCircle(BuildContext context, {required bool isActive}) {
    final theme = Theme.of(context);
    return Container(
      width: 25.w,
      height: 1.5.w,
      decoration: BoxDecoration(
        color: isActive
            ? theme.colorScheme.primary
            : theme.colorScheme.outline.withOpacity(0.3),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  Widget _buildLegendItem(BuildContext context, Color color, String label) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 5.w,
          width: 5.w,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        SizedBox(width: 2.w),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 10.sp,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
