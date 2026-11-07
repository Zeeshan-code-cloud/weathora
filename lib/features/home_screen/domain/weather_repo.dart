import 'package:weathora/features/home_screen/domain/entities.dart';

abstract class WeatherRepo {
  Future<Weather> getWeather({
    required double late,
    required double lang,
    required String city
});
}
