import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:sizer/sizer.dart';
import 'package:weathora/features/collection_screen/collection_controller.dart';
import 'package:weathora/widgets/app_colors.dart';
import 'package:weathora/widgets/apptext.dart';

class CollectionScreen extends GetView<CollectionController> {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 3.w, vertical: 2.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 0.4.h),
              AppText(
                "History",
                color: AppColors.light.primary,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 1.h),
              SizedBox(
                width: double.infinity,
                height: 6.h,
                child: ListView.builder(
                  itemCount: controller.historyFiltered.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    return filterWidget(
                      title: controller.historyFiltered[index],
                      index: index,
                      onTap: () {
                        controller.currentFilter.value = index;
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 2.h),
              Obx(
                () => AppText(
                  controller.currentFilter.value == 0
                      ? "This Week"
                      : "This Month",
                  color: AppColors.light.textPrimary,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2.h,),

            ],
          ),
        ),
      ),
    );
  }

  Widget filterWidget({
    required String title,
    required int index,
    required Callback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Obx(() {
        final selected = controller.currentFilter.value == index;
        return AnimatedContainer(
          width: 40.w,
          duration: Duration(milliseconds: 200),
          padding: selected
              ? EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.w)
              : EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
          margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.w),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.light.accent.withOpacity(0.5)
                : AppColors.light.primary.withOpacity(0.1),
            border: BoxBorder.all(color: AppColors.light.border),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: AppText(
              title,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.light.primary,
            ),
          ),
        );
      }),
    );
  }

  Widget historyWidget({
    required String image,
    required String city,
    required String weatherStatus,
    required DateTime dataTime,
    required String temp,
  }) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 3.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Image.asset(image, height: 9.h)],
        ),
      ),
    );
  }
}

class WeatherHistoryCard extends StatelessWidget {
  final String city;
  final String condition;
  final String temperature;
  final String dateTime;
  final IconData icon;
  final Color iconColor;
  final VoidCallback? onTap;

  const WeatherHistoryCard({
    super.key,
    required this.city,
    required this.condition,
    required this.temperature,
    required this.dateTime,
    required this.icon,
    this.iconColor = const Color(0xFFFFC533),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).brightness == Brightness.dark
        ? AppColors.dark
        : AppColors.light;

    return Material(
      color: colors.surface,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 17),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: colors.border.withValues(alpha: 0.75),
                width: 1,
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Weather icon
              Container(
                width: 48,
                height: 48,
                margin: EdgeInsets.only(top: 2.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colors.surfaceVariant.withValues(alpha: 0.65),
                  shape: BoxShape.circle,
                ),
                child: Image.asset("assets/images/rainycloudy.png"),
              ),

              const SizedBox(width: 13),

              // City, condition and date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      city,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colors.textPrimary,
                    ),
                    const SizedBox(height: 3),
                    AppText(
                      condition,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: colors.textSecondary,
                    ),
                    const SizedBox(height: 9),
                    AppText(
                      dateTime,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: colors.textSecondary,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Temperature
              Padding(
                padding: EdgeInsets.only(top: 4.h, right: 3),
                child: AppText(
                  temperature,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: colors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
