import 'package:flutter/material.dart';
import 'package:voice_bridge/resources/colors/app_color.dart';


class FAQsScreen extends StatelessWidget {
  const FAQsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs', style: TextStyle(color: AppColor.whiteColor),),
        backgroundColor: AppColor.appBarColor,
      ),
      body: const Center(
        child: Text(
          'Frequently Asked Questions coming soon.',
          style: TextStyle(fontSize: 18, color: AppColor.primaryTextColor),
        ),
      ),
    );
  }
}

