import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../controllers/app_lock_controller.dart';

class LockSetupView extends StatelessWidget {
  const LockSetupView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppLockController());

    return Scaffold(
      backgroundColor: const Color(0xFF02A4FF),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    iconSize: 8.w,
                  ),
                  Text(
                    'Lock Setup',
                    style: GoogleFonts.poppins(
                      fontSize: 7.w,
                      fontWeight: FontWeight.w700,
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
                  children: [
                    SizedBox(height: 8.h),

                    // Lock Type Options
                    _buildLockOption(
                      icon: Icons.fingerprint,
                      title: 'Fingerprint',
                      onTap: () => controller.selectLockType('fingerprint'),
                    ),

                    SizedBox(height: 4.h),

                    _buildLockOption(
                      icon: Icons.lock_outline,
                      title: 'PIN',
                      onTap: () => controller.selectLockType('pin'),
                    ),

                    SizedBox(height: 4.h),

                    _buildLockOption(
                      icon: Icons.grid_3x3,
                      title: 'Pattern',
                      onTap: () => controller.selectLockType('pattern'),
                    ),

                    const Spacer(),

                    // Bottom Text
                    Text(
                      'Choose Lock Type',
                      style: GoogleFonts.poppins(
                        fontSize: 5.5.w,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 4.h),
                  ],
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
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
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
                'Google Ad Display',
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
  }

  Widget _buildLockOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 18.h,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
        ),
        child: Row(
          children: [
            SizedBox(width: 8.w),
            Container(
              width: 18.w,
              height: 18.w,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 10.w),
            ),
            SizedBox(width: 5.w),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 6.w,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white.withOpacity(0.7),
              size: 7.w,
            ),
            SizedBox(width: 5.w),
          ],
        ),
      ),
    );
  }
}
