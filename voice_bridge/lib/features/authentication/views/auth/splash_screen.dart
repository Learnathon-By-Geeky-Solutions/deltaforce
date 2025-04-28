import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voice_bridge/features/authentication/const/app_strings.dart';
import 'package:voice_bridge/features/authentication/view_models/auth_view_model.dart';

class SplashScreen extends StatelessWidget {
  final AuthViewModel _authViewModel = Get.find<AuthViewModel>();

  SplashScreen({super.key}) {
    Future.delayed(const Duration(seconds: 2), () {
      _authViewModel.checkUserLoggedIn();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // App Logo
                Image.asset(
                  'assets/appLogo.png',
                  height: 120,
                ),
                const SizedBox(height: 20),
                // App Name
                Text(
                  AppStrings.appName,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
          // Loading Indicator at Bottom
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
