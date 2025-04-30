import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.login,
          style: TextStyle(color: AppColor.whiteColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColor.appBarColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text("Welcome Back", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            _buildEmailField(),
            const SizedBox(height: 20),
            _buildPasswordField(),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Get.to(() => ForgotPasswordScreen()),
                child: const Text('Forgot Password?'),
              ),
            ),
            const SizedBox(height: 30),
            CustomButton(
              text: AppStrings.login,
              onPressed: _handleLogin,
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () => Get.to(() => SignupScreen()),
              child: const Text(AppStrings.dontHaveAccount, style: TextStyle(color: Colors.blue)),
            ),
            const SizedBox(height: 20),
            const Text("or continue with", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
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
        prefixIcon: const Icon(Icons.email),
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
        prefixIcon: const Icon(Icons.lock),
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
        minimumSize: const Size(double.infinity, 50),
        side: const BorderSide(color: Colors.grey),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: _handleGoogleLogin,
      child: const Row(
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
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // --- Validation ---
    if (email.isEmpty) {
      Get.snackbar('Error', 'Please enter your email');
      return;
    }
    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Error', 'Please enter a valid email');
      return;
    }
    if (password.isEmpty) {
      Get.snackbar('Error', 'Please enter your password');
      return;
    }
    if (password.length < 6) {
      Get.snackbar('Error', 'Password must be at least 6 characters');
      return;
    }

    _showLoadingDialog();

    await _authController.signIn(email, password);

    _hideLoadingDialog();
  }

  void _handleGoogleLogin() async {
    _showLoadingDialog();
    await _authController.signInWithGoogle();
    _hideLoadingDialog();
  }

  void _showLoadingDialog() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (_) =>const Dialog(
        backgroundColor: Colors.transparent,
        child: Center(
          child: SpinKitFadingCircle(
            color: AppColor.appBarColor,
            size: 50.0,
          ),
        ),
      ),
    );
  }

  void _hideLoadingDialog() {
    if (Get.isDialogOpen ?? false) Get.back();
  }
}
