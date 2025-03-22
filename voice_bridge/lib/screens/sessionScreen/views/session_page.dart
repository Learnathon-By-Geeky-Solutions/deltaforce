import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/sessionController.dart';

class SessionPage extends StatelessWidget {
  final SessionController controller = Get.find();
  // final SessionController controller = Get.put(SessionController());
  final String category = Get.arguments['category'];
  final int sessionLevel = Get.arguments['sessionLevel'];
  final currentSession = Get.arguments['currentSession'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$category - Session $sessionLevel")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Session $sessionLevel", style: TextStyle(fontSize: 22)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.saveSession(category, sessionLevel + 1); // Move to next session
                Get.back(); // Return to category screen
              },
              child: Text("Complete & Next"),
            ),
          ],
        ),
      ),
    );
  }
}
