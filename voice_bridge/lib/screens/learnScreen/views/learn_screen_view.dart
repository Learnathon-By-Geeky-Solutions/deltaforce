import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voice_bridge/resources/routes/routes_name.dart';

import '../../../resources/colors/app_color.dart';
import '../../sessionScreen/controllers/session_controller.dart';
import '../widgets/learn_card.dart';

class LearnScreenView extends StatelessWidget {
  LearnScreenView({super.key});

  final SessionController controller = Get.put(SessionController());


  final List<Map<String, dynamic>> learnItems = [
    {"category": "Fruits Slice", "image": "lib/resources/assets/Others/images/balloonBlast.jpg", "color": AppColor.cardRedColor, "route": RoutesName.balloonBlast},
    {"category": "Study", "image": "lib/resources/assets/Others/images/study.jpg", "color": AppColor.cardGreenColor, "route": RoutesName.study},
    {"category": "Living Skill", "image": "lib/resources/assets/Others/images/living.jpg", "color": AppColor.cardPurpleColor, "route": RoutesName.livingSkill},
    {"category": "Family", "image": "lib/resources/assets/Others/images/family.jpg", "color": AppColor.cardOrangeColor, "route": RoutesName.family},
    {"category": "Emotion", "image": "lib/resources/assets/Others/images/emotion.jpg", "color": AppColor.cardYellowColor, "route": RoutesName.emotion},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: const EdgeInsets.fromLTRB(12,12,12,100),
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
