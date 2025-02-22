import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voice_bridge/features/authentication/const/app_strings.dart';
import 'package:voice_bridge/features/authentication/view_models/auth_view_model.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {

  final AuthViewModel _authViewModel = Get.find<AuthViewModel>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      _authViewModel.checkUserLoggedIn();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Text(
          AppStrings.appName,
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
