import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../controllers/intruder_snap_controller.dart';
import '../controllers/theme_controller.dart';
import '../routes/app_routes.dart';

class IntruderSnapGalleryView extends StatelessWidget {
  const IntruderSnapGalleryView({super.key});

  void _handleBackNavigation() {
    print('Gallery back button pressed');
    // Navigate back to intruder snap view
    Get.offNamed(AppRoutes.intruderSnap);
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
                        'Intruder Snap',
                        style: GoogleFonts.poppins(
                          fontSize: 6.w,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const Spacer(),
                      PopupMenuButton<String>(
                        icon: Icon(
                          Icons.more_vert,
                          color: theme.colorScheme.onSurface,
                        ),
                        onSelected: (value) =>
                            controller.handleMenuAction(value),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 'disable',
                            child: Text(
                              'Disable Intruder',
                              style: GoogleFonts.poppins(
                                fontSize: 4.w,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            value: 'empty',
                            child: Text(
                              'Empty Snaps',
                              style: GoogleFonts.poppins(
                                fontSize: 4.w,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            value: 'setting',
                            child: Text(
                              'Setting',
                              style: GoogleFonts.poppins(
                                fontSize: 4.w,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Main Content - Gallery Grid
                Expanded(
                  child: Container(
                    color: theme.colorScheme.surface,
                    child: Padding(
                      padding: EdgeInsets.all(4.w),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 1.2,
                            ),
                        itemCount: 6, // Show 6 flower images as in the design
                        itemBuilder: (context, index) {
                          return _buildFlowerSnapCard(index);
                        },
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

  Widget _buildFlowerSnapCard(int index) {
    // Use different flower images for variety
    final flowerImages = [
      'assets/images/flower1.png',
      'assets/images/flower2.png',
      'assets/images/flower3.png',
      'assets/images/flower1.png',
      'assets/images/flower2.png',
      'assets/images/flower3.png',
    ];

    final timestamps = [
      '03:24 PM 5/4/25',
      '02:15 PM 5/4/25',
      '01:45 PM 5/4/25',
      '12:30 PM 5/4/25',
      '11:20 AM 5/4/25',
      '10:15 AM 5/4/25',
    ];

    return GestureDetector(
      onTap: () {
        // Navigate to detail view
        Get.toNamed(
          '/intruder-snap-detail',
          arguments: {
            'snap': {
              'image': flowerImages[index],
              'timestamp': timestamps[index],
            },
            'index': index,
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              // Flower Image
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(color: Colors.grey[300]),
                child: Image.asset(flowerImages[index], fit: BoxFit.cover),
              ),

              // Timestamp overlay
              Positioned(
                top: 6,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: Text(
                    timestamps[index],
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
