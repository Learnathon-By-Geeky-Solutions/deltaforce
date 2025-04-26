import 'package:flutter/material.dart';
import 'package:voice_bridge/resources/colors/app_color.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double width;

  const CustomButton({
    super.key,
    required this.text,
    this.color = AppColor.buttonColor,
    this.width = double.infinity,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        onPressed: onPressed,
        child: Text(text, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }
}
