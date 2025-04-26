import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voice_bridge/features/authentication/view_models/auth_view_model.dart';
import 'package:voice_bridge/features/authentication/views/auth/forgot_password_screen.dart';
import 'package:voice_bridge/resources/colors/app_color.dart';

class PasswordUpdateScreen extends StatefulWidget {
  @override
  _PasswordUpdateScreenState createState() => _PasswordUpdateScreenState();
}

class _PasswordUpdateScreenState extends State<PasswordUpdateScreen> {
  final AuthViewModel _authViewModel = Get.find<AuthViewModel>();
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _reEnterNewPasswordController = TextEditingController();

  bool _isCurrentPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isReEnterPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Password',
          style: TextStyle(color: AppColor.whiteColor),
        ),
        backgroundColor: AppColor.appBarColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _currentPasswordController,
              obscureText: !_isCurrentPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Current Password',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isCurrentPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isCurrentPasswordVisible = !_isCurrentPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _newPasswordController,
              obscureText: !_isNewPasswordVisible,
              decoration: InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isNewPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isNewPasswordVisible = !_isNewPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _reEnterNewPasswordController,
              obscureText: !_isReEnterPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Re-enter New Password',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isReEnterPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isReEnterPasswordVisible = !_isReEnterPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                if (_newPasswordController.text !=
                    _reEnterNewPasswordController.text) {
                  Get.snackbar(
                    'Error',
                    'Passwords do not match',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                  return;
                }

                await _authViewModel.updatePassword(
                  _currentPasswordController.text,
                  _newPasswordController.text,
                );
              },
              child: Text('Update Password'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColor.buttonColor),
              ),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Get.to(ForgotPasswordScreen());
              },
              child: Text(
                'Forgot Password?',
                style: TextStyle(color: AppColor.buttonColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
