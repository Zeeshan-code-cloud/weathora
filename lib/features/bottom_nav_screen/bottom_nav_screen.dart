import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:weathora/features/bottom_nav_screen/bottom_nav_controller.dart';

import '../../widgets/app_colors.dart';
import '../../widgets/apptext.dart';

class BottomNavScreen extends GetView<BottomNavController> {
  const BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).brightness == Brightness.dark
        ? AppColors.dark
        : AppColors.light;
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: controller.pages,
        ),
      ),
      bottomNavigationBar: Obx(
        () {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: 2.w,
              vertical: 1.h,
            ),
            decoration: BoxDecoration(
              color: colors.surface,
              boxShadow: [
                BoxShadow(
                  color: colors.shadow,
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navItem(
                  index: 0,
                  title: "Home",
                  selectedIcon: Icons.home,
                  unselectedIcon: Icons.home_outlined,
                  colors: colors,
                ),
                _navItem(
                  index: 1,
                  title: "History",
                  selectedIcon: Icons.collections,
                  unselectedIcon: Icons.collections_outlined,
                  colors: colors,
                ),
                _navItem(
                  index: 2,
                  title: "Setting",
                  selectedIcon: Icons.settings,
                  unselectedIcon: Icons.settings_outlined,
                  colors: colors,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _navItem({
    required int index,
    required String title,
    required IconData selectedIcon,
    required IconData unselectedIcon,
    required AppColorPalette colors,
  }) {
    final bool isSelected = controller.currentIndex.value == index;

    return GestureDetector(
      onTap: () {
        controller.currentIndex.value = index;
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(
          horizontal: 3.w,
          vertical: 1.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? selectedIcon : unselectedIcon,
              color: isSelected ? colors.primary : colors.textSecondary,
            ),
            SizedBox(height: .5.h),
            AppText(
              title,
              color: isSelected ? colors.primary : colors.textSecondary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }
}
