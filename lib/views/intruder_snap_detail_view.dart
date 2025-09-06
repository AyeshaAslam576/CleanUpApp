import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/intruder_snap_controller.dart';
import '../controllers/theme_controller.dart';

class IntruderSnapDetailView extends StatefulWidget {
  const IntruderSnapDetailView({super.key});

  @override
  State<IntruderSnapDetailView> createState() => _IntruderSnapDetailViewState();
}

class _IntruderSnapDetailViewState extends State<IntruderSnapDetailView> {
  bool _showOverlay = true;

  void _handleBackNavigation() {
    print('Detail view back button pressed');
    // Navigate back to gallery view
    Get.back();
  }

  void _toggleOverlay() {
    setState(() {
      _showOverlay = !_showOverlay;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(IntruderSnapController());
    final themeController = Get.find<ThemeController>();
    final theme = Theme.of(context);
    final arguments = Get.arguments as Map<String, dynamic>?;
    final snap = arguments?['snap'] ?? {};

    return WillPopScope(
      onWillPop: () async {
        _handleBackNavigation();
        return false; // Prevent default back behavior since we handle it manually
      },
      child: Obx(() {
        // Listen to theme changes
        themeController.isDarkMode.value;
        themeController.isSystemTheme.value;

        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor:     theme.scaffoldBackgroundColor,

            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface,),
              onPressed: _handleBackNavigation,
            ),
            title: Text(

              'Intruder Snap',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          body: Stack(
            children: [
              // Main content with thumbnails at bottom
              Column(
                children: [
                  // Main content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildMainImageCard(controller, snap, theme),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),

                  // Thumbnails section at bottom
                  _buildThumbnailsSection(controller, theme),
                ],
              ),

              // User guide overlay for first-time users
              Obx(
                () => controller.showUserGuide.value
                    ? _buildUserGuideOverlay(controller, theme)
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildMainImageCard(
    IntruderSnapController controller,
    Map<String, dynamic> snap,
    ThemeData theme,
  ) {
    return GestureDetector(
      onTap: _toggleOverlay,
      onPanUpdate: (details) {
        if (_showOverlay) {
          if (details.delta.dx.abs() > details.delta.dy.abs()) {
            // Horizontal swipe
            _handleHorizontalSwipe(details.delta.dx);
          } else {
            // Vertical swipe
            _handleVerticalSwipe(details.delta.dy);
          }
        }
      },
      child: Container(
        width: double.infinity,
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Main image with maximum quality
              Positioned.fill(
                child: Image.asset(
                  snap['image'] ?? 'assets/images/flower1.png',
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.none,
                  cacheWidth: 800,
                  cacheHeight: 600,
                ),
              ),

              // Overlay when in overview mode
              if (_showOverlay)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.black.withOpacity(0.6),
                  ),
                  child: Stack(
                    children: [
                      // Cancel action (left)
                      Positioned(
                        left: 40,
                        top: 0,
                        bottom: 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.refresh,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Delete action (right)
                      Positioned(
                        right: 40,
                        top: 0,
                        bottom: 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.refresh,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Delete',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Close overview (bottom center)
                      Positioned(
                        bottom: 20,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Close Overview',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              // File info at bottom
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      snap['timestamp'] ?? 'Unknown Time',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Intruder Photo',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThumbnailsSection(
    IntruderSnapController controller,
    ThemeData theme,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Similar Intruder Photos',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 16),
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: theme.shadowColor.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      _getThumbnailImage(index),
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.none,
                      cacheWidth: 200,
                      cacheHeight: 200,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserGuideOverlay(
    IntruderSnapController controller,
    ThemeData theme,
  ) {
    return Container(
      color: Colors.black.withOpacity(0.8),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Spacer(),

              // Guide content
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.gesture,
                      size: 48,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Welcome to Intruder Snap Management!',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Swipe left to cancel, right to delete, down to close overview',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),

                    // Navigation buttons
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              controller.showUserGuide.value = false;
                            },
                            child: Text(
                              'Skip',
                              style: GoogleFonts.poppins(
                                color: theme.colorScheme.onSurface.withOpacity(
                                  0.7,
                                ),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              controller.showUserGuide.value = false;
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Got it!',
                              style: GoogleFonts.poppins(
                                color: theme.colorScheme.onPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  void _handleHorizontalSwipe(double dx) {
    if (dx > 50) {
      // Swipe right - delete
      _showActionFeedback('Delete selected');
    } else if (dx < -50) {
      // Swipe left - cancel
      _showActionFeedback('Cancel selected');
    }
  }

  void _handleVerticalSwipe(double dy) {
    if (dy > 50) {
      // Swipe down - close overview
      _toggleOverlay();
    }
  }

  void _showActionFeedback(String message) {
    Get.snackbar(
      'Action',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Get.find<ThemeController>().isDarkMode.value
          ? Colors.grey[800]!
          : const Color(0xFF02A4FF),
      colorText: Colors.white,
      duration: const Duration(seconds: 1),
    );
  }

  String _getThumbnailImage(int index) {
    final flowerImages = [
      'assets/images/flower1.png',
      'assets/images/flower2.png',
      'assets/images/flower3.png',
    ];
    return flowerImages[index % flowerImages.length];
  }
}
