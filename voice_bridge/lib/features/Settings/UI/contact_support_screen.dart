import 'package:flutter/material.dart';
import 'package:voice_bridge/resources/colors/app_color.dart';

class ContactSupportScreen extends StatelessWidget {
  const ContactSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Support', style: TextStyle(color: AppColor.whiteColor)),
        backgroundColor: AppColor.appBarColor,
      ),
      body: const Center(
        child: Text(
          'You can email us at support@voicebridge.com',
          style: TextStyle(fontSize: 18, color: AppColor.primaryTextColor),
        ),
      ),
    );
  }
}