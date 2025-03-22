import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voice_bridge/resources/routes/routesName.dart';

import '../../../resources/colors/app_color.dart';
import '../../sessionScreen/controllers/sessionController.dart';
import '../widgets/learn_card.dart';

class LearnScreenView extends StatelessWidget {
  LearnScreenView({super.key});

  final SessionController controller = Get.put(SessionController());


  final List<Map<String, dynamic>> learnItems = [
    {"name": "Shape Matching", "image": "lib/resources/assets/images/shape.jpg", "color": AppColor.cardGreenColor, "route": RoutesName.shapeMatching},
    {"name": "Balloon Blast", "image": "lib/resources/assets/images/balloonBlast.jpg", "color": AppColor.cardOrangeColor, "route": RoutesName.balloonBlast},
    {"name": "Living Skill", "image": "lib/resources/assets/images/living.jpg", "color": AppColor.cardRedColor, "route": RoutesName.livingSkill},
    {"name": "Family", "image": "lib/resources/assets/images/family.jpg", "color": AppColor.cardPurpleColor, "route": RoutesName.family},
    {"name": "Study", "image": "lib/resources/assets/images/study.jpg", "color": AppColor.cardYellowColor, "route": RoutesName.study},
    {"name": "Emotion", "image": "lib/resources/assets/images/emotion.jpg", "color": AppColor.cardGreenColor, "route": RoutesName.emotion},
    {"name": "Profession", "image": "lib/resources/assets/images/profession.jpg", "color": AppColor.cardOrangeColor, "route": RoutesName.profession},
    {"name": "Music", "image": "lib/resources/assets/images/music.jpg", "color": AppColor.cardRedColor, "route": RoutesName.music},
    {"name": "Psychological", "image": "lib/resources/assets/images/psychological.jpg", "color": AppColor.cardPurpleColor, "route": RoutesName.psychologicalEducation},
    {"name": "Social Skill", "image": "lib/resources/assets/images/communication.jpg", "color": AppColor.cardYellowColor, "route": RoutesName.socialAndCommunicationSkill},

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: EdgeInsets.fromLTRB(12,12,12,100),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,

        ),
        itemCount: learnItems.length,
        itemBuilder: (context, index) {
          final item = learnItems[index];
          return LearnCard(
            name: item['name'],
            image: item['image'],
            color: item['color'],
            onTap: () => controller.startSession(item['name']),
          );
        },
      ),
    );
  }
}
