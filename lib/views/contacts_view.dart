import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../routes/app_routes.dart';

class ContactsView extends StatelessWidget {
  const ContactsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFF02A4FF,
      ), // Blue background as shown in design
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
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    iconSize: 7.w,
                  ),
                  Text(
                    'Contacts',
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
                    // Contact Person PNG Image
                    Container(
                      width: 60.w,
                      height: 40.h,
                      child: Image.asset(
                        'assets/images/contactperson.png',
                        fit: BoxFit.contain,
                      ),
                    ),


                    // Title
                    Text(
                      'Need Access to Start Scanning',
                      style: GoogleFonts.poppins(
                        fontSize: 6.w,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),


                    // Description
                    Text(
                      'Lorem ipsum is a dummy or placeholder text commonly used in graphic design.',
                      style: GoogleFonts.poppins(
                        fontSize: 4.w,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 4.h),

                    // Go to Settings Button
                    GestureDetector(
                      onTap: () {
                        // Navigate to contact scanning screen
                        Get.toNamed(AppRoutes.contactScanning);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 2.5.h),
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
                          'Go to Settings',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 5.w,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Banner Ad Section
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
    );
  }
}
