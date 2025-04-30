import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:voice_bridge/features/authentication/const/app_strings.dart';
import 'package:voice_bridge/features/authentication/view_models/auth_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  final AuthViewModel _authViewModel = Get.find<AuthViewModel>();
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      _authViewModel.checkUserLoggedIn();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
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
                 const Text(
                    AppStrings.appName,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Fancy Loading Indicator at Bottom
         const Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: SpinKitFadingCircle(
                color: Colors.blueAccent,
                size: 50.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
