import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weathora/core/storage_keys/keys.dart';
import 'package:weathora/features/collection_screen/collection_controller.dart';

class StorageServices {
  Future<List<WeatherHistoryModel>> getWeatherHistory() async {
    final prefs = await SharedPreferences.getInstance();

    final weatherList = prefs.getStringList(StorageKeys.weatherListKey) ?? [];

    return weatherList
        .map((e) => WeatherHistoryModel.fromJson(jsonDecode(e)))
        .toList()
      ..sort(
        (a, b) =>
            DateTime.parse(b.dateTime).compareTo(DateTime.parse(a.dateTime)),
      );
  }

  Future<void> saveWeather(WeatherHistoryModel weatherHistoryModel) async {
    final prefs = await SharedPreferences.getInstance();

    final currentWeather = prefs.getString(StorageKeys.currentWeatherKey);
    if (currentWeather != null) {
      final current = WeatherHistoryModel.fromJson(jsonDecode(currentWeather));

      final previousDate = DateTime.parse(current.dateTime).toLocal();
      final newDate = DateTime.parse(weatherHistoryModel.dateTime).toLocal();

      final previousDay =
          '${previousDate.year}-${previousDate.month}-${previousDate.day}';
      final newDay = '${newDate.year}-${newDate.month}-${newDate.day}';

      if (previousDay != newDay) {
        final history = prefs.getStringList(StorageKeys.weatherListKey) ?? [];
        history.add(jsonEncode(current.toJson()));

        await prefs.setStringList(StorageKeys.weatherListKey, history);
      }
    }

    await prefs.setString(
      StorageKeys.currentWeatherKey,
      jsonEncode(weatherHistoryModel.toJson()),
    );
  }

  Future<void> deleteWeather(int weatherId) async {
    final prefs = await SharedPreferences.getInstance();
    final weatherList = prefs.getStringList(StorageKeys.weatherListKey);
    if (weatherList!.isNotEmpty) {
      weatherList.removeAt(weatherId);
    }
  }
}
