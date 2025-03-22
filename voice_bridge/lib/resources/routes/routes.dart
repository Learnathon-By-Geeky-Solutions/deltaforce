import 'package:get/get.dart';
import 'package:voice_bridge/features/authentication/views/auth/login_screen.dart';
import 'package:voice_bridge/features/authentication/views/auth/signup_screen.dart';
import 'package:voice_bridge/features/authentication/views/auth/splash_screen.dart';
import 'package:voice_bridge/resources/routes/routesName.dart';
import 'package:voice_bridge/screens/learnScreen/views/learnScreenView.dart';
import 'package:voice_bridge/screens/learn_item_screen/balloon_blast/views/balloon_blast_screen.dart';
import 'package:voice_bridge/screens/learn_item_screen/emotion/views/emotion_screen.dart';
import 'package:voice_bridge/screens/learn_item_screen/family/views/family_screen.dart';
import 'package:voice_bridge/screens/learn_item_screen/living_skill/views/living_skill_screen.dart';
import 'package:voice_bridge/screens/learn_item_screen/music/views/music_screen.dart';
import 'package:voice_bridge/screens/learn_item_screen/profession/views/profession_screen.dart';
import 'package:voice_bridge/screens/learn_item_screen/psychological/views/psychological_screen.dart';
import 'package:voice_bridge/screens/learn_item_screen/shape_matching/views/shape_matching_screen.dart';
import 'package:voice_bridge/screens/learn_item_screen/social_skill/views/social_skill_screen.dart';
import 'package:voice_bridge/screens/learn_item_screen/study/views/study_screen.dart';
import 'package:voice_bridge/screens/parentScreen/views/parentScreenView.dart';
import 'package:voice_bridge/screens/practiceScreen/views/practiceScreenView.dart';

import '../../screens/base/views/base_view.dart';
import '../../screens/sessionScreen/views/sessionCompletionView.dart';
import '../../screens/sessionScreen/views/sessionView.dart';

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
        name: RoutesName.livingSkill,
        page: () => LivingSkillScreen(),
    ),

    GetPage(
        name: RoutesName.family,
        page: () => FamilyScreen(),
    ),

    GetPage(
        name: RoutesName.study,
        page: () => StudyScreen(),
    ),

    GetPage(
        name: RoutesName.emotion,
        page: () => EmotionScreen(),
    ),

    GetPage(
        name: RoutesName.profession,
        page: () => ProfessionScreen(),
    ),

    GetPage(
        name: RoutesName.music,
        page: () => MusicScreen(),
    ),

    GetPage(
        name: RoutesName.psychologicalEducation,
        page: () => PsychologicalScreen(),
    ),

    GetPage(
        name: RoutesName.socialAndCommunicationSkill,
        page: () => SocialSkillScreen(),
    ),

    GetPage(
      name: RoutesName.sessionView,
      page: () => SessionView(),
    ),

    GetPage(
      name: RoutesName.sessionCompletion,
      page: () => SessionCompletionView(),
    ),
  ];
}