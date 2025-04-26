import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/autism_controller.dart';

class AutismTest extends StatefulWidget {
  const AutismTest({super.key});

  @override
  State<AutismTest> createState() => _AutismTestState();
}

class _AutismTestState extends State<AutismTest> {
  final AutismController controller = Get.find();

  // Store answers
  List<int> ratingAnswers = List.filled(3, 5); // default value 5
  List<bool?> yesNoAnswers = List.filled(3, null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Autism Test"),
        backgroundColor: Colors.indigoAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              "Rate the following from 1 (Low) to 10 (High)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            buildRatingQuestion(0, "How often does the child avoid eye contact?"),
            buildRatingQuestion(1, "How often does the child repeat words or actions?"),
            buildRatingQuestion(2, "How much difficulty does the child have understanding instructions?"),

            const SizedBox(height: 20),
            const Text(
              "Answer Yes / No",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            buildYesNoQuestion(0, "Does the child respond when their name is called?"),
            buildYesNoQuestion(1, "Does the child show interest in playing with others?"),
            buildYesNoQuestion(2, "Does the child understand simple gestures (like waving)?"),

            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (yesNoAnswers.contains(null)) {
                  Get.snackbar("Incomplete", "Please answer all Yes/No questions",
                      backgroundColor: Colors.redAccent,
                      colorText: Colors.white);
                  return;
                }

                controller.calculateFromAnswers(ratingAnswers, yesNoAnswers.cast<bool>());
                Get.back(); // Return to dashboard
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigoAccent,
                  foregroundColor: Colors.white),
              child: const Text("Submit Test"),
            )
          ],
        ),
      ),
    );
  }

  Widget buildRatingQuestion(int index, String question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question, style: const TextStyle(fontSize: 16)),
        Slider(
          value: ratingAnswers[index].toDouble(),
          min: 1,
          max: 10,
          divisions: 9,
          label: ratingAnswers[index].toString(),
          onChanged: (value) {
            setState(() {
              ratingAnswers[index] = value.toInt();
            });
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget buildYesNoQuestion(int index, String question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question, style: const TextStyle(fontSize: 16)),
        Row(
          children: [
            Expanded(
              child: RadioListTile<bool>(
                title: const Text("Yes"),
                value: true,
                groupValue: yesNoAnswers[index],
                onChanged: (val) {
                  setState(() {
                    yesNoAnswers[index] = val;
                  });
                },
              ),
            ),
            Expanded(
              child: RadioListTile<bool>(
                title: const Text("No"),
                value: false,
                groupValue: yesNoAnswers[index],
                onChanged: (val) {
                  setState(() {
                    yesNoAnswers[index] = val;
                  });
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
