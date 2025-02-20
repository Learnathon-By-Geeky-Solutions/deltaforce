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
        BottomNavigationBarItem(icon: Icon(Icons.checklist_rtl_outlined), label: 'Practice'),
        BottomNavigationBarItem(icon: Icon(Icons.school), label: "Learn"),
        BottomNavigationBarItem(icon: Icon(Icons.manage_accounts), label: "Parents"),
      ],
    ));
  }
}
