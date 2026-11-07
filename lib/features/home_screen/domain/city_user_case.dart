import 'package:weathora/features/home_screen/domain/city_entity.dart';
import 'package:weathora/features/home_screen/domain/city_repository.dart';

class CityUserCase {
  final CityRepository cityRepository;

  CityUserCase(this.cityRepository);

  Future<List<City>> call(String query)async {
    return cityRepository.call(query);
  }
}