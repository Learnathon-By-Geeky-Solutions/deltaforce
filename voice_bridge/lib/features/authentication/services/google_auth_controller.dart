import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInController with ChangeNotifier {
  final GoogleSignIn _googleSignIn;
  GoogleSignInAccount? googleUser;

  // Add a constructor that accepts GoogleSignIn
  GoogleSignInController([GoogleSignIn? googleSignIn])
      : _googleSignIn = googleSignIn ?? GoogleSignIn();

  Future<void> login() async {
    googleUser = await _googleSignIn.signIn();
    notifyListeners();
  }

  Future<void> logout() async {
    await _googleSignIn.signOut();
    googleUser = null;
    notifyListeners();
  }
}
