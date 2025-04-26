import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../resources/routes/routes_name.dart';
import '../controllers/test_controller.dart';

class TestQuestionView extends StatelessWidget {
  final TestController controller = Get.find();

  TestQuestionView({super.key});
  // final BaseController baseController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        var lesson = controller.testCurrentSession.value!;
        final selected = controller.selectedIndex.value;
        var testCurrentSessionLevel = controller.startedSessionLevel.value;
        return Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, size: 30),
                        onPressed: () {
                          // baseController.selectedIndex.value = 0;
                          // Get.offNamed(RoutesName.baseView);// go to learn page
                          Get.offNamed(RoutesName.testDashboardScreen);
                        },
                      ),
                      Text(
                        'Session: $testCurrentSessionLevel',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // Options grid (4 options)
                Expanded(
                  flex: 3,
                    child: DotLottieLoader.fromAsset("lib/resources/assets/Others/animations/confused.lottie",
                        frameBuilder: (ctx, dotlottie) {
                          if (dotlottie != null) {
                            return Lottie.memory(dotlottie.animations.values.single);
                          } else {
                            return const Center(child: CircularProgressIndicator());
                          }
                        }
                    ),
                ),
                Expanded(
                  flex: 12,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                      ),
                      itemCount: controller.options.length,
                      itemBuilder: (context, index) {
                        int optionIndex = controller.options[index];
                        bool isSelected = selected == optionIndex;
                        return GestureDetector(
                            onTap: () {
                              controller.selectedIndex.value = optionIndex;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                    isSelected ? Colors.pinkAccent : Colors.black,
                                    width: 3),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: DotLottieLoader.fromAsset(lesson.lessons[optionIndex].animationAsset,
                                  frameBuilder: (ctx, dotlottie) {
                                    if (dotlottie != null) {
                                      return Lottie.memory(dotlottie.animations.values.single);
                                    } else {
                                      return const Center(child: CircularProgressIndicator());
                                    }
                                  }
                                  ),
                            )
                        );
                      },
                    ),
                  ),
                ),

                // Check button
                Expanded(
                  flex: 3 ,// Small section
                  child: Center(
                    child: Text(
                      lesson.lessons[controller.correctIndex].lessonName,
                      style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),


            // Feedback animation overlay
            Obx(() {
              if (controller.showFeedbackAnimation.value) {
                return Container(
                  color: Colors.black.withOpacity(0.4),
                  child: Center(
                    child: DotLottieLoader.fromAsset(
                        controller.isAnswerCorrect.value
                              ? 'lib/resources/assets/Others/animations/tick-mark.lottie'
                              : 'lib/resources/assets/Others/animations/crossmark.lottie',
                        // "lib/resources/assets/Others/animations/confused.lottie",
                         frameBuilder: (ctx, dotlottie) {
                           if (dotlottie != null) {
                             return Lottie.memory(dotlottie.animations.values.single);
                           } else {
                             return const Center(child: CircularProgressIndicator());
                           }
                         }
                     ),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
          ],
        );
      }),
    );
  }
}
