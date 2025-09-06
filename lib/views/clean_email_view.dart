import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../controllers/clean_email_controller.dart';
import '../controllers/theme_controller.dart';

class CleanEmailView extends StatelessWidget {
  const CleanEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CleanEmailController());
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
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 4.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStepCircle(context, isActive: true),
                    _buildStepCircle(context, isActive: true),
                    _buildStepCircle(context, isActive: true),
                  ],
                ),
                SizedBox(height: 5.h),

                // Title
                Text(
                  "Clean your Email\ninbox",
                  style: GoogleFonts.inter(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onBackground,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 1.h),

                // Subtitle
                Text(
                  "Delete spam and promotional emails\nwith just one tap.",
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 5.h),

                // Mail Icon with badge
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      height: 15.h,
                      width: 15.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Image.asset(
                        "assets/images/mail.png",
                        height: 10.h,
                        width: 11.h,
                      ),
                    ),
                    Positioned(
                      top: 0.h,
                      right: 0.w,
                      child: Obx(
                        () => Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                            vertical: 0.5.h,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.error,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "${controller.spamEmails.value}",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 5.h),

                // Progress Bar
                Obx(
                  () => ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: 2.h,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Container(
                            color: theme.colorScheme.outline.withOpacity(0.3),
                          ),
                          FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: controller.spamPercentage.value,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  colors: [
                                    theme.colorScheme.secondary.withOpacity(
                                      0.7,
                                    ),
                                    theme.colorScheme.secondary,
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  child: SizedBox(
                    width: double.infinity,
                    height: 7.h,
                    child: ElevatedButton(
                      onPressed: controller.navigateToNext,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Next",
                        style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                // Terms text
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(
                        text: "Terms of Use",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onBackground,
                          decorationColor: theme.brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      const TextSpan(text: " and "),
                      TextSpan(
                        text: "Privacy Policy",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onBackground,
                          decorationColor: theme.brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
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
}
