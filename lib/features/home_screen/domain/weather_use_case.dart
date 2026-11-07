import 'package:weathora/features/home_screen/domain/entities.dart';
import 'package:weathora/features/home_screen/domain/weather_repo.dart';

class GetWeather {
  final WeatherRepo weatherRepo;
  GetWeather(this.weatherRepo);

  Future<Weather> call({
    required double  late,
    required double lang,
    required String city,
  }) async {
    return weatherRepo.getWeather(late: late, lang: lang, city: city);
  }
}
