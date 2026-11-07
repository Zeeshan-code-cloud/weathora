import 'package:flutter/material.dart';
 import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:weathora/features/splash_screen/splash_controller.dart';
import 'package:weathora/widgets/app_colors.dart';
import 'package:weathora/widgets/apptext.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).brightness == Brightness.dark
        ? AppColors.light
        : AppColors.dark;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/img.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 12.h),
                Image.asset("assets/images/img_1.png",height: 25.h,),
                // SizedBox(height: 2.h,),
                AppText(
                  "Weathora",
                  fontSize: 30.sp,
                  color: colors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 1.w),
                AppText(
                  "Your Weather, Your Day",
                  fontSize: 20,
                  color: colors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
          Positioned(
            top: -10.h,
            left: -20.w,
            child: Container(
              width: 60.w,
              height: 30.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: colors.primary.withValues(alpha: .55),
                    blurRadius: 120,
                    spreadRadius: 60,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -10.h,
            right: -20.w,
            child: Container(
              width: 60.w,
              height: 30.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: colors.primary.withValues(alpha: .45),
                    blurRadius: 120,
                    spreadRadius: 60,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
