import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:voice_bridge/features/authentication/services/firebase_auth_service.dart';
import 'package:voice_bridge/features/authentication/const/app_strings.dart';
import 'package:voice_bridge/resources/routes/routesName.dart';

class AuthViewModel extends GetxController {
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
  final Rx<User?> _user = Rx<User?>(null);
  final RxString _error = ''.obs;

  User? get user => _user.value;
  String get error => _error.value;

  @override
  void onInit() {
    super.onInit();
    _firebaseAuthService.authStateChanges.listen(_handleAuthChange);
  }

  void _handleAuthChange(User? firebaseUser) async {
    _user.value = firebaseUser;

    if (firebaseUser != null) {
      await firebaseUser.reload();
      final currentUser = _firebaseAuthService.getCurrentUser();

      if (currentUser != null && currentUser.emailVerified) {
        if (Get.currentRoute != RoutesName.baseView) {
          Get.offAllNamed(RoutesName.baseView);
        }
      } else {
        await _firebaseAuthService.signOut();
        if (Get.currentRoute != RoutesName.loginScreen) {
          Get.offAllNamed(RoutesName.loginScreen);
        }
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
      final userCredential = await _firebaseAuthService.signUpWithEmailAndPassword(email, password);
      _user.value = userCredential.user;

      if (_user.value != null && !_user.value!.emailVerified) {
        await _user.value!.sendEmailVerification();
        Get.snackbar(
          AppStrings.emailVerification,
          AppStrings.emailVerification,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        await _waitForEmailVerification();
      }
    } catch (e) {
      _error.value = e.toString();
      Get.snackbar(
        AppStrings.error,
        AppStrings.signupError,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> _waitForEmailVerification() async {
    const int maxAttempts = 10;
    const Duration checkInterval = Duration(seconds: 3);
    int attempts = 0;

    while (attempts < maxAttempts) {
      await Future.delayed(checkInterval);
      await _firebaseAuthService.reloadUser();
      _user.value = _firebaseAuthService.getCurrentUser();

      if (_user.value?.emailVerified ?? false) break;

      attempts++;
    }

    if (_user.value?.emailVerified ?? false) {
      Get.snackbar(
        AppStrings.successful,
        'Email verified successfully. Please log in.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      await _firebaseAuthService.signOut();
      Get.offAllNamed(RoutesName.loginScreen);
    } else {
      Get.snackbar(
        AppStrings.emailVerification,
        'Email not verified. Please check again later.',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      await _firebaseAuthService.signOut();
      Get.offAllNamed(RoutesName.loginScreen);
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
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
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final user = await _firebaseAuthService.signInWithGoogle();
      if (user == null || !(user.emailVerified)) {
        throw Exception('Email is not verified');
      }
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
    }
  }
}
