import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:pattern_lock/pattern_lock.dart';
import '../controllers/pattern_controller.dart';

class PatternLockView extends StatelessWidget {
  const PatternLockView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PatternController());

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
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  children: [
                    SizedBox(height: 8.h),

                    // Padlock Icon
                    Image.asset(
                      'assets/icons/lock.png',
                      width: 40,
                      height: 40,
                      color: Colors.white,
                    ),

                    SizedBox(height: 4.h),

                    // Instruction Text
                    Text(
                      'Draw Your Pattern Again',
                      style: GoogleFonts.poppins(
                        fontSize: 5.w,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 8.h),

                    // Pattern Lock Grid
                    Center(
                      child: Container(
                        width: 70.w,
                        height: 70.w,
                        child: PatternLock(
                          selectedColor: Colors.white,
                          notSelectedColor: Colors.white,
                          pointRadius: 8,
                          onInputComplete: (List<int> input) {
                            print('Pattern input: $input');
                            // For setup mode, save the pattern
                            controller.setInitialPattern(input);
                          },
                        ),
                      ),
                    ),

                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
