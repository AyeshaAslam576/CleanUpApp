import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../controllers/feature_controller.dart';
import '../controllers/theme_controller.dart';

class FeatureView extends StatelessWidget {
  const FeatureView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FeatureController());
    final themeController = Get.find<ThemeController>();
    final theme = Theme.of(context);

    return Obx(() {
      // Listen to theme changes
      themeController.isDarkMode.value;
      themeController.isSystemTheme.value;

      return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCoreFeaturesGrid(controller),
                    const SizedBox(height: 20),
                    _buildBannerAd(controller),
                    const SizedBox(height: 10),
                    _buildTopFeaturesSection(controller, context),
                    const SizedBox(height: 100), // Space for floating nav bar
                  ],
                ),
              ),
              // Floating Navigation Bar
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Center(child: _buildFloatingNavBar(controller, theme)),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildCoreFeaturesGrid(FeatureController controller) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: controller.coreFeatures.length,
      itemBuilder: (context, index) {
        final feature = controller.coreFeatures[index];
        return _buildFeatureCard(
          icon: feature['icon'] as IconData,
          title: feature['title'] as String,
          color: feature['color'] as Color,
          onTap: () => controller.onFeatureTap(feature['route'] as String),
          context: context,
        );
      },
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15, top: 8),
              child: Icon(icon, color: color, size: 24),
            ),

            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              child: Text(
                title,
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerAd(FeatureController controller) {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage('assets/images/Adbanner.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 12,
            right: 12,
            child: GestureDetector(
              onTap: controller.closeBannerAd,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopFeaturesSection(
    FeatureController controller,
    BuildContext context,
  ) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Top Features',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onBackground,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.topFeatures.length,
            itemBuilder: (context, index) {
              final feature = controller.topFeatures[index];
              return Container(
                width: 120,
                margin: EdgeInsets.only(
                  right: index < controller.topFeatures.length - 1 ? 16 : 0,
                ),
                child: _buildTopFeatureCard(
                  imagePath: feature['imagePath'] as String,
                  title: feature['title'] as String,
                  color: feature['color'] as Color,
                  onTap: () =>
                      controller.onFeatureTap(feature['route'] as String),
                  context: context,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTopFeatureCard({
    required String imagePath,
    required String title,
    required Color color,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 120,
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingNavBar(FeatureController controller, ThemeData theme) {
    return Container(
      width: 70.w,
      height: 8.h,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(0.7),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(
            icon: 'assets/icons/home.png',
            index: 0,
            controller: controller,
            theme: theme,
          ),
          _buildNavItem(
            icon: 'assets/icons/feature.png',
            index: 1,
            controller: controller,
            theme: theme,
          ),
          _buildNavItem(
            icon: Icons.settings,
            index: 2,
            controller: controller,
            theme: theme,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    dynamic icon,
    required int index,
    required FeatureController controller,
    required ThemeData theme,
  }) {
    final isSelected = controller.selectedTabIndex.value == index;

    return GestureDetector(
      onTap: () => controller.setSelectedTab(index),
      child: Container(
        width: 12.w,
        height: 12.w,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF02A4FF) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: icon is String
              ? Image.asset(
                  icon,
                  width: 6.w,
                  height: 6.w,
                  color: isSelected
                      ? Colors.white
                      : theme.colorScheme.onSurfaceVariant,
                )
              : Icon(
                  icon,
                  color: isSelected
                      ? Colors.white
                      : theme.colorScheme.onSurfaceVariant,
                  size: 6.w,
                ),
        ),
      ),
    );
  }
}
