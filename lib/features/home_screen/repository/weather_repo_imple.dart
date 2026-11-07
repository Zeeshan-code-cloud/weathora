import 'dart:convert';

import 'package:weathora/core/api_client.dart';
import 'package:weathora/core/api_const.dart';
import 'package:weathora/core/weather_exceptions.dart';
import 'package:weathora/features/home_screen/repository/weather_model.dart';
import 'package:weathora/features/home_screen/domain/entities.dart';
import 'package:weathora/features/home_screen/domain/weather_repo.dart';

class WeatherRepoImple implements WeatherRepo {

  final ApiClient apiClient;
  WeatherRepoImple(this.apiClient);
  @override
  Future<Weather> getWeather({
    required double late,
    required double lang,
    required String city,
  }) async{

   final uri =    Uri.http(
        ApiConst.baseUrl.replaceFirst("https://", ""),
        ApiConst.forecastPath,{
        'latitude': '$late',
        'longitude': '$lang',
     'current':
     'temperature_2m,relative_humidity_2m,'
         'apparent_temperature,is_day,weather_code,'
         'wind_speed_10m,wind_direction_10m,'
         'surface_pressure,visibility,uv_index',
     'hourly':
     'temperature_2m,relative_humidity_2m,'
         'apparent_temperature,precipitation_probability,'
         'precipitation,weather_code,wind_speed_10m,'
         'wind_direction_10m,uv_index,is_day',
     'daily':
     'weather_code,temperature_2m_max,'
         'temperature_2m_min,temperature_2m_mean,'
         'apparent_temperature_max,apparent_temperature_min,'
         'sunrise,sunset,daylight_duration,sunshine_duration,'
         'uv_index_max,precipitation_probability_max,'
         'precipitation_sum,rain_sum,snowfall_sum,'
         'wind_speed_10m_max,wind_direction_10m_dominant,'
         'et0_fao_evapotranspiration',

        'timezone': 'auto',
        'forecast_days': '7',
        'forecast_hours': '24',
      }
      );
      try{

        final response = await apiClient.get(uri);
        if(response.statusCode != 200){
          throw ServerException("Weather API returned status ${response.statusCode}.");
        }
        final decoded = jsonDecode(response.body) as Map<String,dynamic>;
        if (decoded['current'] == null ||
            decoded['hourly'] == null ||
            decoded['daily'] == null) {
          throw   DataParsingException(
            'Weather response is incomplete.',
          );
        }

        return WeatherModel.fromJson(decoded, city: city);
      }
      on WeatherExceptions {
        rethrow;
      } on FormatException {
        throw   DataParsingException(
          'Unable to parse weather response.',
        );
      } on Exception catch (e) {
        throw NetworkException(
          'Unable to retrieve weather: $e',
        );
      }
   }
}
