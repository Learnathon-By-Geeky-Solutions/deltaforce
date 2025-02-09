import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voice_bridge/features/authentication/view_models/auth_view_model.dart';
import 'package:voice_bridge/widgets/custom_button.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  final AuthViewModel _authController = Get.put(AuthViewModel());
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
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
              text: "Login",
              onPressed: () async {
                await _authController.signIn(emailController.text, passwordController.text);
              },
            ),
            TextButton(
              onPressed: () => Get.to(() => SignupScreen()),
              child: Text("Don't have an account? Sign up"),
            ),
          ],
        ),
      ),
    );
  }
}
