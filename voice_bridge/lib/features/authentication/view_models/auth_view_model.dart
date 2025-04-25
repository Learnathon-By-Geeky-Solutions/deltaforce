import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:voice_bridge/features/authentication/services/firebase_auth_service.dart';
import 'package:voice_bridge/features/authentication/const/app_strings.dart';
import 'package:voice_bridge/resources/routes/routesName.dart';

class AuthViewModel extends GetxController {
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
  final Rx<User?> _user = Rx<User?>(null);
  final RxBool _isLoading = false.obs;
  final RxString _error = ''.obs;

  User? get user => _user.value;
  bool get isLoading => _isLoading.value;
  String get error => _error.value;

  @override
  void onInit() {
    super.onInit();
    _firebaseAuthService.authStateChanges.listen(_handleAuthChange);
  }

  void _handleAuthChange(User? firebaseUser) {
    _user.value = firebaseUser;
    if (firebaseUser != null) {
      if (Get.currentRoute != RoutesName.baseView) {
        Get.offAllNamed(RoutesName.baseView);
      }
    } else {
      if (Get.currentRoute != RoutesName.loginScreen) {
        Get.offAllNamed(RoutesName.loginScreen);
      }
    }
  }

  void checkUserLoggedIn() {
    _handleAuthChange(_firebaseAuthService.getCurrentUser());
  }

  Future<void> signUp(String email, String password) async {
    try {
      _isLoading.value = true;
      final userCredential = await _firebaseAuthService.signUpWithEmailAndPassword(email, password);
      _user.value = userCredential.user;
      Get.snackbar(
        AppStrings.successful,
        AppStrings.signupSuccess,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      _error.value = e.toString();
      Get.snackbar(
        AppStrings.error,
        AppStrings.signupError,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      _isLoading.value = true;
      final userCredential = await _firebaseAuthService.signInWithEmailAndPassword(email, password);
      await _firebaseAuthService.reloadUser();

      if (!userCredential.user!.emailVerified) {
        Get.snackbar(
          AppStrings.emailVerification,
          AppStrings.emailVerificationError,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        await _firebaseAuthService.signOut();
        return;
      }

      _user.value = userCredential.user;
      Get.snackbar(
        AppStrings.successful,
        AppStrings.loginSuccess,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      _error.value = e.toString();
      Get.snackbar(
        AppStrings.error,
        AppStrings.signinError,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      _isLoading.value = true;
      final user = await _firebaseAuthService.signInWithGoogle();
      if (user == null) throw Exception('Google Sign-In returned null user');
      _user.value = user;
      Get.snackbar(
        AppStrings.successful,
        AppStrings.googleSignInSuccess,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      _error.value = e.toString();
      Get.snackbar(
        AppStrings.error,
        AppStrings.googleSignInFailed,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      _isLoading.value = false;
    }
  }
}
