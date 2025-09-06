import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../routes/app_routes.dart';

class IntruderSnapNoSnapsView extends StatelessWidget {
  const IntruderSnapNoSnapsView({super.key});

  void _handleBackNavigation() {
    print('Back button pressed - Current route: ${Get.currentRoute}');
    // Navigate back to intruder snap view
    Get.offNamed(AppRoutes.intruderSnap);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = Get.isDarkMode;

    return WillPopScope(
      onWillPop: () async {
        print('Device back button pressed');
        _handleBackNavigation();
        return false; // Prevent default back behavior since we handle it manually
      },
      child: Scaffold(
        backgroundColor: isDarkMode ? theme.colorScheme.surface : Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: _handleBackNavigation,
                      icon: Icon(
                        Icons.arrow_back,
                        color: isDarkMode
                            ? theme.colorScheme.onSurface
                            : Colors.black,
                      ),
                      iconSize: 7.w,
                    ),
                    Text(
                      'Intruder Snap',
                      style: GoogleFonts.poppins(
                        fontSize: 6.w,
                        fontWeight: FontWeight.w600,
                        color: isDarkMode
                            ? theme.colorScheme.onSurface
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              // Main Content - Centered
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Main Title
                        Text(
                          'No Intruder Snaps Found',
                          style: GoogleFonts.poppins(
                            fontSize: 6.w,
                            fontWeight: FontWeight.w600,
                            color: isDarkMode
                                ? theme.colorScheme.onSurface
                                : Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 2.h),

                        // Reassuring Message
                        Text(
                          'Your phone is secure, no intruders snaps found',
                          style: GoogleFonts.poppins(
                            fontSize: 4.w,
                            fontWeight: FontWeight.w400,
                            color: isDarkMode
                                ? theme.colorScheme.onSurface.withOpacity(0.7)
                                : Colors.black.withOpacity(0.6),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Bottom Ad Banner
              Container(
                width: double.infinity,
                height: 12.h,

                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/images/Adbanner.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    // Close button
                    Positioned(
                      top: 1.h,
                      right: 2.w,
                      child: GestureDetector(
                        onTap: () {
                          // Handle close banner ad
                          print('Close banner ad');
                        },
                        child: Container(
                          width: 6.w,
                          height: 6.w,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 4.w,
                          ),
                        ),
                      ),
                    ),
                    // Banner text
                    Center(
                      child: Text(
                        'Banner Ad Display',
                        style: GoogleFonts.poppins(
                          fontSize: 4.w,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
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
  }
}
