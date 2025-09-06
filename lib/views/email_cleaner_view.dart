import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../controllers/email_cleaner_controller.dart';
import '../routes/app_routes.dart';

class EmailCleanerView extends StatelessWidget {
  const EmailCleanerView({super.key});

  void _handleBackNavigation() {
    Get.offNamed(AppRoutes.features);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EmailCleanerController());

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
                            'Email Cleaner',
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
                            // Email Clean PNG Image
                            Container(
                              width: 60.w,
                              height: 35.h,
                              child: Image.asset(
                                'assets/images/emailclean.png',
                                fit: BoxFit.contain,
                              ),
                            ),

                            SizedBox(height: 3.h),

                            // Description Text
                            Text(
                              'Lorem ipsum is a dummy or placeholder text commonly used in graphic design, publishing, testing, and web development.',
                              style: GoogleFonts.poppins(
                                fontSize: 4.w,
                                color: Colors.white,
                                height: 1.4,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            SizedBox(height: 1.h),

                            // Privacy Policy Link
                            GestureDetector(
                              onTap: () => _showPrivacyPolicy(),
                              child: Text(
                                'Privacy Policies',
                                style: GoogleFonts.poppins(
                                  fontSize: 4.w,
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.white,
                                ),
                              ),
                            ),

                            SizedBox(height: 4.h),

                            // Sign in buttons
                            _buildSignInButtons(controller),

                            SizedBox(height: 2.h),
                          ],
                        ),
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

  Widget _buildSignInButtons(EmailCleanerController controller) {
    return Column(
      children: [
        // Apple ID button
        Container(
          width: double.infinity,
          height: 14.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
          ),
          child: TextButton(
            onPressed: controller.onAppleSignIn,
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/apple.png', width: 6.w, height: 6.w),
                SizedBox(width: 3.w),
                Text(
                  'Sign in to Apple ID',
                  style: GoogleFonts.poppins(
                    fontSize: 4.w,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 2.h),
        // Google button
        Container(
          width: double.infinity,
          height: 14.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
          ),
          child: TextButton(
            onPressed: controller.onGoogleSignIn,
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/google.png', width: 6.w, height: 6.w),
                SizedBox(width: 3.w),
                Text(
                  'Sign in to Google',
                  style: GoogleFonts.poppins(
                    fontSize: 4.w,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showPrivacyPolicy() {
    Get.dialog(
      AlertDialog(
        title: Text(
          'Privacy Policy',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        content: Text(
          'Your privacy is important to us. This app collects minimal data necessary for email cleaning functionality and does not share personal information with third parties.',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Close',
              style: GoogleFonts.poppins(color: const Color(0xFF02A4FF)),
            ),
          ),
        ],
      ),
    );
  }
}
