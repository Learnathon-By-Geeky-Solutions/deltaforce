import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../resources/colors/app_color.dart';

class PracticeLearnCard extends StatelessWidget {
  final String name;
  final String image;
  final Color color;
  final VoidCallback onTap;
  final double percentage;
  const PracticeLearnCard({
    super.key,
    required this.name,
    required this.image,
    required this.color,
    required this.onTap,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          // color: color.withOpacity(AppColor.cardOpacity),
          color: color.withAlpha((AppColor.cardOpacity* 255).toInt()),

          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            // color: color.withOpacity(AppColor.cardBorderOpacity),
            color: color.withAlpha((AppColor.cardBorderOpacity* 255).toInt()),

            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
                image,
                height: 130,
                // width: 80,
                fit: BoxFit.cover
            ),
            const SizedBox(height: 10),
            Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColor.cardTextColor,
              ),
            ),
            LinearPercentIndicator(
              animation: true,
              animationDuration: 1000,
              lineHeight: 20,
              percent: percentage,
              progressColor: Colors.deepPurple,
              backgroundColor: Colors.deepPurple.shade200,
              barRadius: const Radius.circular(10),
            ),
          ],
        ),
      ),
    );
  }
}
