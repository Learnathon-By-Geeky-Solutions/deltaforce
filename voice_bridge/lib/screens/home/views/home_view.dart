import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voice_bridge/screens/learnScreen/views/learnScreenView.dart';
import 'package:voice_bridge/screens/parentScreen/views/parentScreenView.dart';
import 'package:voice_bridge/screens/practiceScreen/views/practiceScreenView.dart';

import '../../drawer/views/appDrawer.dart';
import '../../navigation/bottomNavBar.dart';
import '../view_model/home_view_model.dart';


class HomeView extends StatelessWidget {
  HomeView({super.key});

  final HomeViewModel controller = Get.put(HomeViewModel());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> pages = [
    const LearnScreenView(),
    const PracticeScreenView(),
    const ParentScreenView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("VoiceBridge"),
          leading: Container(),
          actions: [
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
            ),
          ]
      ),
      endDrawer: const AppDrawer(),
      body: Obx(() => pages[controller.selectedIndex.value]),
      bottomNavigationBar: BottomNavBar(controller: controller),
    );
  }
}
