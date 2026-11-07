import 'package:get/get.dart';
import 'package:weathora/core/api_client.dart';
import 'package:weathora/core/storage_keys/storage_services.dart';
import 'package:weathora/features/bottom_nav_screen/bottom_nav_controller.dart';
import 'package:weathora/features/collection_screen/collection_controller.dart';
import 'package:weathora/features/home_screen/repository/city_repository_imple.dart';
import 'package:weathora/features/home_screen/repository/weather_repo_imple.dart';
import 'package:weathora/features/home_screen/domain/city_repository.dart';
import 'package:weathora/features/home_screen/domain/weather_repo.dart';
import 'package:weathora/features/home_screen/domain/weather_use_case.dart';
import 'package:weathora/features/home_screen/presentations/home_controller.dart';
import 'package:weathora/features/onboarding_screen/onboarding_controller.dart';
import 'package:weathora/features/setting_screen/setting_controller.dart';
import 'package:weathora/features/splash_screen/splash_controller.dart';

import '../../features/home_screen/domain/city_user_case.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
  }
}

class OnboardingBinding extends AppBinding {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingController>(() => OnboardingController(), fenix: true);
  }
}

class BottomNavBinding extends AppBinding {


  @override
  void dependencies() {
    Get.lazyPut<BottomNavController>(() => BottomNavController(), fenix: true);

    Get.lazyPut<CollectionController>(() => CollectionController(), fenix: true);
    Get.lazyPut<SettingController>(() => SettingController(), fenix: true);
    //first registered the api client
    Get.lazyPut<ApiClient>(() => ApiClient(), fenix: true);
    Get.lazyPut<StorageServices>(() => StorageServices());
    //bind repository with implementations
    Get.lazyPut<WeatherRepo>(() => WeatherRepoImple(Get.find<ApiClient>()));
    Get.lazyPut<CityRepository>(() => CityRepositoryImple(Get.find<ApiClient>()));

    //now registered the use cases
    Get.lazyPut(() => GetWeather(Get.find<WeatherRepo>()));
    Get.lazyPut(() => CityUserCase(Get.find<CityRepository>()));


    //now registered the controller
    Get.lazyPut<HomeController>(() => HomeController(
        getWeather: Get.find<GetWeather>(),
      cityUserCase: Get.find<CityUserCase>(),
      storageServices: Get.find<StorageServices>(),
    ), fenix: true);
  }

}

