import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:voice_bridge/features/authentication/const/app_strings.dart';
import 'package:voice_bridge/features/authentication/view_models/auth_view_model.dart';
import 'package:voice_bridge/features/language/language_toggle.dart';
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
  final RxString _currentLanguage = 'en_US'.obs;


  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'sign_up'.tr,
          style: TextStyle(
              color: AppColor.whiteColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Obx(() => Icon(
              _currentLanguage.value == 'en_US'
                  ? Icons.language
                  : Icons.translate,
              color: AppColor.whiteColor,
            )),
            onPressed: _toggleLanguage,
          ),
        ],

        backgroundColor: AppColor.appBarColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
             Text(
              'create_account'.tr,
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
              text: 'sign_up'.tr,
              onPressed: _handleSignUp,
            ),
            const SizedBox(height: 20),
             Text(
              "or_continue_with".tr,
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
        labelText: 'name'.tr,
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
        labelText: 'email'.tr,
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
        labelText: 'password'.tr,
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
        labelText: 'password'.tr,
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
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(FontAwesomeIcons.google, color: Colors.red),
          SizedBox(width: 10),
          Text('sign_up_with_google'.tr),
        ],
      ),
    );
  }
//Language Toggle
  void _toggleLanguage() {
    if (_currentLanguage.value == 'en_US') {
      Get.updateLocale(const Locale('bn', 'BD'));
      _currentLanguage.value = 'bn_BD';
    } else {
      Get.updateLocale(const Locale('en', 'US'));
      _currentLanguage.value = 'en_US';
    }
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
