import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingController extends GetxController {
  RxInt currentLangIndex = 1.obs;
  RxString selectedLanguage = "English".obs;
  RxBool isDarkTheme = false.obs;

  List<String> flags = [
    "assets/images/pakistanflag.png",
    "assets/images/unitedstates.png",
    "assets/images/uaeflag.png",
  ];

  List<String> languages = ["Urdu", "English", "Arabic"];

  Future<void> launchToWeb(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      Get.snackbar("launch error", "url are invalid");
    }
  }

  Future<void> launchPlayStore(String packageName) async {
    final Uri uri = Uri.parse(
      "https://play.google.com/store/apps/details?id=$packageName",
    );

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      Get.snackbar(
        "Error",
        "Could not open Play Store",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future shareApp(String packageName) async {
    await SharePlus.instance.share(
      ShareParams(
        title: "Share Weathora",
        text:
            "Hy Check out! Weathora. Download it here:\n https://play.google.com/store/apps/details?id=$packageName",
      ),
    );
  }
}
