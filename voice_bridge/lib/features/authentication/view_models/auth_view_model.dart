import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:voice_bridge/features/authentication/services/firebase_auth_service.dart';
import 'package:voice_bridge/features/authentication/const/app_strings.dart';
import 'package:voice_bridge/resources/routes/routesName.dart';

class AuthViewModel extends GetxController {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final Rx<User?> _user = Rx<User?>(null);
  final RxBool _isLoading = false.obs;
  final RxString _error = ''.obs;

  User? get user => _user.value;
  bool get isLoading => _isLoading.value;
  String get error => _error.value;

  @override
  void onInit() {
    super.onInit();
    print('AuthViewModel initialized');
    _authService.authStateChanges.listen(_handleAuthChange);
  }

  void _handleAuthChange(User? firebaseUser) {
    print('Auth state changed. Current user: ${firebaseUser?.email}');
    _user.value = firebaseUser;
    if (firebaseUser != null) {
      Get.offAllNamed(RoutesName.baseView);
    } else {
      Get.offAllNamed(RoutesName.loginScreen);
    }
  }

  void checkUserLoggedIn() {
    print('Checking if user is logged in...');
    _handleAuthChange(_authService.getCurrentUser());
  }

  Future<void> signUp(String email, String password) async {
    try {
      _isLoading.value = true;
      print('Signing up...');
      await _authService.signUpWithEmailAndPassword(email, password);
      print('Signup successful');
      Get.snackbar(AppStrings.successful, AppStrings.signupSuccess);
    } catch (e) {
      print('Signup error: $e');
      _error.value = e.toString();
      Get.snackbar(AppStrings.error, AppStrings.signupError);
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      _isLoading.value = true;
      print('Signing in...');
      final userCredential = await _authService.signInWithEmailAndPassword(email, password);
      await _authService.reloadUser();

      if (!userCredential.user!.emailVerified) {
        print('Email not verified');
        Get.snackbar(AppStrings.emailVerification, AppStrings.emailVerificationError);
        await _authService.signOut();
        return;
      }

      print('Sign-in successful');
      Get.snackbar(AppStrings.successful, AppStrings.loginSuccess);
    } catch (e) {
      print('Sign-in error: $e');
      _error.value = e.toString();
      Get.snackbar(AppStrings.error, AppStrings.signinError);
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      _isLoading.value = true;
      print('Attempting Google sign-in...');
      final user = await _authService.signInWithGoogle();
      if (user == null) throw Exception(AppStrings.googleSignInFailed);
      print('Google sign-in successful');
      Get.snackbar(AppStrings.successful, AppStrings.googleSignInSuccess);
    } catch (e) {
      print('Google sign-in error: $e');
      _error.value = e.toString();
      Get.snackbar(AppStrings.error, AppStrings.googleSignInFailed);
    } finally {
      _isLoading.value = false;
    }
  }
}
