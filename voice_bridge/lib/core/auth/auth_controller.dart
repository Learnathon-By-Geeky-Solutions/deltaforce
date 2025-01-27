import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:voice_bridge/core/auth/auth_repository.dart';

class AuthController extends GetxController {

  final AuthRepository _authRepository = AuthRepository();

  var isLoading = false.obs;
  var currentUser = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    currentUser.value = _authRepository.getCurrentUser();
  }

  //Sign up method
  Future<void> signUp(String email, String password) async{
    isLoading.value = true;
    User? user = await _authRepository.signUp(email, password);
    if(user != null){
      currentUser.value = user;
      Get.snackbar("Success", "Account created successfully");
      // Get.offAllNamed();
    } else {
      Get.snackbar("Error", "An error occurred while signing up");
    }
    isLoading.value = false;
  }

  //Login Function
  Future<void> login(String email, String password) async{
    isLoading.value = true;
    User? user = await _authRepository.login(email, password);
    if(user != null){
      currentUser.value = user;
      Get.snackbar("Success", "Logged in successfully");
      // Get.offAllNamed();
    } else {
      Get.snackbar("Error", "An error occurred while logging in");
    }
    isLoading.value = false;
  }

  // Logout Function
  void logout() async{
    await _authRepository.logout();
    currentUser.value = null;
    Get.snackbar("Success", "Logged out successfully");
    // Get.offAllNamed();
  }


}
