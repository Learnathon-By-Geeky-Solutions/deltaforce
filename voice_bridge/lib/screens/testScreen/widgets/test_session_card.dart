import 'package:delayed_display/delayed_display.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:voice_bridge/resources/colors/app_color.dart';
class TestSessionCard extends StatelessWidget {
  final int index;
  final bool isUnlocked;
  final Future<int> testScore;
  final bool isLastUnlocked;

  const TestSessionCard(
      {super.key,
      required this.index,
      required this.isUnlocked,
      required this.testScore,
      required this.isLastUnlocked});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 80,
          height: 90,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isUnlocked ? isLastUnlocked? AppColor.testCardStartBlueColor: AppColor.testCardUnlockGreenColor: AppColor.testCardLockGrayColor,
            boxShadow:[
              BoxShadow(
                  color: AppColor.testCardUnlockGreenColor.withAlpha((AppColor.testLockCardOpacity * 255).toInt()),
                  blurRadius: 10,
                  spreadRadius: 2)
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (isLastUnlocked)
                Positioned(
                  top: -30, // Adjust height as needed
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: DelayedDisplay(
                      delay: const Duration(milliseconds: 200),
                      child: DotLottieLoader.fromAsset(
                        "lib/resources/assets/Others/animations/start.lottie",
                        frameBuilder: (ctx, dotlottie) {
                          if (dotlottie == null || dotlottie.animations.isEmpty) {
                            return const SizedBox.shrink(); // or fallback animation
                          }
                          return Lottie.memory(dotlottie.animations.values.single);
                        },
                      ),

                    ),
                  ),
                ),
              Positioned(
                top: isLastUnlocked ? 25 : 15,
                child: Text(
                  '$index',
                  style: TextStyle(
                      fontSize: isLastUnlocked ? 24:30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 15,
          child: FutureBuilder<int>(
            future: testScore,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox.shrink(); // or a loading spinner
              } else if (snapshot.hasError || !snapshot.hasData) {
                return const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, size: 18, color: Colors.white),
                    Icon(Icons.star, size: 25, color: Colors.white),
                    Icon(Icons.star, size: 18, color: Colors.white),
                  ],
                );
              }

              final score = snapshot.data!;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    size: 18,
                    color: score >= 50 ? Colors.yellowAccent : Colors.white,
                  ),
                  Icon(
                    Icons.star,
                    size: 25,
                    color: score >= 75 ? Colors.yellowAccent : Colors.white,
                  ),
                  Icon(
                    Icons.star,
                    size: 18,
                    color: score >= 90 ? Colors.yellowAccent : Colors.white,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
