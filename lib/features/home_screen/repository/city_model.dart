

import '../domain/city_entity.dart';

class CityModel extends City {
  const CityModel({
    required super.name,
    required super.latitude,
    required super.longitude,
    required super.country,
    required super.admin1,
    super.timezone,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      name: json['name'] as String? ?? '',
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      country: json['country'] as String? ?? '',
      admin1: json['admin1'] as String? ?? '',
      timezone: json['timezone'] as String?,
    );
  }
}
