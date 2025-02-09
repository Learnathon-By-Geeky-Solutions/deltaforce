import 'package:flutter/material.dart';
import 'package:voice_bridge/features/authentication/const/app_strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(AppStrings.homeScreen),
      ),
    );
  }
}