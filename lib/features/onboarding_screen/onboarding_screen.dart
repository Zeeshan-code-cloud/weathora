import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:weathora/features/onboarding_screen/onboarding_controller.dart';
import 'package:weathora/widgets/app_button.dart';
import 'package:weathora/widgets/apptext.dart';

import '../../widgets/app_colors.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).brightness == Brightness.dark
        ? AppColors.dark
        : AppColors.light;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            SizedBox(
              height: 75.h,
              child: PageView.builder(
                controller: controller.pageC,
                itemCount: controller.onboardingImage.length,
                physics: BouncingScrollPhysics(),
                onPageChanged: (index) {
                  controller.setIndex(index);
                },
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 50.h,
                        width: double.infinity,
                        child: Image.asset(
                          controller.onboardingImage[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Padding(
                        padding:   EdgeInsets.symmetric(horizontal: 5.w),
                        child: AppText(
                          controller.onboardingTitle[index],
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: colors.textPrimary,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 5.w),
                        child: AppText(
                          controller.subtitle[index],
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: colors.textSecondary,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 5.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(controller.onboardingTitle.length, (index){
                return Obx(
                    () {
                      final selected = controller.currentIndex.value == index;
                      return AnimatedContainer(
                        margin: EdgeInsets.all(0.5.w),
                        duration: Duration(milliseconds: 400),
                        width: selected   ? 4.w :  2.w,
                        height: 1.4.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: selected  ? colors.primary :  colors.accent.withOpacity(0.8),
                        ),
                      );
                    }
                );
              }),
            ),
            SizedBox(height: 5.h,),
            Obx(() {
             return  AppButtonWidget(
               onPressed: controller.currentIndex.value != 2 ? controller.nextPage : controller.getStarted ,
               text: controller.currentIndex.value != 2 ? "Next" : "Get Started",width: 80.w,height: 6.h,radius: 20,);

            }) ],
        ),
      ),
    );
  }
}
