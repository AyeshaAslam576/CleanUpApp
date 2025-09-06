import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../controllers/theme_controller.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(
      () => PopupMenuButton<String>(
        icon: Icon(
          themeController.themeIcon,
          size: 6.w,
          color: Theme.of(context).iconTheme.color,
        ),
        tooltip: 'Theme Settings',
        onSelected: (value) {
          switch (value) {
            case 'light':
              themeController.setTheme(false);
              break;
            case 'dark':
              themeController.setTheme(true);
              break;
            case 'system':
              themeController.useSystemTheme();
              break;
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem<String>(
            value: 'light',
            child: Row(
              children: [
                Icon(Icons.light_mode, size: 5.w, color: Colors.orange),
                SizedBox(width: 3.w),
                Text('Light Theme', style: TextStyle(fontSize: 4.sp)),
                const Spacer(),
                if (!themeController.isDarkMode.value &&
                    !themeController.isSystemTheme.value)
                  Icon(
                    Icons.check,
                    size: 5.w,
                    color: Theme.of(context).primaryColor,
                  ),
              ],
            ),
          ),
          PopupMenuItem<String>(
            value: 'dark',
            child: Row(
              children: [
                Icon(Icons.dark_mode, size: 5.w, color: Colors.indigo),
                SizedBox(width: 3.w),
                Text('Dark Theme', style: TextStyle(fontSize: 4.sp)),
                const Spacer(),
                if (themeController.isDarkMode.value &&
                    !themeController.isSystemTheme.value)
                  Icon(
                    Icons.check,
                    size: 5.w,
                    color: Theme.of(context).primaryColor,
                  ),
              ],
            ),
          ),
          PopupMenuItem<String>(
            value: 'system',
            child: Row(
              children: [
                Icon(Icons.brightness_auto, size: 5.w, color: Colors.grey),
                SizedBox(width: 3.w),
                Text('System Theme', style: TextStyle(fontSize: 4.sp)),
                const Spacer(),
                if (themeController.isSystemTheme.value)
                  Icon(
                    Icons.check,
                    size: 5.w,
                    color: Theme.of(context).primaryColor,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Simple theme toggle button for quick switching
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(
      () => IconButton(
        onPressed: themeController.toggleTheme,
        icon: Icon(
          themeController.themeIcon,
          size: 6.w,
          color: Theme.of(context).iconTheme.color,
        ),
        tooltip: 'Toggle Theme',
      ),
    );
  }
}





