import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../controllers/fingerprint_lock_controller.dart';

class FingerprintLockView extends StatelessWidget {
  const FingerprintLockView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FingerprintLockController());

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
                    iconSize: 7.w,
                  ),
                  Text(
                    'Application Lock',
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
            Spacer(),

              // Padlock Icon
              Image.asset(
                'assets/icons/lock.png',
                width: 100,
                height: 100,
                color: Colors.white,
              ),

            Spacer(),

              // Instruction Text
              Text(
                'Register finger print',
                style: GoogleFonts.poppins(
                  fontSize: 5.w,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              // Large Fingerprint Icon
              Image.asset(
                'assets/icons/thumb.png',
                width: 100,
                height: 100,
                color: Colors.white,
              ),

              SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }
}
