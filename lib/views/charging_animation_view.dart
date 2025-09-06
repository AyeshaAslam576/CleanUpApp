import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../controllers/charging_animation_controller.dart';
import '../controllers/theme_controller.dart';
import '../routes/app_routes.dart';

class ChargingAnimationView extends StatelessWidget {
  const ChargingAnimationView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChargingAnimationController());
    final themeController = Get.find<ThemeController>();
    final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () async {
        Get.offNamed(AppRoutes.features);
        return false;
      },
      child: Obx(() {
        // Listen to theme changes
        themeController.isDarkMode.value;
        themeController.isSystemTheme.value;

        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              'Charging Animation',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onBackground,
              ),
            ),
            leading: IconButton(
              onPressed: () => Get.offNamed(AppRoutes.features),
              icon: Icon(
                Icons.arrow_back,
                color: theme.colorScheme.onBackground,
                size: 24,
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2.h),
                  // Animation grid
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 3.w,
                      mainAxisSpacing: 3.w,
                      childAspectRatio: 0.75,
                      children: [
                        _buildEnergyFlowCard(controller),
                        _buildCosmicEarthCard(controller),
                        _buildLightBulbCard(controller),
                        _buildCircuitryCard(controller),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildEnergyFlowCard(ChargingAnimationController controller) {
    return GestureDetector(
      onTap: () => controller.selectAnimation('Energy Flow'),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: const DecorationImage(
            image: AssetImage('assets/images/charging1.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildCosmicEarthCard(ChargingAnimationController controller) {
    return GestureDetector(
      onTap: () => controller.selectAnimation('Cosmic Earth'),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: const DecorationImage(
            image: AssetImage('assets/images/charging2.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildLightBulbCard(ChargingAnimationController controller) {
    return GestureDetector(
      onTap: () => controller.selectAnimation('Light Bulb'),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: const DecorationImage(
            image: AssetImage('assets/images/charging3.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildCircuitryCard(ChargingAnimationController controller) {
    return GestureDetector(
      onTap: () => controller.selectAnimation('Circuitry Power'),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: const DecorationImage(
            image: AssetImage('assets/images/charging4.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
