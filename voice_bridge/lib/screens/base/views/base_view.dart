import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voice_bridge/resources/colors/app_color.dart';
import 'package:voice_bridge/screens/learnScreen/views/learnScreenView.dart';
import 'package:voice_bridge/screens/navigation/curvedNavBar.dart';
import 'package:voice_bridge/screens/parentScreen/views/parentScreenView.dart';
import 'package:voice_bridge/screens/practiceScreen/views/practiceScreenView.dart';

import '../../end_drawer/views/appDrawer.dart';
import '../controllers/baseController.dart';


class BaseView extends StatelessWidget {
  // HomeView({super.key});
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
        ),
      ),
      endDrawer: AppDrawer(),
      body: Obx(() => pages[controller.selectedIndex.value]),
      bottomNavigationBar: CurvedNavBar(controller: controller),
    );
  }
}
