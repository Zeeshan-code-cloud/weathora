class Weather {
  const Weather({
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.windDirection,
    required this.pressure,
    required this.visibility,
    required this.uvIndex,
    required this.weatherCode,
    required this.isDay,
    required this.updatedAt,
    required this.hourlyForecast,
    required this.dailyForecast,
  });

  final String city;
  final double latitude;
  final double longitude;
  final String timezone;

  // Current weather
  final double temperature;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final int windDirection;
  final double pressure;
  final double visibility;
  final double uvIndex;
  final int weatherCode;
  final bool isDay;
  final DateTime updatedAt;

  // Forecasts
  final List<HourlyWeather> hourlyForecast;
  final List<DailyWeather> dailyForecast;
}

class HourlyWeather {
  const HourlyWeather({
    required this.time,
    required this.temperature,
    required this.feelsLike,
    required this.weatherCode,
    required this.precipitationProbability,
    required this.precipitation,
    required this.humidity,
    required this.windSpeed,
    required this.windDirection,
    required this.uvIndex,
    required this.isDay,
  });

  final DateTime time;
  final double temperature;
  final double feelsLike;
  final int weatherCode;
  final int precipitationProbability;
  final double precipitation;
  final int humidity;
  final double windSpeed;
  final int windDirection;
  final double uvIndex;
  final bool isDay;
}

class DailyWeather {
  const DailyWeather({
    required this.date,
    required this.weatherCode,
    required this.maxTemperature,
    required this.minTemperature,
    required this.meanTemperature,
    required this.maxFeelsLike,
    required this.minFeelsLike,
    required this.sunrise,
    required this.sunset,
    required this.daylightDuration,
    required this.sunshineDuration,
    required this.uvIndexMax,
    required this.precipitationProbability,
    required this.precipitationSum,
    required this.rainSum,
    required this.snowfallSum,
    required this.maxWindSpeed,
    required this.windDirection,
    required this.et0,
  });

  final DateTime date;
  final int weatherCode;

  // Temperatures in °C
  final double maxTemperature;
  final double minTemperature;
  final double meanTemperature;
  final double maxFeelsLike;
  final double minFeelsLike;

  // Sun information
  final DateTime? sunrise;
  final DateTime? sunset;
  final double daylightDuration;
  final double sunshineDuration;

  // Weather conditions
  final double uvIndexMax;
  final int precipitationProbability;
  final double precipitationSum;
  final double rainSum;
  final double snowfallSum;

  // Wind information
  final double maxWindSpeed;
  final int windDirection;

  // Reference evapotranspiration, in mm
  final double et0;
}