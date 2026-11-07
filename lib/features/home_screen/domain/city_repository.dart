import 'package:weathora/features/home_screen/domain/city_entity.dart';

abstract class CityRepository {

  Future<List<City>> call(String query);

}