import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voice_bridge/features/Settings/UI/contact_support_screen.dart';
import 'package:voice_bridge/features/Settings/UI/faq_screen.dart';
import 'package:voice_bridge/features/Settings/UI/send_feed_back.dart';
import 'package:voice_bridge/resources/colors/app_color.dart';

class HelpAndFeedbackScreen extends StatelessWidget {
  const HelpAndFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Feedback', style: TextStyle(color: AppColor.whiteColor),),
        backgroundColor: AppColor.appBarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How can we assist you today?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColor.primaryTextColor,
              ),
            ),
            const SizedBox(height: 16),
            _buildListTile(
              context,
              Icons.help_outline,
              'FAQs',
              const FAQsScreen(),
            ),
            _buildListTile(
              context,
              Icons.feedback_outlined,
              'Send Feedback',
              const SendFeedbackScreen(),
            ),
            _buildListTile(
              context,
              Icons.contact_mail_outlined,
              'Contact Support',
              const ContactSupportScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(BuildContext context, IconData icon, String title, Widget screen) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: AppColor.navigationColor,
      child: ListTile(
        leading: Icon(icon, color: AppColor.primaryTextColor),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColor.primaryTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: () {
          Get.to(() => screen);
        },
      ),
    );
  }
}



