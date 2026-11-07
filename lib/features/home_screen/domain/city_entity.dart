class City {
  const City({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.country,
    required this.admin1,
    this.timezone,
  });

  final String name;
  final double latitude;
  final double longitude;
  final String country;
  final String admin1;
  final String? timezone;
}