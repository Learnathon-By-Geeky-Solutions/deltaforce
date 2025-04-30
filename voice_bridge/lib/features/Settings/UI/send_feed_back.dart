import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voice_bridge/resources/colors/app_color.dart';

class SendFeedbackScreen extends StatelessWidget {
  const SendFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController feedbackController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Feedback', style: TextStyle(color: AppColor.whiteColor)),
        backgroundColor: AppColor.appBarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: feedbackController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Write your feedback here...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: AppColor.cardGreenColor.withValues(alpha: 0.1),
                contentPadding: const EdgeInsets.all(16),
              ),
              style:const TextStyle(color: AppColor.primaryTextColor),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
              ),
              onPressed: () {
                if (feedbackController.text.trim().isNotEmpty) {
                  Get.snackbar(
                    'Thank you!',
                    'Your feedback has been sent.',
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                  feedbackController.clear();
                } else {
                  Get.snackbar(
                    'Error',
                    'Please write some feedback first.',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              child: const Text(
                'Submit Feedback',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}