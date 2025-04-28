import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:voice_bridge/screens/parentScreen/controllers/autism_controller.dart';
import 'package:voice_bridge/screens/parentScreen/widgets/tips_card.dart';
import 'package:voice_bridge/widgets/custom_button.dart';
import 'package:get/get.dart';
import '../../../resources/routes/routes_name.dart';
import '../controllers/tip_controller.dart';

class ParentScreenView extends StatelessWidget {
  ParentScreenView({super.key});
  final AutismController controller = Get.put(AutismController());
  final TipController tipController = Get.put(TipController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Parent Dashboard"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => CircularPercentIndicator(
                radius: 100,
                animation: true,
                animationDuration: 1000,
                lineWidth: 30,
                percent: controller.score.value,
                center: Text("${controller.level}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                progressColor: controller.levelColor,
                backgroundColor: Colors.grey[300]!,
                circularStrokeCap: CircularStrokeCap.round,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            CustomButton(
                text: "Start Test",
                color: Colors.green,
                width: 150,
                onPressed: () => Get.toNamed(RoutesName.autismTestScreen)),
            const SizedBox(
              height: 16,
            ),
            const Text("Therapy Activities for",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            const Text("Language Development",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(24),
              ),
              child: Obx(() {
                if (tipController.tips.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: tipController.tips.map((tip) {
                    return TipCard(tip.title, tip.description);
                  }).toList(),
                );
              }),
            ),


            const SizedBox(
              height: 100,
            )
          ],
        )),
      ),
    );
  }
}
