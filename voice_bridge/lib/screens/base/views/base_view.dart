import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voice_bridge/resources/colors/app_color.dart';
import 'package:voice_bridge/screens/learnScreen/views/learn_screen_view.dart';
import 'package:voice_bridge/screens/navigation/curved_nav_bar.dart';
import 'package:voice_bridge/screens/parentScreen/views/parent_screen_view.dart';
import 'package:voice_bridge/screens/practiceScreen/views/practice_screen_view.dart';

import '../../end_drawer/views/app_drawer.dart';
import '../controllers/base_controller.dart';


class BaseView extends StatelessWidget {
  BaseView({super.key});
  final BaseController controller = Get.put(BaseController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> pages = [
    PracticeScreenView(),
    LearnScreenView(),
    ParentScreenView(),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        title: const Text("Voice Bridge",style: TextStyle(color: AppColor.primaryTextColor),),

          leading: Container(),
          actions: [
            IconButton(
              color: AppColor.primaryTextColor,
              icon: const Icon(Icons.menu),
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
            ),
          ],
        elevation: 5,
        shadowColor: AppColor.appBarColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
        ),
      ),
      endDrawer: AppDrawer(),
      body: Obx(() => pages[controller.selectedIndex.value]),
      bottomNavigationBar: CurvedNavBar(controller: controller),
    );
  }
}
