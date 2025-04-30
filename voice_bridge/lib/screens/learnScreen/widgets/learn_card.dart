import 'package:flutter/material.dart';
import '../../../resources/colors/app_color.dart';

class LearnCard extends StatelessWidget {
  final String name;
  final String image;
  final Color color;
  final VoidCallback onTap;

  const LearnCard({
    super.key,
    required this.name,
    required this.image,
    required this.color,
    required this.onTap,
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
          // boxShadow: [
            // BoxShadow(
            //   color: Colors.white,
            //   blurRadius: 4,
            //   offset: Offset(0, 5),
            //   spreadRadius: 2,
            // ),
          // ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16), // You can change 16 to your desired corner radius
              child: Image.asset(
                image,
                height: 150,
                fit: BoxFit.cover,
              ),
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
          ],
        )

      ),
    );
  }
}
