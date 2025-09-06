import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../controllers/welcome_controller.dart';
import '../controllers/theme_controller.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WelcomeController());
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 6.h),

                /// ✅ Title
                Text(
                  "Welcome to\nCleanup",
                  style: GoogleFonts.inter(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                    color: theme.colorScheme.onBackground,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 6.h),

                /// ✅ Icons Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildIcon("assets/images/photos.png", "Photos", theme),
                    _buildIcon("assets/images/icloud.jpg", "iCloud", theme),
                  ],
                ),

                SizedBox(height: 6.h),

                /// ✅ Storage Progress
                Column(
                  children: [
                    Container(
                      width: 80.w,
                      height: 5.h,
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
                  ],
                ),

                SizedBox(height: 5.h),

                /// ✅ Terms + Privacy
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: GoogleFonts.inter(
                        fontSize: 12.sp, // font increased
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                        height: 1.6,
                      ),
                      children: [
                        TextSpan(
                          text:
                              "Cleanup needs access to your Photos to free up storage. ",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const TextSpan(
                          text:
                              "We intend to provide transparency and protect your privacy. By starting you accept our ",
                        ),
                        TextSpan(
                          text: "Terms of Use",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            decorationColor:
                                Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),

                        const TextSpan(text: " and "),
                        TextSpan(
                          text: "Privacy Policy",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            decorationColor:
                                Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        const TextSpan(text: "."),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 7.h),

                /// ✅ Get Started Button
                Container(
                  width: double.infinity,
                  height: 7.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: theme.colorScheme.primary,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      elevation: 0,
                    ),
                    onPressed: controller.navigateToNextScreen,
                    child: Text(
                      "Get Started",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
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

  /// ✅ Icon Builder
  Widget _buildIcon(String path, String label, ThemeData theme) {
    return Column(
      children: [
        Container(
          width: 25.w, // ~100px
          height: 25.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.w),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withOpacity(0.08),
                blurRadius: 3.w,
                offset: Offset(0, 1.w),
              ),
            ],
          ),
          padding: EdgeInsets.all(5.w),
          child: Image.asset(path, fit: BoxFit.contain),
        ),
        SizedBox(height: 1.5.h),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: theme.colorScheme.onBackground,
          ),
        ),
      ],
    );
  }
}
