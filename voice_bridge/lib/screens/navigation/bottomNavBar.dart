import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voice_bridge/resources/colors/app_color.dart';
import '../home/view_model/home_view_model.dart';

class BottomNavBar extends StatelessWidget {
  final HomeViewModel controller;

  const BottomNavBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => BottomNavigationBar(
        currentIndex: controller.selectedIndex.value,
        onTap: (index) => controller.selectedIndex.value = index,
        backgroundColor: AppColor.navigationColor, // Background color
        // selectedItemColor: AppColor.navigationColor, // Selected icon color
        unselectedItemColor: Colors.green, // Unselected icon color
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          _buildNavItem(Icons.checklist_rtl_outlined, 0),
          _buildNavItem(Icons.school, 1),
          _buildNavItem(Icons.manage_accounts, 2),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, int index) {
    bool isSelected = controller.selectedIndex.value == index;
    return BottomNavigationBarItem(
      icon: isSelected? Container(
        // padding: EdgeInsets.all(20), // Increase padding
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.blackColor,width: 1),
          shape: BoxShape.circle,
          color: AppColor.appBarColor,
        ),
        child: Icon(
          icon,
          size: 40, // Make selected item bigger
          color: Colors.white, // Change color
        ),
      ): Icon(icon),
      label: '',
    );
  }
}