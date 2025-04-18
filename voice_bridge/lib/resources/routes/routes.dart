import 'package:get/get.dart';
import 'package:voice_bridge/features/authentication/views/auth/login_screen.dart';
import 'package:voice_bridge/features/authentication/views/auth/signup_screen.dart';
import 'package:voice_bridge/features/authentication/views/auth/splash_screen.dart';
import 'package:voice_bridge/resources/routes/routesName.dart';
import 'package:voice_bridge/screens/learnScreen/views/learnScreenView.dart';
import 'package:voice_bridge/screens/learn_item_screen/balloon_blast/views/balloon_blast_screen.dart';
import 'package:voice_bridge/screens/learn_item_screen/shape_matching/views/shape_matching_screen.dart';
import 'package:voice_bridge/screens/parentScreen/views/autismTest.dart';
import 'package:voice_bridge/screens/parentScreen/views/parentScreenView.dart';
import 'package:voice_bridge/screens/practiceScreen/views/practiceScreenView.dart';
import 'package:voice_bridge/screens/testScreen/views/testDashboardScreen.dart';

import '../../screens/base/views/base_view.dart';
import '../../screens/learn_item_screen/balloon_blast/game_main.dart';
import '../../screens/sessionScreen/views/sessionCompletionView.dart';
import '../../screens/sessionScreen/views/sessionView.dart';
import '../../screens/testScreen/views/testCompletionView.dart';
import '../../screens/testScreen/views/testLearningView.dart';
import '../../screens/testScreen/views/testQuestionView.dart';
import '../../screens/testScreen/views/testScreen.dart';

class AppRoutes {

  static appRoutes () => [
    GetPage(
        name: RoutesName.baseView,
        page: () => BaseView(),
        transitionDuration: Duration(milliseconds: 250),
        transition: Transition.noTransition
    ),

    GetPage(
        name: RoutesName.splashScreen,
        page: () => SplashScreen(),
    ),

    GetPage(
        name: RoutesName.loginScreen,
        page: () => LoginScreen(),
    ),

    GetPage(
        name: RoutesName.signupScreen,
        page: () => SignupScreen(),
    ),


    GetPage(
        name: RoutesName.learnScreen,
        page: () => LearnScreenView(),
    ),

    GetPage(
        name: RoutesName.practiceScreen,
        page: () => PracticeScreenView(),
    ),

    GetPage(
        name: RoutesName.parentScreen,
        page: () => ParentScreenView(),
    ),


    GetPage(
        name: RoutesName.shapeMatching,
        page: () => ShapeMatchingScreen(),
    ),

    GetPage(
        name: RoutesName.balloonBlast,
        page: () => BalloonBlastScreen(),
    ),
    GetPage(
      name: RoutesName.gameMain,
      page: () => GameMain(),
    ),
    GetPage(
      name: RoutesName.sessionView,
      page: () => SessionView(),
    ),

    GetPage(
      name: RoutesName.sessionCompletion,
      page: () => SessionCompletionView(),
    ),


    GetPage(
      name: RoutesName.testLearningView,
      page: () => TestLearningView(),
    ),

    GetPage(
      name: RoutesName.testQuestionView,
      page: () => TestQuestionView(),
    ),

    GetPage(
      name: RoutesName.testScreen,
      page: () => TestScreen(),
    ),

    GetPage(
      name: RoutesName.testCompletion,
      page: () => TestCompletionView(),
    ),

    GetPage(
      name: RoutesName.testDashboardScreen,
      page: () => TestDashboardScreen(),
    ),

    GetPage(
      name: RoutesName.autismTestScreen,
      page: () => AutismTest(),
    ),
  ];
}