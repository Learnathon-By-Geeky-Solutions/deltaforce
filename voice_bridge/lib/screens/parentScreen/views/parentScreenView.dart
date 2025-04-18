import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:voice_bridge/screens/parentScreen/controllers/autismController.dart';
import 'package:voice_bridge/widgets/custom_button.dart';
import 'package:get/get.dart';

import '../../../resources/routes/routesName.dart';
import '../widgets/tipCard.dart';

class ParentScreenView extends StatelessWidget {
  ParentScreenView({super.key});
  final AutismController controller = Get.put(AutismController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Parent Dashboard"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(height: 16,),

            Obx(()=> CircularPercentIndicator(
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

            SizedBox(height: 16,),

            CustomButton(text: "Start Test",color: Colors.green,width: 150, onPressed: ()=> Get.toNamed(RoutesName.autismTestScreen)),

            SizedBox(height: 16,),
            Text("Tips for Supporting Your Child",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(24),
              ),

              child: Column(
                children: const [
                  TipCard("Use hand gestures when speaking", "Gestures help children understand meaning better and connect words with actions."),
                  TipCard("Talk gently and slowly", "This creates a calm environment and makes it easier for your child to process words."),
                  TipCard("Talk gently and slowly","This will write later"),
                  TipCard("Use hand gestures when speaking","This will write later"),
                  TipCard("Celebrate small achievements","This will write later"),
                  TipCard("Keep eye contact gently","This will write later"),
                  TipCard("Use routines and visuals","This will write later"),
                  TipCard("Talk gently and slowly","This will write later"),
                  TipCard("Use hand gestures when speaking","This will write later"),
                  TipCard("Celebrate small achievements","This will write later"),
                  TipCard("Keep eye contact gently","This will write later"),
                  TipCard("Use routines and visuals","This will write later"),
                ],
              ),
            ),
            SizedBox(height: 100,)


          ],
        )),
      ),
    );
  }
}
