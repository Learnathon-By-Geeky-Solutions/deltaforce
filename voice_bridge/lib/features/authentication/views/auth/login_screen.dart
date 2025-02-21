import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:voice_bridge/features/authentication/const/app_strings.dart';
// import 'package:voice_bridge/features/authentication/services/firebase_auth_service.dart';
import 'package:voice_bridge/features/authentication/view_models/auth_view_model.dart';
import 'package:voice_bridge/features/authentication/views/auth/signup_screen.dart';
import 'package:voice_bridge/resources/routes/routes_name.dart';
import 'package:voice_bridge/widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  final AuthViewModel _authController = Get.put(AuthViewModel());
  // final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.login)),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
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
              controller: emailController,
              decoration: InputDecoration(labelText: AppStrings.email),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: AppStrings.password),
              obscureText: true,
            ),
            SizedBox(height: 20),
            CustomButton(
              text: AppStrings.login,
              onPressed: () async {
                await _authController.signIn(
                  emailController.text,
                  passwordController.text,
                );

                // Navigate to HomeScreen if user is authenticated
                if (_authController.user != null) {
                  // Get.to(() => HomeScreen());
                  Get.toNamed(RoutesName.baseView);
                }
              },
            ),
            TextButton(
              onPressed: () => Get.to(() => SignupScreen()),
              child: Text(AppStrings.dontHaveAccount),
            ),
          ],
        ),
      ),
    );
  }
}
