import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../resources/routes/routesName.dart';
import '../../base/controllers/baseController.dart';
import '../controllers/sessionController.dart';

class SessionView extends StatelessWidget {
  final SessionController controller = Get.find();
  final BaseController baseController = Get.find();
  final String category = Get.arguments['category'];
  // final int sessionLevel = Get.arguments['sessionLevel'];
  final currentSession = Get.arguments['currentSession'];
  SessionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color similar to border
      body: Obx( () {
        int sessionLevel = controller.currentSessionLevel[category] as int;
        int currentLessonIndex = controller.currentLessonIndex.value;
        var lesson = currentSession.value!.lessons[currentLessonIndex];


        return SafeArea(
          child: Column(
            children: [
              // Back button and Session Level
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, size: 30),
                      onPressed: () {
                        baseController.selectedIndex.value = 1;
                        Get.offNamed(RoutesName.baseView);// go to learn page
                      },
                    ),
                    const SizedBox(width: 8), // Space between the icon and text
                    Text(
                      'Session: $sessionLevel',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Main Content divided into 3 sections
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: Column(
                    children: [
                      // 1️⃣ First Column (Biggest) - Image/Animation
                      Expanded(
                          flex: 16, // Takes most of the space
                          child: DotLottieLoader.fromAsset(lesson.animationAsset,
                              frameBuilder: (ctx, dotlottie) {
                                if (dotlottie != null) {
                                  return Lottie.memory(dotlottie.animations.values.single);
                                } else {
                                  return Container();
                                }
                              }),
                      ),

                      // 2️⃣ Second Column - Text
                      Expanded(
                        flex: 5 ,// Small section
                        child: Center(
                          child: Text(
                            lesson.lessonName,
                            style: const TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,

                            ),
                          ),
                        ),
                      ),

                      // 3️⃣ Third Column - Next Button
                      Expanded(
                        flex: 3, // Small section for button
                        // child: Container(color: Colors.red,),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40,right: 40,top: 16,bottom: 16),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: controller.goToNextLesson,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Next',
                                style: TextStyle(fontSize: 30, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );

      }),
    );
  }
}
