import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:voice_bridge/features/authentication/const/app_strings.dart';
import 'package:voice_bridge/features/authentication/view_models/auth_view_model.dart';
import 'package:voice_bridge/features/authentication/views/auth/forgot_password_screen.dart';
import 'package:voice_bridge/features/authentication/views/auth/signup_screen.dart';
import 'package:voice_bridge/resources/colors/app_color.dart';
import 'package:voice_bridge/widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  final AuthViewModel _authController = Get.find();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final RxBool _obscurePassword = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.login,
          style: TextStyle(color: AppColor.whiteColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColor.appBarColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 40),
            Text("Welcome Back", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 30),
            _buildEmailField(),
            SizedBox(height: 20),
            _buildPasswordField(),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Get.to(ForgotPasswordScreen()) ,
                child: const Text('Forgot Password?'),
              ),
            ),
            SizedBox(height: 30),
            CustomButton(
              text: AppStrings.login,
              onPressed: _handleLogin,
            ),
            SizedBox(height: 15),
            TextButton(
              onPressed: () => Get.to(() => SignupScreen()),
              child: Text(AppStrings.dontHaveAccount, style: TextStyle(color: Colors.blue)),
            ),
            SizedBox(height: 20),
            Text("or continue with", style: TextStyle(color: Colors.grey)),
            SizedBox(height: 20),
            _buildGoogleSignInButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: AppStrings.email,
        prefixIcon: Icon(Icons.email),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _buildPasswordField() {
    return Obx(() => TextField(
      controller: _passwordController,
      obscureText: _obscurePassword.value,
      decoration: InputDecoration(
        labelText: AppStrings.password,
        prefixIcon: Icon(Icons.lock),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword.value ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () => _obscurePassword.toggle(),
        ),
      ),
    ));
  }

  Widget _buildGoogleSignInButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        side: BorderSide(color: Colors.grey),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: _handleGoogleLogin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(FontAwesomeIcons.google, color: Colors.red),
          SizedBox(width: 10),
          Text("Sign in with Google"),
        ],
      ),
    );
  }

  void _handleLogin() async {
    await _authController.signIn(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
    _hideLoadingDialog();
  }

  void _handleGoogleLogin() async {
    await _authController.signInWithGoogle();
    _hideLoadingDialog();
  }

  void _hideLoadingDialog() {
    if (Get.isDialogOpen ?? false) Get.back();
  }
}
