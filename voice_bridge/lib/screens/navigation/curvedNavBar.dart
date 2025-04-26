import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voice_bridge/resources/colors/app_color.dart';
import 'package:voice_bridge/screens/base/controllers/baseController.dart';

class CurvedNavBar extends StatelessWidget {

  final BaseController controller;


  const CurvedNavBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => CurvedNavigationBar(
      backgroundColor: Colors.transparent, // Background of the screen
      color: AppColor.navigationColor, // Color of the navigation bar
      buttonBackgroundColor: AppColor.navigationColor, // Background of the selected item
      height: 60,

      animationDuration: const Duration(milliseconds: 300),
      animationCurve: Curves.easeInOut,
      index: controller.selectedIndex.value,
      onTap: (index) => controller.selectedIndex.value = index,
      items: [
        _buildNavItem(Icons.checklist_rtl_outlined, 0),
        _buildNavItem(Icons.school, 1),
        _buildNavItem(Icons.manage_accounts, 2),
      ],
    ));
  }

  Widget _buildNavItem(IconData icon, int index) {
    return Icon(
      icon,
      size: controller.selectedIndex.value == index ? 40 : 30,
      color: controller.selectedIndex.value == index ? AppColor.primaryTextColor : AppColor.secondaryTextColor,
    );
  }
}
