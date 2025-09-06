import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../controllers/app_lock_controller.dart';
import '../routes/app_routes.dart';
import '../services/route_tracker_service.dart';

class ChooseLockTypeView extends StatelessWidget {
  const ChooseLockTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppLockController());
    final routeTracker = RouteTrackerService.instance;

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
                    onPressed: controller.goBack,
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    iconSize: 7.w,
                  ),
                  Text(
                    routeTracker.isFromIntruderSnap
                        ? 'Lock Setup'
                        : 'Application Lock',
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
                    // Lock Type Options - Three cards as shown in design
                    _buildLockOption(
                      icon: Icons.fingerprint,
                      title: 'Fingerprint',
                      onTap: () => _handleLockTypeSelection('fingerprint'),
                    ),

                    SizedBox(height: 3.h),

                    _buildLockOption(
                      icon: Icons.lock,
                      title: 'PIN',
                      onTap: () => _handleLockTypeSelection('pin'),
                    ),

                    SizedBox(height: 3.h),

                    _buildLockOption(
                      icon: Icons.grid_view,
                      title: 'Pattern',
                      onTap: () => _handleLockTypeSelection('pattern'),
                    ),

                    SizedBox(height: 6.h),

                    // Bottom Text
                    Text(
                      'Choose Lock Type',
                      style: GoogleFonts.poppins(
                        fontSize: 5.w,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Banner Ad Section
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
        margin: EdgeInsets.symmetric(horizontal: 50),
        height: 12.h,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
        ),
        child: Center(
          child: Icon(icon, size: 12.w, color: Colors.white),
        ),
      ),
    );
  }

  void _handleLockTypeSelection(String lockType) {
    // Update the lock type in route tracker
    RouteTrackerService.instance.setRouteSource(
      source: RouteTrackerService.instance.currentSource,
      setupType: RouteTrackerService.instance.setupType,
      lockType: lockType,
    );

    // Navigate to the appropriate lock setup based on type
    switch (lockType) {
      case 'fingerprint':
        Get.toNamed(AppRoutes.fingerprintSetup);
        break;
      case 'pin':
        Get.toNamed(AppRoutes.pinSetupNew);
        break;
      case 'pattern':
        Get.toNamed(AppRoutes.patternSetupNew);
        break;
    }
  }
}
