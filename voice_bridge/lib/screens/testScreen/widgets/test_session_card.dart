import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
            color: isUnlocked ? isLastUnlocked?Colors.blue:Colors.green : Colors.grey.shade400,
            boxShadow: isUnlocked
                ? [
              BoxShadow(
                  color: Colors.green.withOpacity(0.4),
                  blurRadius: 10,
                  spreadRadius: 2)
            ]
                : [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
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
                    child: DotLottieLoader.fromAsset(
                      "lib/resources/assets/Others/animations/start.lottie",
                      frameBuilder: (ctx, dotlottie) {
                        if (dotlottie != null) {
                          return Lottie.memory(dotlottie.animations.values.single);
                        } else {
                          return const Center(child: CircularProgressIndicator());
                        }
                      },
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
              int stars = 0;
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData &&
                  isUnlocked) {
                final score = snapshot.data!;
                if (score >= 90) {
                  stars = 3;
                } else if (score >= 75) {
                  stars = 2;
                }else if (score >= 50) {
                  stars = 1;
                } else {
                  stars = 0;
                }
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (starIndex) {
                  return Icon(Icons.star,
                      size: starIndex == 1? 25: 18,
                      color: starIndex < stars ? Colors.yellowAccent : Colors.white);
                }),
              );
            },
          ),
        ),
      ],
    );
  }
}
