import 'dart:convert';

import 'package:weathora/core/api_client.dart';
import 'package:weathora/features/home_screen/repository/city_model.dart';
import 'package:weathora/features/home_screen/domain/city_entity.dart';

import '../domain/city_repository.dart';

class CityRepositoryImple implements CityRepository {
  final ApiClient _apiClient;
  CityRepositoryImple(this._apiClient);
  @override
  Future<List<City>> call(String query) async {
    final trimQuery = query.trim().toString();

    if (trimQuery.length < 2) {
      return [];
    }

    final uri = Uri.http(
        'geocoding-api.open-meteo.com',
        '/v1/search',
        {
      'name': trimQuery,
      'count': '10',
      'language': 'en',
    });

    final response = await _apiClient.get(uri);
    if (response.statusCode != 200) {
      throw Exception("City search failed: ${response.statusCode}");
    }
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final result = json['results'] as List<dynamic>? ?? [];
    return result
        .map((e) => CityModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
