import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../controllers/protected_apps_controller.dart';

class ProtectedAppsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProtectedAppsController());

    return WillPopScope(
      onWillPop: () async {
        // Handle system back button - always go to features view
        Get.offNamed('/features');
        return false;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  // Header with back button
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 2.h,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            print("Back button pressed");
                            Get.offNamed('/features');
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          iconSize: 7.w,
                        ),
                        Text(
                          'Protected Apps',
                          style: GoogleFonts.poppins(
                            fontSize: 6.w,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(
                              context,
                            ).textTheme.headlineSmall?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Header banner with consistent color
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF07A6FF),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).shadowColor.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Protect your apps from Intruders',
                            style: GoogleFonts.poppins(
                              fontSize: 4.5.w,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Obx(
                          () => Text(
                            '${controller.protectedApps.length} Apps Protected',
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

                  SizedBox(height: 3.h),

                  // Apps list
                  Expanded(
                    child: Obx(() {
                      // Check if any apps are protected
                      if (controller.protectedApps.isNotEmpty) {
                        // Show protected and unprotected sections
                        return SingleChildScrollView(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Protected Apps Section
                              if (controller.protectedApps.isNotEmpty) ...[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Protected Apps",
                                      style: GoogleFonts.poppins(
                                        fontSize: 4.w,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge?.color,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        print("Add more apps tapped");
                                        controller.addMoreAppsToProtection();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 3.w,
                                          vertical: 1.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF07A6FF),
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                        child: Text(
                                          "Add More",
                                          style: GoogleFonts.poppins(
                                            fontSize: 3.w,
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context).cardColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 2.h),
                                ...controller.protectedApps.map(
                                  (app) => _buildProtectedAppListItem(
                                    app,
                                    controller,
                                    context,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                              ],

                              // Unprotected Apps Section
                              if (controller.unprotectedApps.isNotEmpty) ...[
                                Text(
                                  "Unprotected Apps",
                                  style: GoogleFonts.poppins(
                                    fontSize: 4.w,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge?.color,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                ...controller.unprotectedApps.map(
                                  (app) => _buildUnprotectedAppListItem(
                                    app,
                                    controller,
                                    context,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        );
                      } else {
                        // Show original selection list
                        return ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          itemCount: controller.apps.length,
                          itemBuilder: (ctx, index) {
                            final app = controller.apps[index];
                            return _buildAppListItem(app, controller, context);
                          },
                        );
                      }
                    }),
                  ),
                ],
              ),

              // Floating Navigation Bar - Only show when apps are selected
              Obx(() {
                if (controller.lockedApps.isNotEmpty) {
                  return Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: 50.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(
                                context,
                              ).shadowColor.withOpacity(0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildNavItem(
                              icon: Icons.close,
                              onTap: () => controller.clearAllSelections(),
                              context: context,
                            ),
                            _buildNavItem(
                              icon: Icons.lock,
                              onTap: () {
                                print("Lock icon tapped");
                                controller.showProtectionConfirmation();
                              },
                              context: context,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppListItem(
    AppModel app,
    ProtectedAppsController controller,
    BuildContext context,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 1.h),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Row(
        children: [
          // App icon with circular white background
          Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                app.iconPath,
                width: 12.w,
                height: 12.w,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  print("Image error for ${app.name}: $error");
                  print("Image path: ${app.iconPath}");
                  return Container(
                    color: Theme.of(context).disabledColor.withOpacity(0.3),
                    child: Center(
                      child: Text(
                        app.name.substring(0, 1).toUpperCase(),
                        style: TextStyle(
                          fontSize: 4.w,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          SizedBox(width: 4.w),

          // App name
          Expanded(
            child: Text(
              app.name,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 4.5.w,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          SizedBox(width: 2.w),

          // Selection indicator
          Obx(
            () => GestureDetector(
              onTap: () => controller.toggleApp(app),
              child: Container(
                width: 6.w,
                height: 6.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: app.isLocked.value
                      ? const Color(0xFF07A6FF)
                      : Colors.transparent,
                  border: Border.all(
                    color: app.isLocked.value
                        ? const Color(0xFF07A6FF)
                        : Theme.of(context).dividerColor,
                    width: 2,
                  ),
                ),
                child: app.isLocked.value
                    ? Icon(Icons.check, color: Colors.white, size: 3.w)
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 12.w,
        height: 12.w,
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Theme.of(context).iconTheme.color, size: 6.w),
      ),
    );
  }

  Widget _buildProtectedAppListItem(
    AppModel app,
    ProtectedAppsController controller,
    BuildContext context,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      child: Row(
        children: [
          // App icon with circular white background
          Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                app.iconPath,
                width: 12.w,
                height: 12.w,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  print("Image error for ${app.name}: $error");
                  print("Image path: ${app.iconPath}");
                  return Container(
                    color: Theme.of(context).disabledColor.withOpacity(0.3),
                    child: Center(
                      child: Text(
                        app.name.substring(0, 1).toUpperCase(),
                        style: TextStyle(
                          fontSize: 4.w,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          SizedBox(width: 4.w),

          // App name
          Expanded(
            child: Text(
              app.name,
              style: GoogleFonts.poppins(
                fontSize: 4.w,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          SizedBox(width: 2.w),

          // Protected indicator (closed padlock)
          Icon(
            Icons.lock,
            color: Theme.of(context).textTheme.bodyMedium?.color,
            size: 6.w,
          ),
        ],
      ),
    );
  }

  Widget _buildUnprotectedAppListItem(
    AppModel app,
    ProtectedAppsController controller,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () {
        print("Unprotected app tapped: ${app.name}");
        controller.toggleApp(app);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 2.h),
        child: Row(
          children: [
            // App icon with circular white background
            Container(
              width: 12.w,
              height: 12.w,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  app.iconPath,
                  width: 12.w,
                  height: 12.w,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    print("Image error for ${app.name}: $error");
                    print("Image path: ${app.iconPath}");
                    return Container(
                      color: Theme.of(context).disabledColor.withOpacity(0.3),
                      child: Center(
                        child: Text(
                          app.name.substring(0, 1).toUpperCase(),
                          style: TextStyle(
                            fontSize: 4.w,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            SizedBox(width: 4.w),

            // App name
            Expanded(
              child: Text(
                app.name,
                style: GoogleFonts.poppins(
                  fontSize: 4.w,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),

            SizedBox(width: 2.w),

            // Unprotected indicator (empty circle)
            Container(
              width: 6.w,
              height: 6.w,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
