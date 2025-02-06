import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voice_bridge/view_models/auth_view_model.dart';
import 'package:voice_bridge/views/auth/login_screen.dart';
import 'package:voice_bridge/widgets/custom_button.dart';

class SignupScreen extends StatelessWidget {
  final AuthViewModel _authController = Get.find<AuthViewModel>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _clearField(){
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            CustomButton(
              text: "Sign Up",
              onPressed: () async {
                await _authController.signUp(emailController.text, passwordController.text);
                _clearField();
              },
            ),
            TextButton(
              onPressed: () => Get.back(),
              child: Text("Already have an account? Login"),
            ),
          ],
        ),
      ),
    );
  }
}
