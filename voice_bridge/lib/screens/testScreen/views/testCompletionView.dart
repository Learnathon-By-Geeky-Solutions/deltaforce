import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../testScreen/controllers/testController.dart';

class TestCompletionView extends StatelessWidget {
  final TestController controller = Get.find();

  TestCompletionView({super.key});

  // const SessionCompletionView({super.key});

  @override
  Widget build(BuildContext context) {
    int result = controller.result.value;
    print("result = $result");

    return Scaffold(
      appBar: AppBar(
        title: const Text('SCORE'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              flex: 3,
              child: Center(
                child:Text( result >= 90
                    ? "Excellent!"
                    : result >= 75
                    ? 'Great job!'
                    : result >= 50
                    ? 'Well done!'
                    : 'Try again',
                  style: const TextStyle(  fontSize: 50, color: Colors.green,fontWeight: FontWeight.bold),
                )
              )),
          Expanded(
              flex: 16,
              child: Center(
                child: DotLottieLoader.fromAsset(
                    result >= 90
                        ? 'lib/resources/assets/Others/animations/badge-3.lottie'
                        : result >= 75
                            ? 'lib/resources/assets/Others/animations/badge-2.lottie'
                            : result >= 50
                                ? 'lib/resources/assets/Others/animations/badge-1.lottie'
                                : 'lib/resources/assets/Others/animations/no-star.lottie',
                    frameBuilder: (ctx, dotlottie) {
                  if (dotlottie != null) {
                    return Lottie.memory(dotlottie.animations.values.single);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
              )),
          Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 40, right: 40, top: 16, bottom: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: controller.checkButtonActivity,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Icon(Icons.arrow_forward_outlined)),
                ),
              ))
        ],
      ),
    );
  }
}
