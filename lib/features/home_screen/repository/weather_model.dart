
 import '../domain/entities.dart';

class WeatherModel {
  static Weather fromJson(
      Map<String, dynamic> json, {
        required String city,
      }) {
    final current =
    json['current'] as Map<String, dynamic>;
    final hourly =
    json['hourly'] as Map<String, dynamic>;
    final daily =
    json['daily'] as Map<String, dynamic>;

    double number(Map<String, dynamic> map, String key) =>
        (map[key] as num?)?.toDouble() ?? 0.0;

    int integer(Map<String, dynamic> map, String key) =>
        (map[key] as num?)?.toInt() ?? 0;

    DateTime? dateTime(String? value) =>
        value == null ? null : DateTime.tryParse(value);

    final hourlyTimes = List<String>.from(hourly['time'] as List);
    final hourlyTemps =
    List<num>.from(hourly['temperature_2m'] as List);
    final hourlyFeels =
    List<num>.from(hourly['apparent_temperature'] as List);
    final hourlyCodes =
    List<num>.from(hourly['weather_code'] as List);
    final hourlyRain =
    List<num>.from(hourly['precipitation_probability'] as List);
    final hourlyPrecipitation =
    List<num>.from(hourly['precipitation'] as List);
    final hourlyHumidity =
    List<num>.from(hourly['relative_humidity_2m'] as List);
    final hourlyWind =
    List<num>.from(hourly['wind_speed_10m'] as List);
    final hourlyWindDirection =
    List<num>.from(hourly['wind_direction_10m'] as List);
    final hourlyUv =
    List<num>.from(hourly['uv_index'] as List);
    final hourlyIsDay =
    List<num>.from(hourly['is_day'] as List);

    final dailyTimes = List<String>.from(daily['time'] as List);
    final dailyMax =
    List<num>.from(daily['temperature_2m_max'] as List);
    final dailyMin =
    List<num>.from(daily['temperature_2m_min'] as List);
    final dailyMean =
    List<num>.from(daily['temperature_2m_mean'] as List);
    final dailyMaxFeels =
    List<num>.from(daily['apparent_temperature_max'] as List);
    final dailyMinFeels =
    List<num>.from(daily['apparent_temperature_min'] as List);
    final dailyCodes =
    List<num>.from(daily['weather_code'] as List);
    final dailyRain =
    List<num>.from(daily['precipitation_probability_max'] as List);
    final dailyPrecipitation =
    List<num>.from(daily['precipitation_sum'] as List);
    final dailyRainSum =
    List<num>.from(daily['rain_sum'] as List);
    final dailySnow =
    List<num>.from(daily['snowfall_sum'] as List);
    final dailyMaxWind =
    List<num>.from(daily['wind_speed_10m_max'] as List);
    final dailyWindDirection =
    List<num>.from(daily['wind_direction_10m_dominant'] as List);
    final dailyUv =
    List<num>.from(daily['uv_index_max'] as List);
    final dailyDaylight =
    List<num>.from(daily['daylight_duration'] as List);
    final dailySunshine =
    List<num>.from(daily['sunshine_duration'] as List);
    final dailyEt0 =
    List<num>.from(daily['et0_fao_evapotranspiration'] as List);
    final dailySunrise =
    List<String?>.from(daily['sunrise'] as List);
    final dailySunset =
    List<String?>.from(daily['sunset'] as List);

    return Weather(
      city: city,
      latitude: number(json, 'latitude'),
      longitude: number(json, 'longitude'),
      timezone: json['timezone'] as String? ?? 'UTC',
      temperature: number(current, 'temperature_2m'),
      feelsLike: number(current, 'apparent_temperature'),
      humidity: integer(current, 'relative_humidity_2m'),
      windSpeed: number(current, 'wind_speed_10m'),
      windDirection: integer(current, 'wind_direction_10m'),
      pressure: number(current, 'surface_pressure'),
      visibility: number(current, 'visibility'),
      uvIndex: number(current, 'uv_index'),
      weatherCode: integer(current, 'weather_code'),
      isDay: integer(current, 'is_day') == 1,
      updatedAt: DateTime.tryParse(
        current['time'] as String? ?? '',
      ) ??
          DateTime.now(),
      hourlyForecast: List.generate(
        hourlyTimes.length,
            (i) => HourlyWeather(
          time: DateTime.parse(hourlyTimes[i]),
          temperature: hourlyTemps[i].toDouble(),
          feelsLike: hourlyFeels[i].toDouble(),
          weatherCode: hourlyCodes[i].toInt(),
          precipitationProbability: hourlyRain[i].toInt(),
          precipitation: hourlyPrecipitation[i].toDouble(),
          humidity: hourlyHumidity[i].toInt(),
          windSpeed: hourlyWind[i].toDouble(),
          windDirection: hourlyWindDirection[i].toInt(),
          uvIndex: hourlyUv[i].toDouble(),
          isDay: hourlyIsDay[i].toInt() == 1,
        ),
      ),
      dailyForecast: List.generate(
        dailyTimes.length,
            (i) => DailyWeather(
          date: DateTime.parse(dailyTimes[i]),
          weatherCode: dailyCodes[i].toInt(),
          maxTemperature: dailyMax[i].toDouble(),
          minTemperature: dailyMin[i].toDouble(),
          meanTemperature: dailyMean[i].toDouble(),
          maxFeelsLike: dailyMaxFeels[i].toDouble(),
          minFeelsLike: dailyMinFeels[i].toDouble(),
          sunrise: dateTime(dailySunrise[i]),
          sunset: dateTime(dailySunset[i]),
          daylightDuration: dailyDaylight[i].toDouble(),
          sunshineDuration: dailySunshine[i].toDouble(),
          uvIndexMax: dailyUv[i].toDouble(),
          precipitationProbability: dailyRain[i].toInt(),
          precipitationSum: dailyPrecipitation[i].toDouble(),
          rainSum: dailyRainSum[i].toDouble(),
          snowfallSum: dailySnow[i].toDouble(),
          maxWindSpeed: dailyMaxWind[i].toDouble(),
          windDirection: dailyWindDirection[i].toInt(),
          et0: dailyEt0[i].toDouble(),
        ),
      ),
    );
  }
}
