import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'routes/app_pages.dart';
import 'services/dependency_injection.dart';
import 'controllers/theme_controller.dart';
import 'utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies
  await DependencyInjection.init();

  // Lock orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Transparent status/navigation bar
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const MyCleanupApp());
}

class MyCleanupApp extends StatelessWidget {
  const MyCleanupApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        // ✅ Reactive theme handling with Obx
        return Obx(() {
          final themeController = ThemeController.to;

          return GetMaterialApp(
            title: 'My Cleanup App',
            debugShowCheckedModeBanner: false,

            // Theme setup
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeController.isSystemTheme.value
                ? ThemeMode.system
                : (themeController.isDarkMode.value
                ? ThemeMode.dark
                : ThemeMode.light),

            // Routes
            initialRoute: '/welcome',
            getPages: AppPages.routes,

            // Transitions
            defaultTransition: Transition.fadeIn,
            transitionDuration: const Duration(milliseconds: 300),
            onUnknownRoute: (settings) {
              return GetPageRoute(
                page: () => Scaffold(
                  appBar: AppBar(title: const Text('Page Not Found')),
                  body: const Center(
                    child: Text('The requested page could not be found.'),
                  ),
                ),
              );
            },
          );
        });
      },
    );
  }
}
