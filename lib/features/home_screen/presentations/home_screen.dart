import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:weathora/features/home_screen/presentations/home_controller.dart';
import 'package:weathora/widgets/app_colors.dart';
import 'package:weathora/widgets/apptext.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 4.5.w, vertical: 2.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      "Weathora",
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.light.textPrimary,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset("assets/icons/send_icon.svg"),
                    ),
                  ],
                ),
                SizedBox(height: 1.5.h,),
                Container(
                  width: 90.w,
                  height: 7.h,
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    color: AppColors.light.surface,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: AppColors.light.border),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 5,
                        offset: const Offset(0.4, 5.2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search_rounded,
                        color: AppColors.light.icon,
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: TextFormField(
                          controller: controller.searchC,
                          onChanged: controller.searchCity,
                          style: TextStyle(
                            color: AppColors.light.textPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: InputDecoration(
                            hintText: "Search Your City...",
                            hintStyle: TextStyle(
                              color: AppColors.light.textSecondary,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                            border: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      Obx(() {
                        if (controller.searchText.value.isNotEmpty) {
                          return GestureDetector(
                            onTap: () {
                              controller.searchC.clear();
                              controller.searchCity('');
                            },
                            child: Icon(
                              Icons.close_rounded,
                              color: AppColors.light.icon,
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      }),
                    ],
                  ),
                ),
                Obx(() {

                  if(controller.isSearching.value){
                    return Padding(padding: EdgeInsets.all(14), child: Center(child: CircularProgressIndicator(),),);
                  }
                  if(controller.searchText.value.trim().length < 2){
                    return const SizedBox.shrink();
                  }
                  if (controller.city.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.all(3.w),
                      child: Text(
                        controller.errorMessage.value.isNotEmpty
                            ? controller.errorMessage.value
                            : 'No cities found',
                        style: TextStyle(
                          color: AppColors.light.textSecondary,
                        ),
                      ),
                    );
                  }
                  return Container(
                    margin: EdgeInsets.only(top: 1.h),
                    decoration: BoxDecoration(
                      color: AppColors.light.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.light.border,
                      ),
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.city.length,
                      separatorBuilder: (_, _) => Divider(
                        height: 1,
                        color: AppColors.light.border,
                      ),
                      itemBuilder: (context, index) {
                        final item = controller.city[index];

                        return ListTile(
                          leading: Icon(
                            Icons.location_city,
                            color: AppColors.light.icon,
                          ),
                          title: Text(item.name),
                          subtitle: Text(
                            [
                              if (item.admin1.isNotEmpty) item.admin1,
                              item.country,
                            ].join(', '),
                          ),
                          onTap: () async {

                            FocusScope.of(context).unfocus();
                            await controller.selectCity(item);
                           },
                        );
                      },
                    ),
                  );
                }),

                SizedBox(height: 3.5.h,),

                Obx(() {
                  if (controller.isLoading.value &&
                      controller.weather.value == null) {
                    return const SizedBox(
                      height: 35,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (controller.weather.value == null) {
                    return Text(
                      controller.errorMessage.value.isNotEmpty
                          ? controller.errorMessage.value
                          : 'Loading weather...',
                    );
                  }

                  final weather = controller.weather.value!;

                  return Container(
                    width: 90.w,
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.light.border,
                      ),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/img.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          weather.city,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.dark.textPrimary,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          controller.weatherDescription(weather.weatherCode),
                          style: TextStyle(
                            color: AppColors.dark.textSecondary,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            Text(
                              '${weather.temperature.round()}°C',
                              style: TextStyle(
                                fontSize: 45,
                                fontWeight: FontWeight.bold,
                                color: AppColors.dark.textPrimary,
                              ),
                            ),
                            const Spacer(),
                            Image.asset(
                              controller.weatherIcon(weather.weatherCode),
                              height: 15.h,
                            ),
                          ],
                        ),
                        Text(
                          'Feels like ${weather.feelsLike.round()}°C',
                          style: TextStyle(
                            color: AppColors.dark.textSecondary,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Humidity: ${weather.humidity}%',
                                style: TextStyle(
                                  color: AppColors.dark.textPrimary,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Wind: ${weather.windSpeed.round()} km/h',
                                style: TextStyle(
                                  color: AppColors.dark.textPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),

                SizedBox(height: 3.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText("Today", color: AppColors.light.textPrimary,fontWeight: FontWeight.bold,fontSize: 22,)
                  ,  AppText("7 Days forecast", color: AppColors.light.textPrimary,fontWeight: FontWeight.bold,fontSize: 13,)
                  ],
                ),

                SizedBox(height: 3.h,),
                Obx(() {
                  final weather = controller.weather.value;

                  if (weather == null) {
                    return const SizedBox.shrink();
                  }

                  final hours = weather.hourlyForecast;

                  return SizedBox(
                    height: 20.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: hours.length,
                      itemBuilder: (context, index) {
                        final item = hours[index];

                        final time = index == 0
                            ? 'Now'
                            : '${item.time.hour.toString().padLeft(2, '0')}:00';

                        return dayWidget(
                          time: time,
                          icon: controller.weatherIcon(item.weatherCode),
                          temp: '${item.temperature.round()}°',
                        );
                      },
                    ),
                  );
                }),
                
                SizedBox(height: 2.h,),
                AppText("7 Days Forecast", fontSize: 22,fontWeight: FontWeight.bold,color: AppColors.light.textPrimary,textAlign: TextAlign.start,)
,                SizedBox(height: 1.h,),
                Obx(() {
                  final weather = controller.weather.value;

                  if (weather == null) {
                    return const SizedBox.shrink();
                  }

                  final days = weather.dailyForecast;

                  const weekdays = [
                    'Mon', 'Tue', 'Wed', 'Thu',
                    'Fri', 'Sat', 'Sun',
                  ];

                  return ListView.builder(
                    itemCount: days.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final day = days[index];

                      final dayName = index == 0
                          ? 'Today'
                          : weekdays[day.date.weekday - 1];

                      return sevenDay(
                        weatherImage: controller.weatherIcon(day.weatherCode),
                        weatherTitle:
                        controller.weatherDescription(day.weatherCode),
                        dayTemperature:
                        '${day.maxTemperature.round()}° / '
                            '${day.minTemperature.round()}°',
                        dayName: dayName,
                        feelLike:
                        '${day.maxFeelsLike.round()}°',
                      );
                    },
                  );
                }),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dayWidget({required String time, required String icon,  required String temp}) {
    return Container(
      margin: EdgeInsets.all(1.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: BoxBorder.all(color: AppColors.light.border,),
        color: AppColors.light.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 5,
            offset: Offset(0.4, 5.2)
          )
        ]

      ),
      child : Column(
        children: [
          SizedBox(height: 0.4.h,),
          AppText(time.toString(), fontSize: 18, fontWeight: FontWeight.bold,color: AppColors.light.textPrimary,),
          SizedBox(height: 1.h,),
          Image.asset(icon, height: 5.h,fit: BoxFit.contain,),
          SizedBox(height: 1.h,),
          AppText(temp, fontSize: 20,fontWeight: FontWeight.bold,color: AppColors.light.textPrimary,)
        ],
      ),
    );
  }

  Widget sevenDay({required String weatherImage, required String weatherTitle, required String dayTemperature, required String dayName, required String feelLike}){
    return Card(
       color: AppColors.light.surface,
      elevation: 3.0,
      child: ListTile(
        leading: AppText(dayName, fontSize: 20, fontWeight: FontWeight.bold,color: AppColors.light.secondary,),
        title: AppText(weatherTitle, fontSize: 18,fontWeight: FontWeight.bold,color: AppColors.light.textSecondary,),
        subtitle: Row(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText("Temp: ", color: AppColors.light.primary,fontWeight: FontWeight.bold,fontSize: 10,),
                AppText(dayTemperature, fontSize: 10, fontWeight: FontWeight.w600,color: AppColors.light.textSecondary,),
              ],
            ),
            // SizedBox(width: 1.w,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 2.w),
              height: 2.h,
              width: 0.8.w,
              decoration: BoxDecoration(
                color: AppColors.light.textSecondary,
                borderRadius: BorderRadius.circular(12)
              ),
            ),
            Row(
              children: [
                AppText("Feel: ", fontWeight: FontWeight.bold,color: AppColors.light.primary,fontSize: 10,),
                AppText(feelLike,fontSize: 10, fontWeight: FontWeight.w600,color: AppColors.light.textSecondary,),
              ],
            )
          ],
        ),
        trailing: Container(
          height: 10.h,
          width: 12.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(image: AssetImage(weatherImage), fit: BoxFit.contain)
          ),
        ),
      ),
    );
  }
}

