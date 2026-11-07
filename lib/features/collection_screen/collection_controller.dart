import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:weathora/core/storage_keys/storage_services.dart';

class CollectionController extends GetxController {

  final weatherHistory = Get.find<StorageServices>();
  final weatherList = <WeatherHistoryModel>[].obs;
  final currentFilter = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    showWeatherHistory();
  }

  Future<void> showWeatherHistory() async{
   return   weatherList.assignAll( await weatherHistory.getWeatherHistory());
  }

  List<String> historyFiltered = [
    "This Week",
    "This Month"
  ];

 }

class WeatherHistoryModel {
  final String weatherId;
  final String city;
  final String condition;
  final String temperature;
  final String dateTime;
  final String weatherDescription;
  const WeatherHistoryModel({
    required this.city,
    required this.condition,
    required this.temperature,
    required this.dateTime,
    required this.weatherDescription,
    required this.weatherId
    });

  factory WeatherHistoryModel.fromJson(Map<String, String> map) {
    return WeatherHistoryModel(
      weatherId: map["weatherId"]?? "",
      city: map["city"] ?? "",
      condition: map["condition"] ?? "",
      temperature: map["temperature"] ?? "",
      dateTime: map["dateTime"] ?? "",
      weatherDescription: map["weatherDescription"]?? "",
      );
  }
  Map<String, dynamic> toJson() {
    return {
      "weatherId" : weatherId,
      'city': city,
      'condition': condition,
      'temperature': temperature,
      'dateTime': dateTime,
      'weatherDescription': weatherDescription,
    };
  }
}
