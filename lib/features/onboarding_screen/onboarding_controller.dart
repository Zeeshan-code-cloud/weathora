import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:weathora/core/storage_keys/keys.dart';

import '../../core/app_routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
class OnboardingController  extends GetxController{

  final pageC  = PageController();
  RxInt currentIndex = 0.obs;

  List<String> onboardingImage = [
    "assets/images/img_2.png",
    "assets/images/img_3.png",
    "assets/images/img_4.png",
  ];

  List<String> onboardingTitle = [
    "Accurate Weather Forecasts",
    "Location Based Weather",
    "Detailed Forecasts",
  ];
  List<String> subtitle = [
    "Get realtime weather updates and plan your day with confidence",
    "Automatically detect your locations",
    "Hourly, daily and weekly forecasts with useful weather  details",
  ];

  void setIndex(int index){
    currentIndex.value = index;
  }

  void nextPage() {
    pageC.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Future getStarted() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(StorageKeys.isFirstLaunch, false);
     Get.offAllNamed(AppRoutes.bottomNavScreen);
  }
}