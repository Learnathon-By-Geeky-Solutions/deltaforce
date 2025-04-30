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

  const TestSessionCard({
    super.key,
    required this.index,
    required this.isUnlocked,
    required this.testScore,
    required this.isLastUnlocked,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildCardCircle(),
        if (isLastUnlocked) _buildAnimatedBadge(),
        _buildIndexLabel(),
        Positioned(bottom: 15, child: _buildScoreStars()),
      ],
    );
  }

  Widget _buildCardCircle() {
    final color = isUnlocked
        ? (isLastUnlocked
        ? AppColor.testCardStartBlueColor
        : AppColor.testCardUnlockGreenColor)
        : AppColor.testCardLockGrayColor;

    return Container(
      width: 80,
      height: 90,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: AppColor.testCardUnlockGreenColor.withAlpha(
              (AppColor.testLockCardOpacity * 255).toInt(),
            ),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBadge() {
    return Positioned(
      top: -30,
      child: SizedBox(
        width: 100,
        height: 100,
        child: DelayedDisplay(
          delay: const Duration(milliseconds: 200),
          child: DotLottieLoader.fromAsset(
            "lib/resources/assets/Others/animations/start.lottie",
            frameBuilder: (ctx, dotlottie) {
              if (dotlottie == null || dotlottie.animations.isEmpty) {
                return const SizedBox.shrink();
              }
              return Lottie.memory(dotlottie.animations.values.single);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildIndexLabel() {
    return Positioned(
      top: isLastUnlocked ? 25 : 15,
      child: Text(
        '$index',
        style: TextStyle(
          fontSize: isLastUnlocked ? 24 : 30,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildScoreStars() {
    return FutureBuilder<int>(
      future: testScore,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.hasError) {
          return _buildDefaultStars();
        }

        final score = snapshot.data!;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star, size: 18, color: _getStarColor(score, 50)),
            Icon(Icons.star, size: 25, color: _getStarColor(score, 75)),
            Icon(Icons.star, size: 18, color: _getStarColor(score, 90)),
          ],
        );
      },
    );
  }

  Widget _buildDefaultStars() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.star, size: 18, color: Colors.white),
        Icon(Icons.star, size: 25, color: Colors.white),
        Icon(Icons.star, size: 18, color: Colors.white),
      ],
    );
  }

  Color _getStarColor(int score, int threshold) {
    return score >= threshold ? Colors.yellowAccent : Colors.white;
  }
}
