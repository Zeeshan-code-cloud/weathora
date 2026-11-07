import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:weathora/features/collection_screen/collection_screen.dart';
 import 'package:weathora/features/setting_screen/setting_screen.dart';

import '../home_screen/presentations/home_screen.dart';

class BottomNavController  extends GetxController{


  RxInt currentIndex = 0.obs;
  List<Widget> pages = [
    HomeScreen(),
    CollectionScreen(),
    SettingScreen(),
  ];

}