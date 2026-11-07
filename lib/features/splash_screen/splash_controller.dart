import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:weathora/core/app_routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weathora/core/storage_keys/keys.dart';
class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void onReady() {
    super.onReady();
    moveOnboarding();
  }

  Future<void> moveOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstLaunch = prefs.getBool(StorageKeys.isFirstLaunch) ?? true;
    if(isFirstLaunch){
       Get.offAllNamed(AppRoutes.onboardingScreen);
    }
    else{
      Get.offAllNamed(AppRoutes.bottomNavScreen);
    }

  }
}