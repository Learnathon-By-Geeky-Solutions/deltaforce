import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:voice_bridge/screens/testScreen/controllers/test_controller.dart';
import '../../../resources/routes/routes_name.dart';
import '../../base/controllers/base_controller.dart';
import '../widgets/test_session_card.dart';
import 'package:get/get.dart';

class TestDashboardScreen extends StatelessWidget {
  final TestController controller = Get.find();
  final BaseController baseController = Get.find();

  TestDashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black, size: 30),
            onPressed: () {
              baseController.selectedIndex.value = 0;
              Get.offNamed(RoutesName.baseView);
            },
          ),
          title: Text(
            controller.testCurrentCategory,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned.fill(
              child: DotLottieLoader.fromAsset(
                  "lib/resources/assets/Others/animations/falling-snow.lottie",
                  frameBuilder: (ctx, dotlottie) {if (dotlottie != null) {return SizedBox.expand(child: Lottie.memory(dotlottie.animations.values.single,fit: BoxFit.cover,repeat: true,),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
            ),
            Obx(() {
              final category = controller.testCurrentCategory;
              final totalSessions = controller.totalSession[category] ?? 0;
              var topUnlockSession = controller.testTopSessionLevel[category]!;

              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 1),
                itemCount: totalSessions,
                itemBuilder: (context, index) {
                  int pos = index % 2;
                  bool isUnlocked =
                      index < controller.testTopSessionLevel[category]!;
                  return Align(
                    alignment: (pos == 0)
                        ? const Alignment(-0.4, 0)
                        : const Alignment(0.4, 0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 16),
                      child: GestureDetector(
                        onTap: isUnlocked
                            ? () =>
                                controller.testStartSession(category, index + 1)
                            : null,
                        child: TestSessionCard(
                          index: index + 1,
                          isUnlocked: isUnlocked,
                          testScore: controller.testScores(category, index + 1),
                          isLastUnlocked: topUnlockSession == index + 1,
                        ),
                      ),
                    ),
                  );
                },
              );
            })
          ],
        ));
  }
}
