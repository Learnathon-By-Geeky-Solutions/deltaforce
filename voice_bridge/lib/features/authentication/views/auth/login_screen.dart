import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:voice_bridge/features/authentication/const/app_strings.dart';
import 'package:voice_bridge/features/authentication/view_models/auth_view_model.dart';
import 'package:voice_bridge/features/authentication/views/auth/signup_screen.dart';
import 'package:voice_bridge/resources/colors/app_color.dart';
import 'package:voice_bridge/widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  final AuthViewModel _authController = Get.find();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final RxBool _obscurePassword = true.obs;
  final RxString _currentLanguage = 'en_US'.obs;

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'login'.tr,
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
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),
             Text("welcome_back".tr,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            _buildEmailField(),
            const SizedBox(height: 20),
            _buildPasswordField(),
            const SizedBox(height: 30),
            CustomButton(
              text: "login".tr,
              onPressed: _handleLogin,
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () {
                Get.to(() => SignupScreen());
              },
              child:  Text("dont_have_an_account".tr, style: TextStyle(color: Colors.blue)),
            ),
            const SizedBox(height: 20),
             Text("or_continue_with".tr, style: TextStyle(color: Colors.grey)),
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
        labelText: "email".tr,
        prefixIcon: const Icon(Icons.email),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _buildPasswordField() {
    return Obx(
      () => TextField(
        controller: _passwordController,
        obscureText: _obscurePassword.value,
        decoration: InputDecoration(
          labelText: "password".tr,
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
      ),
    );
  }

  Widget _buildGoogleSignInButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        side: const BorderSide(color: Colors.grey), //
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: _handleGoogleLogin,
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(FontAwesomeIcons.google, color: Colors.red),
          SizedBox(width: 10),
          Text("sign_in_with".tr),
        ],
      ),
    );
  }

  void _toggleLanguage() {
    if (_currentLanguage.value == 'en_US') {
      Get.updateLocale(const Locale('bn', 'BD'));
      _currentLanguage.value = 'bn_BD';
    } else {
      Get.updateLocale(const Locale('en', 'US'));
      _currentLanguage.value = 'en_US';
    }
  }

  void _handleLogin() async {
    _showLoadingDialog();
    await _authController.signIn(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    ); //
    _hideLoadingDialog();
  }

  void _handleGoogleLogin() async {
    // _showLoadingDialog();
    await _authController.signInWithGoogle();
    _hideLoadingDialog();
  }

  void _showLoadingDialog() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (_) => Container(
        color: Colors.black.withOpacity(0.2),
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: IntrinsicWidth(
              child: Text(
                "Signing you in...",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _hideLoadingDialog() {
    if (Get.isDialogOpen ?? false) Get.back();
  }
}
