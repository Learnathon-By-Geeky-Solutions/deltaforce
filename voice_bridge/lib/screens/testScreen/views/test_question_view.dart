import 'package:delayed_display/delayed_display.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../resources/routes/routes_name.dart';
import '../controllers/test_controller.dart';

class TestQuestionView extends StatelessWidget {
  final TestController controller = Get.find();

  TestQuestionView({super.key});

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
                    child: DelayedDisplay(
                      delay: const Duration(milliseconds: 200),
                      child: DotLottieLoader.fromAsset("lib/resources/assets/Others/animations/confused.lottie",
                          frameBuilder: (ctx, dotlottie) {
                            return Lottie.memory(dotlottie!.animations.values.single);
                          }
                      ),
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
                              child: DelayedDisplay(
                                delay: const Duration(milliseconds: 200),
                                child: DotLottieLoader.fromAsset(lesson.lessons[optionIndex].animationAsset,
                                    frameBuilder: (ctx, dotlottie) {
                                      return Lottie.memory(dotlottie!.animations.values.single);
                                    }
                                    ),
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
                  color: Colors.black.withAlpha((0.4*255).toInt()),
                  child: Center(
                    child: DelayedDisplay(
                      delay: const Duration(milliseconds: 200),
                      child: DotLottieLoader.fromAsset(
                          controller.isAnswerCorrect.value
                                ? 'lib/resources/assets/Others/animations/tick-mark.lottie'
                                : 'lib/resources/assets/Others/animations/crossmark.lottie',
                           frameBuilder: (ctx, dotlottie) {
                               return Lottie.memory(dotlottie!.animations.values.single);
                           }
                       ),
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
