import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:voice_bridge/models/user.dart';
import 'package:voice_bridge/services/firebase_auth_service.dart';
import 'package:voice_bridge/utils/message.dart';
import 'package:voice_bridge/views/auth/login_screen.dart';
import 'package:voice_bridge/views/home/home_screen.dart';

class AuthViewModel extends GetxController {
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

  //user state
  final Rx<UserModel?> _user = Rx<UserModel?>(null);
  UserModel? get user => _user.value;

  //Loading state
  final RxBool _isLoading = RxBool(false);
  bool get isLoading => _isLoading.value;

  //Error state
  final RxString _error = ''.obs;
  String get error => _error.value;

  @override
  void onInit() {
    super.onInit();

    // Listen to auth state changes
    _firebaseAuthService.authStateChanges.listen((firebaseUser) {
      _user.value = firebaseUser != null
          ? UserModel(uid: firebaseUser.uid, email: firebaseUser.email)
          : null;
    });
  }

  //Sign up with email and password
  Future<void> signUp(String email, String password)async{
    try{
      _isLoading.value = true;
      _error.value = '';

      await _firebaseAuthService.signUpWithEmailAndPassword(email, password);
            
      // Get.to(() => LoginScreen());
      Get.snackbar("Success", Message.verificationMessage);

      if(_firebaseAuthService.isEmailVerified()){
        Get.to(() => LoginScreen());
      }
      else{
        Get.snackbar("Error", "Error creating account");
      }
    } catch(e){
      _error.value = e.toString();
      Get.snackbar("Error", Message.signupError);
    } finally{
      _isLoading.value = false;
    }
  }

  //Sign in with email and password
  Future<void> singIn(String email, String password)async{
    try{
      _isLoading.value = true;
      _error.value = '';

      final UserCredential userCredential =  await _firebaseAuthService.signInWithEmailAndPassword(email, password);

      if(!userCredential.user!.emailVerified){
        Get.snackbar("Verify Email", "Please verify your email before log in");
        await _firebaseAuthService.signOut();
        return;
      }
      Get.snackbar("Success", Message.signinSuccess);
      Get.to(() => HomeScreen());
    }catch(e){
      _error.value = e.toString();
      Get.snackbar("Error", Message.signinError);
    }finally{
      _isLoading.value = false;
    }
  }

  //Sign out
  Future<void> signOut() async{
    try{
      _isLoading.value = true;
      _error.value = '';

      await _firebaseAuthService.signOut();
      Get.snackbar("Success", Message.signoutSuccess);
    }catch(e){
      _error.value = e.toString();
      Get.snackbar("Error", Message.signoutError);
    }finally{
      _isLoading.value = false;
    }
  }
}
