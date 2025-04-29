import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:voice_bridge/resources/colors/app_color.dart';
import 'package:voice_bridge/utils/message.dart';

class FirebaseAuthService extends GetxController {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookAuth _facebookAuth;

  FirebaseAuthService({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
    FacebookAuth? facebookAuth,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,_googleSignIn = googleSignIn ?? GoogleSignIn(),_facebookAuth = facebookAuth ?? FacebookAuth.instance;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges(); User? getCurrentUser() => _firebaseAuth.currentUser;

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        Get.snackbar(
          Message.googleSignInFailed, Message.cancelled,
          backgroundColor: AppColor.buttonColor,
          duration: Get.testMode
              ? const Duration(milliseconds: 100)
              : null, // 👈 ADD THIS
        );
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      Get.snackbar(
        Message.signupError, "Error: $e",
        backgroundColor: AppColor.buttonColor,
        duration: Get.testMode
            ? const Duration(milliseconds: 100)
            : null, // 👈 ADD THIS
      );
      return null;
    }
  }

  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> updatePassword(
      String currentPassword, String newPassword) async {
    final user = _firebaseAuth.currentUser;
    if (user != null && user.email != null) {
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
    }
  }

  Future<void> reloadUser() async {
    await _firebaseAuth.currentUser?.reload();
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
    await _facebookAuth.logOut();
  }
}
