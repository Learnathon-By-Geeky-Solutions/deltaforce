import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/view_model/home_view_model.dart';

class BottomNavBar extends StatelessWidget {
  final HomeViewModel controller;

  const BottomNavBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomNavigationBar(
      currentIndex: controller.selectedIndex.value,
      onTap: controller.changeTab,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.school), label: "Practice"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    ));
  }
}
