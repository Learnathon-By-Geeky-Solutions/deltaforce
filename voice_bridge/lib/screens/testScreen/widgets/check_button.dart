import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/test_controller.dart';

class CheckButton extends StatelessWidget {
  final TestController controller = Get.find();

  CheckButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, top: 16, bottom: 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: controller.isCheckButtonDisabled.value
              ? null
              : () {
                  controller.checkButtonActivity();
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Check',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
