import 'package:get/get.dart';
import 'package:voice_bridge/features/authentication/views/auth/login_screen.dart';
import 'package:voice_bridge/features/authentication/views/auth/signup_screen.dart';
import 'package:voice_bridge/features/authentication/views/auth/splash_screen.dart';
import 'package:voice_bridge/resources/routes/routes_name.dart';
import 'package:voice_bridge/screens/learnScreen/views/learn_screen_view.dart';
import 'package:voice_bridge/screens/learn_item_screen/balloon_blast/views/balloon_blast_screen.dart';
import 'package:voice_bridge/screens/parentScreen/views/autism_test.dart';
import 'package:voice_bridge/screens/parentScreen/views/parent_screen_view.dart';
import 'package:voice_bridge/screens/practiceScreen/views/practice_screen_view.dart';
import 'package:voice_bridge/screens/testScreen/views/test_dashboard_screen.dart';
import '../../screens/base/views/base_view.dart';
import '../../screens/learn_item_screen/balloon_blast/game_main.dart';
import '../../screens/sessionScreen/views/session_completion_view.dart';
import '../../screens/sessionScreen/views/session_view.dart';
import '../../screens/testScreen/views/test_completion_view.dart';
import '../../screens/testScreen/views/test_learning_view.dart';
import '../../screens/testScreen/views/test_question_view.dart';
import '../../screens/testScreen/views/test_screen.dart';

class AppRoutes {

  static appRoutes () => [
    GetPage(
        name: RoutesName.baseView,
        page: () => BaseView(),
        transitionDuration: const Duration(milliseconds: 250),
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
        name: RoutesName.balloonBlast,
        page: () => const BalloonBlastScreen(),
    ),
    GetPage(
      name: RoutesName.gameMain,
      page: () => const GameMain(),
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
      page: () => const AutismTest(),
    ),
  ];
}