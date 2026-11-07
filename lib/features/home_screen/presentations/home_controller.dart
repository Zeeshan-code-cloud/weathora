import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:smart_permission/smart_permission.dart';
import 'package:weathora/core/storage_keys/storage_services.dart';
import 'package:weathora/features/collection_screen/collection_controller.dart';
import 'package:weathora/features/home_screen/domain/city_user_case.dart';
import 'package:weathora/features/home_screen/domain/entities.dart';
import 'package:weathora/features/home_screen/domain/weather_use_case.dart';

import '../domain/city_entity.dart';

import 'package:geocoding/geocoding.dart';

class HomeController extends GetxController {
  final GetWeather getWeather;
  final CityUserCase cityUserCase;
  final StorageServices storageServices;
  HomeController({
    required this.getWeather,
    required this.cityUserCase,
    required this.storageServices,
  });

  final Geocoding geocoding = Geocoding();
  final searchC = TextEditingController();
  final weather = Rxn<Weather>();
  RxBool isLoading = false.obs;
  final errorMessage = "".obs;

  final emptyList = [];

  final city = <City>[].obs;
  final searchText = "".obs;
  final isSearching = false.obs;
  @override
  void onInit() {
    askPermissions();
    super.onInit();
  }

  Future askPermissions() async {
    final status = await SmartPermission.requestResult(
      permission: Permission.location,
      style: PermissionDialogStyle.adaptive,
    );
    if (status.canProceed) {
      fetchCurrentLocations();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
      fetchWeather(cityName: "Peshawar");
    } else {
      Get.snackbar(
        "Permission Denied",
        "Location permission is required to fetch local weather.",
      );
      fetchWeather(cityName: "Peshawar");
    }
  }

  Future<void> saveWeatherToHistory() async {
    final currentWeather = weather.value;

    if (currentWeather == null) return;

    final snapshot = WeatherHistoryModel(
      city: weather.value!.city,
      condition: weather.value!.weatherCode.toString(),
      temperature: weather.value!.temperature.toString(),
      dateTime: weather.value!.timezone.toString(),
      weatherDescription: weather.value!.weatherCode.toString(),
      weatherId: DateTime.now().microsecondsSinceEpoch.toString(),
    );

    await storageServices.saveWeather(snapshot);

  }

  Future fetchCurrentLocations() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar("Location Disabled", "Please enable location services.");
        fetchWeather(cityName: "Peshawar");
        return;
      }

      // Get device position through geolocator
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      // Reverse geocode coordinates to get placemark/city
      final placemarks = await geocoding.placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      String? cityName;
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        cityName = (place.locality != null && place.locality!.isNotEmpty)
            ? place.locality
            : (place.subAdministrativeArea != null &&
                  place.subAdministrativeArea!.isNotEmpty)
            ? place.subAdministrativeArea
            : place.administrativeArea;
      }

      // Give latitude, longitude, and city name to fetchWeather method
      await fetchWeather(
        latitude: position.latitude,
        longitude: position.longitude,
        cityName: cityName,
      );
    } catch (e) {
      Get.snackbar("Location Error", "Could not fetch location weather: $e");
      fetchWeather(cityName: "Peshawar");
    }
  }

  Future fetchWeather({
    double latitude = 34.015,
    double longitude = 71.524,
    String? cityName,
  }) async {
    try {
      errorMessage.value = "";
      isLoading.value = true;

      final selectedCity =
          cityName ??
          (searchText.value.isNotEmpty ? searchText.value : "Peshawar");

      weather.value = await getWeather.call(
        late: latitude,
        lang: longitude,
        city: selectedCity,
      );
      await saveWeatherToHistory();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  String weatherIcon(int code) {
    if (code == 0) return "assets/images/clearsky.png";
    if (code == 1) return "assets/images/clearsky.png";
    if (code == 2) return "assets/images/cloudyday.png";
    if (code == 3) return "assets/images/rainyday.png";
    if ([45, 48].contains(code)) {
      return 'assets/images/fog.png';
    }

    if ([51, 53, 55, 56, 57].contains(code)) {
      return 'assets/images/drizzles.png';
    }

    if ([61, 63, 65, 66, 67, 80, 81, 82].contains(code)) {
      return 'assets/images/rainycloudy.png';
    }

    if ([71, 73, 75, 77, 85, 86].contains(code)) {
      return 'assets/images/snowweather.png';
    }

    if ([95, 96, 99].contains(code)) {
      return 'assets/images/thunderstormday.png';
    }

    return 'Unknown conditions';
  }

  String weatherDescription(int code) {
    switch (code) {
      case 0:
        return 'Clear Sky';

      case 1:
        return 'Mainly Clear';

      case 2:
        return 'Partly Cloudy';

      case 3:
        return 'Overcast';

      case 45:
      case 48:
        return 'Foggy';

      case 51:
      case 53:
      case 55:
        return 'Drizzle';

      case 56:
      case 57:
        return 'Freezing Drizzle';

      case 61:
      case 63:
      case 65:
        return 'Rain';

      case 66:
      case 67:
        return 'Freezing Rain';

      case 71:
      case 73:
      case 75:
        return 'Snowfall';

      case 77:
        return 'Snow Grains';

      case 80:
      case 81:
      case 82:
        return 'Rain Showers';

      case 85:
      case 86:
        return 'Snow Showers';

      case 95:
        return 'Thunderstorm';

      case 96:
      case 99:
        return 'Thunderstorm with Hail';

      default:
        return 'Unknown Conditions';
    }
  }

  Future<void> searchCity(String query) async {
    searchText.value = query;
    if (query.trim().length < 2) {
      city.clear();
      errorMessage.value = "";
      return;
    }

    isSearching.value = true;
    errorMessage.value = "";
    try {
      final result = await cityUserCase.call(query);
      city.assignAll(result);

      if (result.isEmpty) {
        errorMessage.value = "no city found";
      }
    } catch (e) {
      errorMessage.value = 'Unable to search cities';
      city.clear();
    } finally {
      isSearching.value = false;
    }
  }

  Future<void> selectCity(City city) async {
    searchC.text = city.name;
    searchText.value = '';
    this.city.clear();
    errorMessage.value = '';
    isSearching.value = false;

    await fetchWeather(
      latitude: city.latitude,
      longitude: city.longitude,
      cityName: city.name,
    );
  }

  @override
  void onClose() {
    searchC.dispose();
    super.onClose();
  }
}
