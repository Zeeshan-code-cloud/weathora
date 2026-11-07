import 'package:get/get.dart';
import 'package:weathora/core/bindings/app_binding.dart';

import '../../features/bottom_nav_screen/bottom_nav_screen.dart';
import '../../features/collection_screen/collection_screen.dart';
 import '../../features/home_screen/presentations/home_screen.dart';
import '../../features/onboarding_screen/onboarding_screen.dart';
import '../../features/setting_screen/setting_screen.dart';
import '../../features/splash_screen/splash_screen.dart';
import '../app_routes/app_routes.dart';

class AppPages {

  static final routes = [
    GetPage(name: AppRoutes.splashScreen, page: () => SplashScreen(), binding: AppBinding()),
    GetPage(name: AppRoutes.onboardingScreen, page: () => OnboardingScreen(),binding: OnboardingBinding()),
    GetPage(name: AppRoutes.bottomNavScreen, page: () => BottomNavScreen(),binding: BottomNavBinding()),
    GetPage(name: AppRoutes.homeScreen, page: () => HomeScreen(),binding: BottomNavBinding()),
    GetPage(name: AppRoutes.collectionScreen, page: () => CollectionScreen()),
    GetPage(name: AppRoutes.settingScreen, page: () => SettingScreen()),

  ];
}