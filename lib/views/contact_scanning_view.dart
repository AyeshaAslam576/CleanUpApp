import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../controllers/contact_scanning_controller.dart';
import '../controllers/theme_controller.dart';

class ContactScanningView extends StatelessWidget {
  const ContactScanningView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ContactScanningController());
    final themeController = Get.find<ThemeController>();
    final theme = Theme.of(context);

    return Obx(() {
      // Listen to theme changes
      themeController.isDarkMode.value;
      themeController.isSystemTheme.value;

      return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                // Header
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: controller.goBack,
                        icon: Icon(
                          Icons.arrow_back,
                          color: theme.colorScheme.onBackground,
                        ),
                        iconSize: 7.w,
                      ),
                      Text(
                        'Contacts',
                        style: GoogleFonts.poppins(
                          fontSize: 6.w,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onBackground,
                        ),
                      ),
                    ],
                  ),
                ),

                // Contact Grid Section
                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: Column(
                      children: [
                        // Contact Grid - 6 contacts per row (28 total as shown in design)
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5,
                                  crossAxisSpacing: 2.w,
                                  mainAxisSpacing: 2.h,
                                  childAspectRatio: 1,
                                ),
                            itemCount: 15, // 28 contacts as shown in design
                            itemBuilder: (context, index) {
                              return Obx(() {
                                final isSelected = controller.selectedContacts
                                    .contains(index);

                                return GestureDetector(
                                  onTap: () =>
                                      controller.toggleContactSelection(index),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.surface,
                                      shape: BoxShape.circle,
                                      border: isSelected
                                          ? Border.all(
                                              color: theme.colorScheme.error,
                                              width: 2,
                                            )
                                          : null,
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      color: isSelected
                                          ? theme.colorScheme.error
                                          : theme.colorScheme.primary,
                                      size: 6.w,
                                    ),
                                  ),
                                );
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Bottom Cards Section
                Expanded(
                  flex: 4,
                  child: Container(
                    width: double.infinity,
                    color: theme.scaffoldBackgroundColor,

                    child: Column(
                      children: [
                        // Contact Summary Card
                        Text(
                          "You have 37 contacts",
                          style: GoogleFonts.poppins(
                            fontSize: 5.w,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onBackground,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          "Lorem ipsum is a dummy or placeholder text commonly used in graphic design.",
                          style: GoogleFonts.poppins(
                            fontSize: 3.5.w,
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 1.5.h),

                        // Share Contacts Card
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: theme.shadowColor.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "How do you want to share contacts",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 5.w,
                                  fontWeight: FontWeight.w600,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                              SizedBox(height: 1.5.h),
                              Text(
                                "Lorem ipsum is a dummy or placeholder text commonly used in graphic designLorem ipsum is a dummy or placeholder text commonly used in graphic design.",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 3.5.w,
                                  color: theme.colorScheme.onSurface
                                      .withOpacity(0.7),
                                ),
                              ),
                              Text(
                                "Lorem ipsum is a dummy or placeholder text commonly used in graphic design.",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 3.5.w,
                                  color: theme.colorScheme.onSurface
                                      .withOpacity(0.7),
                                ),
                              ),

                              // Action Buttons
                              GestureDetector(
                                onTap: controller.selectContacts,
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 2.h),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 2.h,
                                    horizontal: 2.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    "Select Contacts    ",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 4.w,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(width: 2.w),
                              GestureDetector(
                                onTap: controller.shareAllContacts,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 2.h,
                                    horizontal: 2.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.surface,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    "Share all Contacts",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 4.w,
                                      fontWeight: FontWeight.w600,
                                      color: theme.colorScheme.onSurface
                                          .withOpacity(0.7),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
