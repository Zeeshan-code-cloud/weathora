import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:weathora/core/app_pages/app_pages.dart';
import 'package:weathora/core/app_routes/app_routes.dart';
import 'package:weathora/widgets/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
   @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (_,_,_){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Weathora',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            scaffoldBackgroundColor: AppColors.light.surface,
          ),
          initialRoute: AppRoutes.splashScreen,
          getPages: AppPages.routes,
          popGesture: true,
        );
      },

    );
  }
}

