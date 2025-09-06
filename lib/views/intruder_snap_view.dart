import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../routes/app_routes.dart';
import '../services/route_tracker_service.dart';

class IntruderSnapView extends StatelessWidget {
  const IntruderSnapView({super.key});

  void _handleBackNavigation() {
    Get.offNamed(AppRoutes.features);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _handleBackNavigation();
        return false; // Prevent default back behavior since we handle it manually
      },
      child: Scaffold(
        backgroundColor: const Color(
          0xFF02A4FF,
        ), // Blue background as shown in design
        body: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight:
                    MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    // Header
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                        vertical: 2.h,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: _handleBackNavigation,
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            iconSize: 7.w,
                          ),
                          Text(
                            'Intruder Snap',
                            style: GoogleFonts.poppins(
                              fontSize: 6.w,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Main Content
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Intruder PNG Image
                            Container(
                              width: 60.w,
                              height:
                                  35.h, // Reduced height to prevent overflow
                              child: Image.asset(
                                'assets/images/intruder.png',
                                fit: BoxFit.contain,
                              ),
                            ),

                            SizedBox(height: 3.h), // Reduced spacing
                            // Title
                            Text(
                              'Enable Intruder Snaps',
                              style: GoogleFonts.poppins(
                                fontSize: 6.w,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            SizedBox(height: 1.5.h), // Reduced spacing
                            // Description
                            Text(
                              'We will take snapshots of intruders when they access your device.',
                              style: GoogleFonts.poppins(
                                fontSize: 4.w,
                                color: Colors.white.withOpacity(0.9),
                              ),
                              textAlign: TextAlign.center,
                            ),

                            SizedBox(height: 3.h), // Reduced spacing
                            // Enable Intruder Snap Button
                            GestureDetector(
                              onTap: () {
                                // Set route source for intruder snap
                                RouteTrackerService.instance.setRouteSource(
                                  source: 'intruder_snap',
                                  setupType: 'intruder_snap',
                                );
                                // Navigate to lock setup (password setup)
                                Get.toNamed(AppRoutes.chooseLockType);
                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  vertical: 2.h,
                                ), // Reduced padding
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFF092737,
                                  ), // Dark blue color as specified
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'Enable Intruder Snap',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 5.w,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 2.h,
                            ), // Added spacing before banner
                          ],
                        ),
                      ),
                    ),

                    // Banner Ad Section
                    Container(
                      width: double.infinity,
                      height: 15.h, // Reduced height

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
          ),
        ),
      ),
    );
  }
}
