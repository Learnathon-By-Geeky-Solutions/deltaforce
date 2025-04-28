import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voice_bridge/features/authentication/view_models/auth_view_model.dart';
import 'package:voice_bridge/resources/colors/app_color.dart';
import 'package:voice_bridge/resources/routes/routes_name.dart';
import 'package:voice_bridge/features/authentication/const/app_strings.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final AuthViewModel _authViewModel = Get.find<AuthViewModel>();
  final TextEditingController _emailController = TextEditingController();

  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password',style: TextStyle(color: AppColor.whiteColor),),
        backgroundColor: AppColor.appBarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter your registered email to receive a reset link.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.buttonColor,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              onPressed: () async {
                final email = _emailController.text.trim();
                if (email.isNotEmpty) {
                  await _authViewModel.resetPassword(email);
                  Get.offAllNamed(RoutesName.loginScreen);
                } else {
                  Get.snackbar(
                    AppStrings.error,
                    'Please enter your email address.',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              child: const Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}
