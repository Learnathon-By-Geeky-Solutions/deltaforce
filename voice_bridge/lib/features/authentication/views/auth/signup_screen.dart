import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:voice_bridge/features/authentication/const/app_strings.dart';
import 'package:voice_bridge/features/authentication/view_models/auth_view_model.dart';
import 'package:voice_bridge/resources/colors/app_color.dart';
import 'package:voice_bridge/widgets/custom_button.dart';

class SignupScreen extends StatelessWidget {
  final AuthViewModel _authController = Get.find();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final RxBool _obscurePassword = true.obs;
  final RxBool _obscureConfirmPassword = true.obs;

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.signUp,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: AppColor.whiteColor)),
        backgroundColor: AppColor.appBarColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              AppStrings.createAccount,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            _buildNameField(),
            const SizedBox(height: 20),
            _buildEmailField(),
            const SizedBox(height: 20),
            _buildPasswordField(),
            const SizedBox(height: 20),
            _buildConfirmPasswordField(),
            const SizedBox(height: 30),
            CustomButton(
              text: AppStrings.signUp,
              onPressed: _handleSignUp,
            ),
            const SizedBox(height: 20),
            const Text(
              "Or continue with",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            _buildGoogleSignInButton(),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () => Get.back(),
              child: const Text(
                AppStrings.alreadyHaveAccount,
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return TextField(
      controller: _nameController,
      decoration: InputDecoration(
        labelText: AppStrings.userName,
        prefixIcon: const Icon(Icons.person),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Obx(() => TextField(
      controller: _passwordController,
      obscureText: _obscurePassword.value,
      decoration: InputDecoration(
        labelText: AppStrings.password,
        prefixIcon: const Icon(Icons.lock),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword.value ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () {
            _obscurePassword.toggle();
          },
        ),
      ),
    ));
  }

  Widget _buildConfirmPasswordField() {
    return Obx(() => TextField(
      controller: _confirmPasswordController,
      obscureText: _obscureConfirmPassword.value,
      decoration: InputDecoration(
        labelText: AppStrings.password,
        prefixIcon: const Icon(Icons.lock),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureConfirmPassword.value ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () {
            _obscureConfirmPassword.toggle();
          },
        ),
      ),
    ));
  }

  Widget _buildGoogleSignInButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        side: const BorderSide(color: Colors.grey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () => _authController.signInWithGoogle(),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(FontAwesomeIcons.google, color: Colors.red),
          SizedBox(width: 10),
          Text(AppStrings.signUpWithGoogle),
        ],
      ),
    );
  }

  void _handleSignUp() {
    if (_passwordController.text != _confirmPasswordController.text) {
      Get.snackbar(AppStrings.error, AppStrings.passwordMismatch);
      return;
    }
    _authController.signUp(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
  }
}
