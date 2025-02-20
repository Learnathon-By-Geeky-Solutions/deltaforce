import 'package:get/get.dart';
import 'package:voice_bridge/resources/routes/routes_name.dart';
import 'package:voice_bridge/screens/home/views/home_view.dart';
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


    GetPage(
        name: RoutesName.shapeMatching,
        page: () => ShapeMatchingScreen(),
        transitionDuration: Duration(milliseconds: 250),
        transition: Transition.noTransition
    ),

    GetPage(
        name: RoutesName.balloonBlast,
        page: () => BalloonBlastScreen(),
        transitionDuration: Duration(milliseconds: 250),
        transition: Transition.noTransition
    ),

    GetPage(
        name: RoutesName.livingSkill,
        page: () => LivingSkillScreen(),
        transitionDuration: Duration(milliseconds: 250),
        transition: Transition.noTransition
    ),

    GetPage(
        name: RoutesName.family,
        page: () => FamilyScreen(),
        transitionDuration: Duration(milliseconds: 250),
        transition: Transition.noTransition
    ),

    GetPage(
        name: RoutesName.study,
        page: () => StudyScreen(),
        transitionDuration: Duration(milliseconds: 250),
        transition: Transition.noTransition
    ),

    GetPage(
        name: RoutesName.emotion,
        page: () => EmotionScreen(),
        transitionDuration: Duration(milliseconds: 250),
        transition: Transition.noTransition
    ),

    GetPage(
        name: RoutesName.profession,
        page: () => ProfessionScreen(),
        transitionDuration: Duration(milliseconds: 250),
        transition: Transition.noTransition
    ),

    GetPage(
        name: RoutesName.music,
        page: () => MusicScreen(),
        transitionDuration: Duration(milliseconds: 250),
        transition: Transition.noTransition
    ),

    GetPage(
        name: RoutesName.psychologicalEducation,
        page: () => PsychologicalScreen(),
        transitionDuration: Duration(milliseconds: 250),
        transition: Transition.noTransition
    ),

    GetPage(
        name: RoutesName.socialAndCommunicationSkill,
        page: () => SocialSkillScreen(),
        transitionDuration: Duration(milliseconds: 250),
        transition: Transition.noTransition
    ),
  ];
}