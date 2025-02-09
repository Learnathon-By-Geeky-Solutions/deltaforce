

import 'package:get/get.dart';
import 'package:voice_bridge/features/authentication/const/app_strings.dart';
import 'package:voice_bridge/features/authentication/models/user.dart';
import 'package:voice_bridge/features/authentication/services/firebase_auth_service.dart';
import 'package:voice_bridge/features/authentication/views/auth/login_screen.dart';
import 'package:voice_bridge/features/authentication/views/home/home_screen.dart';

class AuthViewModel extends GetxController {
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
  final Rx<UserModel?> _user = Rx<UserModel?>(null);
  UserModel? get user => _user.value;

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final RxString _error = ''.obs;
  String get error => _error.value;

  @override
  void onInit() {
    super.onInit();
    _firebaseAuthService.authStateChanges.listen((firebaseUser) {
      _user.value = firebaseUser != null
          ? UserModel(uid: firebaseUser.uid, email: firebaseUser.email)
          : null;
    });
  }

  @override
  void onClose() {
    _user.close();
    _isLoading.close();
    _error.close();
    super.onClose();
  }

  Future<void> signUp(String email, String password) async {
    try {
      _isLoading.value = true;
      await _firebaseAuthService.signUpWithEmailAndPassword(email, password);
      Get.snackbar("Success", AppStrings.signupSuccess);
      Get.to(() => LoginScreen());
    } catch (e) {
      _error.value = e.toString();
      Get.snackbar("Error", AppStrings.signupError);
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
        Get.snackbar("Verify Email", AppStrings.emailVerificationError);
        await _firebaseAuthService.signOut();
        return;
      }
      Get.snackbar("Success", AppStrings.loginSuccess);
      Get.to(() => HomeScreen());
    } catch (e) {
      _error.value = e.toString();
      Get.snackbar("Error", AppStrings.signinError);
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    try {
      _isLoading.value = true;
      await _firebaseAuthService.signOut();
      Get.snackbar("Success", AppStrings.signoutSuccess);
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }
}


/*Rx (Reactive) variables in GetX allow
 real-time state management and automatic 
 UI updates without needing setState().

Rx<T> is a reactive wrapper around a variable.
When the value changes,
all widgets listening to it update automatically.
 */
