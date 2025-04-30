import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../testScreen/controllers/test_controller.dart';

class TestCompletionView extends StatelessWidget {
  const TestCompletionView({super.key});

  @override
  Widget build(BuildContext context) {
    final TestController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('SCORE'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Obx(() {
        final result = controller.result.value;

        return Column(
          children: [
            _buildTitleSection(result),
            _buildAnimationSection(result),
            _buildButtonSection(controller),
          ],
        );
      }),
    );
  }

  Widget _buildTitleSection(int result) {
    return Expanded(
      flex: 3,
      child: Center(
        child: Text(
          _getResultTitle(result),
          style: const TextStyle(
            fontSize: 50,
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildAnimationSection(int result) {
    return Expanded(
      flex: 16,
      child: Center(
        child: DotLottieLoader.fromAsset(
          _getLottieAssetPath(result),
          frameBuilder: (ctx, dotlottie) {
            if (dotlottie != null) {
              return Lottie.memory(dotlottie.animations.values.single);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget _buildButtonSection(TestController controller) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
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
            child: const Icon(Icons.arrow_forward_outlined),
          ),
        ),
      ),
    );
  }

  String _getResultTitle(int result) {
    if (result >= 90) return "Excellent!";
    if (result >= 75) return "Great job!";
    if (result >= 50) return "Well done!";
    return "Try again";
  }

  String _getLottieAssetPath(int result) {
    if (result >= 90) {
      return 'lib/resources/assets/Others/animations/badge-3.lottie';
    } else if (result >= 75) {
      return 'lib/resources/assets/Others/animations/badge-2.lottie';
    } else if (result >= 50) {
      return 'lib/resources/assets/Others/animations/badge-1.lottie';
    } else {
      return 'lib/resources/assets/Others/animations/no-star.lottie';
    }
  }
}
