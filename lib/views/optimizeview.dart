import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:lottie/lottie.dart';

import '../controllers/optimizecontroller.dart';
import '../controllers/theme_controller.dart';

class OptimizeView extends StatelessWidget {
  const OptimizeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OptimizeController());
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
            child: Column(
              children: [
                SizedBox(height: 2.h),

                // Title
                Text(
                  "Optimize",
                  style: GoogleFonts.inter(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onBackground,
                  ),
                ),
                SizedBox(height: 3.h),

                // Junk Files Circular Progress
                _buildJunkFilesProgress(controller, theme),
                SizedBox(height: 2.h),

                // Navigation Dots
                _buildNavigationDots(),
                SizedBox(height: 2.h),

                // Clean up Button
                _buildCleanUpButton(controller, theme),
                SizedBox(height: 4.h),

                // Categories Grid
                _buildCategoriesGrid(controller, theme),
                SizedBox(height: 8.h), // Space for floating nav
              ],
            ),
          ),
        ),
        floatingActionButton: _buildFloatingNavBar(controller, theme),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    });
  }

  Widget _buildJunkFilesProgress(
    OptimizeController controller,
    ThemeData theme,
  ) {
    return Center(
      child: SizedBox(
        width: 40.w,
        height: 40.w,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Content
            if (controller.isOptimizing.value &&
                !controller.showOptimizedImage.value)
              // Animation during optimization - splashloader animation
              Lottie.asset(
                'assets/animations/splashloader.json',
                width: 40.w,
                height: 40.w,
                repeat: true,
                animate: true,
                frameRate: FrameRate(60),
              )
            else if (controller.showOptimizedImage.value)
              // Optimized image after completion
              Image.asset(
                'assets/images/optimizedloader.png',
                width: 40.w,
                height: 40.w,
                fit: BoxFit.contain,
              )
            else
              // Default junk clean image with centered text
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/junkclean.png',
                    width: 40.w,
                    height: 40.w,
                    fit: BoxFit.contain,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.junkSize.value,
                        style: GoogleFonts.inter(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onBackground,
                        ),
                      ),
                      Text(
                        "Junk Files",
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDot(true),
        SizedBox(width: 1.w),
        _buildDot(false),
      ],
    );
  }

  Widget _buildDot(bool isActive) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF02A4FF) : const Color(0xFFE0E0E0),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildCleanUpButton(OptimizeController controller, ThemeData theme) {
    return Container(
      width: 60.w,
      height: 6.h,
      child: ElevatedButton(
        onPressed: controller.isOptimizing.value
            ? null
            : () => controller.optimizeStorage(),
        style: ElevatedButton.styleFrom(
          backgroundColor: controller.isOptimizing.value
              ? theme.colorScheme.outline
              : const Color(0xFF02A4FF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 0,
        ),
        child: Text(
          "Clean up",
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesGrid(OptimizeController controller, ThemeData theme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 3.w,
          mainAxisSpacing: 3.w,
          childAspectRatio: 0.75,
        ),
        itemCount: controller.categories.length,
        itemBuilder: (context, index) {
          final category = controller.categories[index];
          return _buildCategoryCard(
            title: category["title"]!,
            subtitle: category["subtitle"]!,
            size: category["size"]!,
            image: category["image"]!,
            controller: controller,
            theme: theme,
          );
        },
      ),
    );
  }

  Widget _buildCategoryCard({
    required String title,
    required String subtitle,
    required String size,
    required String image,
    required OptimizeController controller,
    required ThemeData theme,
  }) {
    return GestureDetector(
      onTap: () => controller.cleanCategory({
        "title": title,
        "subtitle": subtitle,
        "size": size,
        "image": image,
      }),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Padding(
              padding: EdgeInsets.all(2.w),
              child: Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // Image
            Expanded(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 2.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(1.w),
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.w,
                      vertical: 1.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF02A4FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              subtitle,
                              style: GoogleFonts.inter(
                                fontSize: 10.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              size,
                              style: GoogleFonts.inter(
                                fontSize: 10.sp,
                                color: Colors.white70,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.w),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingNavBar(OptimizeController controller, ThemeData theme) {
    return Container(
      width: 70.w,
      height: 8.h,
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
            icon: 'assets/icons/home.png',
            index: 0,
            controller: controller,
            theme: theme,
          ),
          _buildNavItem(
            icon: 'assets/icons/feature.png',
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
    dynamic icon,
    required int index,
    required OptimizeController controller,
    required ThemeData theme,
  }) {
    final isSelected = controller.selectedTabIndex.value == index;

    return GestureDetector(
      onTap: () => controller.setSelectedTab(index),
      child: Container(
        width: 12.w,
        height: 12.w,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF02A4FF) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: icon is String
              ? Image.asset(
                  icon,
                  width: 6.w,
                  height: 6.w,
                  color: isSelected
                      ? Colors.white
                      : theme.colorScheme.onSurfaceVariant,
                )
              : Icon(
                  icon,
                  color: isSelected
                      ? Colors.white
                      : theme.colorScheme.onSurfaceVariant,
                  size: 6.w,
                ),
        ),
      ),
    );
  }
}
