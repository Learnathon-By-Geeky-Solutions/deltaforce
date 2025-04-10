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
    {"category": "Shape Matching", "image": "lib/resources/assets/Others/images/shape.jpg", "color": AppColor.cardGreenColor, "route": RoutesName.shapeMatching},
    {"category": "Balloon Blast", "image": "lib/resources/assets/Others/images/balloonBlast.jpg", "color": AppColor.cardOrangeColor, "route": RoutesName.balloonBlast},
    {"category": "Living Skill", "image": "lib/resources/assets/Others/images/living.jpg", "color": AppColor.cardRedColor, "route": RoutesName.livingSkill},
    {"category": "Family", "image": "lib/resources/assets/Others/images/family.jpg", "color": AppColor.cardPurpleColor, "route": RoutesName.family},
    {"category": "Study", "image": "lib/resources/assets/Others/images/study.jpg", "color": AppColor.cardYellowColor, "route": RoutesName.study},
    {"category": "Emotion", "image": "lib/resources/assets/Others/images/emotion.jpg", "color": AppColor.cardGreenColor, "route": RoutesName.emotion},
    {"category": "Profession", "image": "lib/resources/assets/Others/images/profession.jpg", "color": AppColor.cardOrangeColor, "route": RoutesName.profession},
    {"category": "Music", "image": "lib/resources/assets/Others/images/music.jpg", "color": AppColor.cardRedColor, "route": RoutesName.music},
    {"category": "Psychological", "image": "lib/resources/assets/Others/images/psychological.jpg", "color": AppColor.cardPurpleColor, "route": RoutesName.psychologicalEducation},
    {"category": "Social Skill", "image": "lib/resources/assets/Others/images/communication.jpg", "color": AppColor.cardYellowColor, "route": RoutesName.socialAndCommunicationSkill},

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
            name: item['category'],
            image: item['image'],
            color: item['color'],
            onTap: () => controller.startSession(item['category']),
          );
        },
      ),
    );
  }
}
