import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:voice_bridge/features/authentication/const/app_strings.dart';
import 'package:voice_bridge/features/authentication/view_models/auth_view_model.dart';
import 'package:voice_bridge/widgets/custom_button.dart';

class SignupScreen extends StatelessWidget {
  final AuthViewModel _authController = Get.put(AuthViewModel());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.signUp)),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(AppStrings.createAccount, style: TextStyle(fontSize: 30)),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                _authController.signInWithGoogle();
              },
              style: TextButton.styleFrom(
                minimumSize: Size(1000.0, 50.0),
                backgroundColor: Colors.blue,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(FontAwesomeIcons.google, color: Colors.white),
                  SizedBox(width: 10),
                  Text(AppStrings.signUpWithGoogle, style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: AppStrings.userName,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: AppStrings.email,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: AppStrings.password,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              obscureText: true,
            ),
            SizedBox(height: 10),
            TextField(
              controller: confirmPasswordController,
              decoration: InputDecoration(
                labelText: AppStrings.confirmPassword,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            CustomButton(
              text: AppStrings.signUp,
              onPressed: () {
                if (passwordController.text == confirmPasswordController.text) {
                  _authController.signUp(emailController.text, passwordController.text);
                } else {
                  Get.snackbar(AppStrings.error, AppStrings.passwordMismatch);
                }
              },
            ),
            TextButton(
              onPressed: () => Get.back(),
              child: Text(AppStrings.alreadyHaveAccount),
            ),
          ],
        ),
      ),
    );
  }
}
