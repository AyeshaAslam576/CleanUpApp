import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../controllers/duplicate_photos_controller.dart';
import '../controllers/theme_controller.dart';

class DuplicatePhotosView extends StatelessWidget {
  const DuplicatePhotosView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DuplicatePhotosController());
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

                // ✅ Stepper Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStepCircle(context, isActive: true),
                    _buildStepCircle(context, isActive: false),
                    _buildStepCircle(context, isActive: false),
                  ],
                ),

                SizedBox(height: 5.h),

                // ✅ Title
                Text(
                  "Delete Duplicate Photos",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onBackground,
                  ),
                ),

                SizedBox(height: 2.h),

                // ✅ Subtitle
                Text(
                  "Eliminate duplicate photos instantly and reclaim your storage!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),

                SizedBox(height: 2.h),

                // ✅ Photos Grid
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: GridView.builder(
                      itemCount: controller.photos.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing:
                            0.w, // minimal spacing between columns
                        mainAxisSpacing: 2.w, // minimal spacing between rows
                        childAspectRatio:
                            1.5, // square aspect ratio like in first screenshot
                      ),
                      itemBuilder: (context, index) {
                        final photo = controller.photos[index];

                        return Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: theme.colorScheme.surface,
                                border: Border.all(
                                  color: theme.colorScheme.outline.withOpacity(
                                    0.2,
                                  ),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(photo, fit: BoxFit.cover),
                              ),
                            ),
                            Obx(() {
                              final isSelected =
                                  controller.selected[index] ?? false;
                              return GestureDetector(
                                onTap: () => controller.toggleSelection(index),
                                child: Container(
                                  margin: EdgeInsets.all(2.w),
                                  width: 7.w,
                                  height: 7.w,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? theme.colorScheme.error
                                        : theme.colorScheme.surface,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: isSelected
                                          ? theme.colorScheme.error
                                          : theme.colorScheme.outline,
                                      width: 1,
                                    ),
                                  ),
                                  child: Icon(
                                    isSelected ? Icons.close : Icons.check,
                                    color: isSelected
                                        ? Colors.white
                                        : theme.colorScheme.onSurfaceVariant,
                                    size: 4.w,
                                  ),
                                ),
                              );
                            }),
                          ],
                        );
                      },
                    ),
                  ),
                ),

                // ✅ Bottom Button + Links
                SizedBox(height: 2.h),
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

                // ✅ Terms + Privacy
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

  // ✅ Reusable Step Circle Widget
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
}
