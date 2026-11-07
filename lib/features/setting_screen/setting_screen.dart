import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:sizer/sizer.dart';
import 'package:weathora/features/setting_screen/setting_controller.dart';
import 'package:weathora/widgets/app_colors.dart';
import 'package:weathora/widgets/apptext.dart';

class SettingScreen extends GetView<SettingController> {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 3.w, vertical: 3.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                "Settings",
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: AppColors.light.primary,
              ),
              SizedBox(height: 2.h),
              sectionTitle('Appearance', AppColors.light.textSecondary),
              Obx(
                () => settingTile(
                  colors: AppColors.light.secondary,
                  icon: Icons.nightlight_round,
                  title: 'Theme',
                  subtitle: 'Light mode',
                  containerColor: AppColors.light.surfaceVariant,
                  themeMode: controller.isDarkTheme.value
                      ? "Dark Mode"
                      : "Light  Mode",
                  trailing: Switch.adaptive(
                    value: controller.isDarkTheme.value,
                    activeTrackColor: AppColors.light.primary,
                    onChanged: (value) {
                      controller.isDarkTheme.value = value;
                    },
                  ),
                ),
              ),
              Obx(
                () => settingTile(
                  colors: AppColors.light.primary,
                  icon: Icons.language_rounded,
                  title: 'Language',
                  subtitle: "Selected Language : ${controller.currentLangIndex.value == 0
                      ? "Urdu"
                      : controller.currentLangIndex.value == 1
                      ? "English"
                      : "Arabic"}",
                  trailing: Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.light.icon,
                    size: 22,
                  ),
                  onTap: () {
                    showdialog(
                      dialogContext: Get.context!,
                      heading: "Select Language",
                      descriptions: "Select your language",
                    );

                  },
                ),
              ),
              SizedBox(height: 2.h),
              sectionTitle('Legal', AppColors.light.textSecondary),

              settingTile(
                colors: AppColors.light.primary,
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
                subtitle: 'How we handle your information',
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.light.icon,
                ),
                onTap: () async {
                  controller.launchToWeb("https://zeeshan-code-cloud.github.io/weathora_privacyPolicy/");
                },
              ),

              settingTile(
                colors: AppColors.light.primary,
                icon: Icons.description_outlined,
                title: 'Terms & Conditions',
                subtitle: 'Read our terms of use',
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.light.icon,
                ),
                onTap: () async {
                  controller.launchToWeb("https://zeeshan-code-cloud.github.io/weathora_terms/");
                },
              ),
              SizedBox(height: 2.h),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sectionTitle('Support & More', AppColors.light.textSecondary),

                  // Rate the app
                  settingTile(
                    colors: AppColors.light.primary,
                    icon: Icons.star_rounded,
                    title: 'Rate the App',
                    subtitle: 'Enjoying Weatherly? Leave a review',
                    trailing: Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.light.icon,
                      size: 22,
                    ),
                    onTap: ()async {
                      await controller.launchPlayStore("com.zeetech.app.weathora.weathora");
                    },
                  ),

                  // Share the app
                  settingTile(
                    colors: AppColors.light.primary,
                    icon: Icons.share_rounded,
                    title: 'Share App',
                    subtitle: 'Share Weatherly with friends',
                    trailing: Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.light.icon,
                      size: 22,
                    ),
                    onTap: ()  async {
                      await controller.shareApp("com.zeetech.app.weathora.weathora");
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget settingTile({
    required Color colors,
    required IconData icon,
    required String title,
    required String subtitle,
    Color? containerColor,
    Widget? trailing,
    Callback? onTap,
    String? themeMode,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.light.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.light.border.withValues(alpha: 0.55),
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.light.shadow.withValues(alpha: 0.35),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                // Icon container
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: themeMode != null
                        ? containerColor
                        : AppColors.light.primary.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, size: 22, color: AppColors.light.primary),
                ),

                const SizedBox(width: 12),

                // Title and subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(
                        title,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.light.textPrimary,
                      ),
                      const SizedBox(height: 3),
                      AppText(
                        themeMode ?? subtitle,
                        fontSize: 12,
                        color: AppColors.light.textSecondary,
                      ),
                    ],
                  ),
                ),

                // Switch or arrow
                if (trailing != null) trailing,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget sectionTitle(String title, Color colors) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 10),
      child: AppText(
        title.toUpperCase(),
        fontSize: 15,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.1,
        color: colors,
      ),
    );
  }

  Future<dynamic> showdialog({
    required String heading,
    required String descriptions,

    required BuildContext dialogContext,
  }) {
    return showDialog(
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(

          title: Column(
            children: [
              AppText(
                heading,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.light.textPrimary,
              ),
              SizedBox(height: 1.h),
              AppText(
                textAlign: TextAlign.center,
                descriptions,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.light.textSecondary,
              ),
            ],
          ),
          content: SizedBox(
            height: 22.h,
            width: 60.w,
            child: ListView.builder(
              itemCount: controller.flags.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final flg = controller.flags[index];
                final lag = controller.languages[index];
                return Column(
                  children: [
                    Obx(
                      () => ListTile(
                        leading: Image.asset(
                          flg,
                          fit: BoxFit.cover,
                          height: 3.h,
                        ),
                        title: AppText(
                          lag,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.light.textSecondary,
                        ),
                        onTap: () {
                          controller.currentLangIndex.value = index;
                          Get.back();
                        },
                        trailing: Container(
                          width: 3.w,
                          height: 4.w,
                          child: controller.currentLangIndex.value == index
                              ? Icon(
                                  Icons.check_box,
                                  color: AppColors.light.success,
                                )
                              : SizedBox.shrink(),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
         );
      },
      context: Get.context!,
    );
  }
}
