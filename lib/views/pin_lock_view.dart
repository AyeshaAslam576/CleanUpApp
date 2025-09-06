import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../controllers/pin_controller.dart';

class PinLockView extends StatelessWidget {
  const PinLockView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PinController());

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
                      'Draw Your Pin',
                      style: GoogleFonts.poppins(
                        fontSize: 5.w,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 2.h),

                    // PIN Dots
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(4, (index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 1.5.w),
                            width: 4.w,
                            height: 4.w,
                            decoration: BoxDecoration(
                              color: index < controller.enteredPin.length
                                  ? Colors.white
                                  : Colors.transparent,
                              border: Border.all(
                                color: Colors.white,
                                width: 1.5,
                              ),
                              shape: BoxShape.circle,
                            ),
                          );
                        }),
                      ),
                    ),

                    SizedBox(height: 6.h),

                    // Numeric Keypad
                    Expanded(
                      child: Column(
                        children: [
                          // Row 1-3
                          for (int row = 0; row < 3; row++)
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 1.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  for (int col = 1; col <= 3; col++)
                                    _buildNumberButton(
                                      number: row * 3 + col,
                                      onPressed: () => controller.addDigit(
                                        (row * 3 + col).toString(),
                                      ),
                                    ),
                                ],
                              ),
                            ),

                          // Row 0
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 1.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(width: 20.w), // Empty space
                                _buildNumberButton(
                                  number: 0,
                                  onPressed: () => controller.addDigit('0'),
                                ),
                                _buildBackspaceButton(
                                  onPressed: controller.deletePin,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 2.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberButton({
    required int number,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 18.w,
        height: 18.w,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            number.toString(),
            style: GoogleFonts.poppins(
              fontSize: 7.w,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackspaceButton({required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 18.w,
        height: 18.w,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.backspace, color: Colors.white, size: 20),
      ),
    );
  }
}
