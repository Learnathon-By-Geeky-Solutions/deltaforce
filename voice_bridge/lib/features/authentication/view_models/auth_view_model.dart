import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:voice_bridge/features/authentication/const/app_strings.dart';
import 'package:voice_bridge/features/authentication/services/firebase_auth_service.dart';
import 'package:voice_bridge/resources/routes/routes_name.dart';

class AuthViewModel extends GetxController {
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
  final Rx<User?> _user = Rx<User?>(null);
  User? get user => _user.value;

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final RxString _error = ''.obs;
  String get error => _error.value;

  @override
  void onInit() {
    super.onInit();
    _firebaseAuthService.authStateChanges.listen((firebaseUser) {
      _user.value = firebaseUser;
    });
  }

  @override
  void onClose() {
    _user.close();
    _isLoading.close();
    _error.close();
    super.onClose();
  }

void checkUserLoggedIn() {
  _firebaseAuthService.authStateChanges.listen((User? user) {
    if (user != null) {
      Get.offAll(() => HomeScreen());  // Use `Get.offAll` to clear splash screen from the stack
    } else {
      Get.offAll(() => LoginScreen());
    }
  });
}


  Future<void> signUp(String email, String password) async {
    try {
      _isLoading.value = true;
      await _firebaseAuthService.signUpWithEmailAndPassword(email, password);
      Get.snackbar(AppStrings.successful, AppStrings.signupSuccess);
      // Get.to(() => HomeScreen());
      Get.toNamed(RoutesName.baseView);
    } catch (e) {
      _error.value = e.toString();
      Get.snackbar(AppStrings.error, AppStrings.signupError);
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
        Get.snackbar(AppStrings.emailVerification, AppStrings.emailVerificationError);
        await _firebaseAuthService.signOut();
        return;
      }
      Get.snackbar(AppStrings.successful, AppStrings.loginSuccess);
      // Get.to(() => HomeScreen());
      Get.toNamed(RoutesName.baseView);

    } catch (e) {
      _error.value = e.toString();
      Get.snackbar(AppStrings.error, AppStrings.signinError);
    } finally {
      _isLoading.value = false;
    }
  }

Future<void> signInWithGoogle() async {
  try {
    _isLoading.value = true;
    
    User? user = await _firebaseAuthService.signInWithGoogle();

    if (user == null) {
      Get.snackbar(AppStrings.error, AppStrings.googleSignInFailed);
      return;
    }

    _user.value = user;
    Get.snackbar(AppStrings.successful, AppStrings.googleSignInSuccess);
    // Get.to(() => HomeScreen());
    Get.toNamed(RoutesName.baseView);

  } catch (e) {
    _error.value = e.toString();
    Get.snackbar(AppStrings.error, AppStrings.googleSignInFailed);
  } finally {
    _isLoading.value = false;
  }
}

}
