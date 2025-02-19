import 'package:flutter/material.dart';
class PracticeScreenView extends StatefulWidget {
  const PracticeScreenView({super.key});

  @override
  State<PracticeScreenView> createState() => _PracticeScreenViewState();
}

class _PracticeScreenViewState extends State<PracticeScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Practice Screen")),
    );
  }
}
