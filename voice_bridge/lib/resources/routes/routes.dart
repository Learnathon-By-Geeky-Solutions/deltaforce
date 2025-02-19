import 'package:get/get.dart';
import 'package:voice_bridge/resources/routes/routes_name.dart';
import 'package:voice_bridge/screens/home/views/home_view.dart';
import 'package:voice_bridge/screens/learnScreen/views/learnScreenView.dart';
import 'package:voice_bridge/screens/parentScreen/views/parentScreenView.dart';
import 'package:voice_bridge/screens/practiceScreen/views/practiceScreenView.dart';

class AppRoutes {

  static appRoutes () => [
    GetPage(
        name: RoutesName.homeView,
        page: () => HomeView(),
        transitionDuration: Duration(milliseconds: 250),
        transition: Transition.noTransition
    ),

    GetPage(
        name: RoutesName.learnScreen,
        page: () => LearnScreenView(),
        transitionDuration: Duration(milliseconds: 250),
        transition: Transition.noTransition
    ),

    GetPage(
        name: RoutesName.practiceScreen,
        page: () => PracticeScreenView(),
        transitionDuration: Duration(milliseconds: 250),
        transition: Transition.noTransition
    ),

    GetPage(
        name: RoutesName.parentScreen,
        page: () => ParentScreenView(),
        transitionDuration: Duration(milliseconds: 250),
        transition: Transition.noTransition
    ),
  ];
}