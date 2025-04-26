import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../resources/colors/app_color.dart';
import '../../../resources/routes/routesName.dart';
import '../../testScreen/controllers/testController.dart';
import '../widgets/practice_learn_card.dart';

class PracticeScreenView extends StatelessWidget {
  PracticeScreenView({super.key});

  final TestController controller = Get.put(TestController());

  final List<Map<String, dynamic>> learnItems = [
   {"category": "Study", "image": "lib/resources/assets/Others/images/study.jpg", "color": AppColor.cardYellowColor, "route": RoutesName.study},
    {"category": "Living Skill", "image": "lib/resources/assets/Others/images/living.jpg", "color": AppColor.cardRedColor, "route": RoutesName.livingSkill},
    {"category": "Family", "image": "lib/resources/assets/Others/images/family.jpg", "color": AppColor.cardPurpleColor, "route": RoutesName.family},
    {"category": "Emotion", "image": "lib/resources/assets/Others/images/emotion.jpg", "color": AppColor.cardGreenColor, "route": RoutesName.emotion},
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
          return PracticeLearnCard(
            name: item['category'],
            image: item['image'],
            color: item['color'],
            percentage: (controller.testTopSessionLevel[item['category']]!/20),

            // onTap: () => Get.toNamed(item['route']),
            // onTap: () => controller.testStartSession(item['category']),
            onTap: () => controller.gotoDashboard(item['category']),


            // onTap: () => Get.to(StudyScreen()),
          );
        },
      ),
    );
  }
}
