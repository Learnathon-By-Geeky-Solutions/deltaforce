import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static void show(String title, String message, {bool isError = false}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: isError ? Colors.red : Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(10),
    );
  }
}
