import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/sessionController.dart';

class SessionCompletionView extends StatelessWidget {
  final SessionController controller = Get.find();

  SessionCompletionView({super.key});
  // const SessionCompletionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Completed'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body:  Column(
        children: [
          Expanded(
            flex: 21,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.check_circle, size: 100, color: Colors.green),
                    const SizedBox(height: 20),
                    const Text(
                      'Congratulations!',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'You have successfully completed the session.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              )),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 40,right: 40,top: 16,bottom: 16),
            child: SizedBox(
                width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.goToNextLesson,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Next Session',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
            ),
            )
          )
        ],
      ),
    );

  }
}
