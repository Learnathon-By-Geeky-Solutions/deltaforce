import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:voice_bridge/features/authentication/const/app_strings.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<UserCredential> signUpWithEmailAndPassword(String email, String password) async {
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    await userCredential.user?.sendEmailVerification();
    return userCredential;
  }

  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    return _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> signInWithGoogle() async {
  try {
    // print("Starting Google Sign-In...");

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      // print("Google Sign-In canceled by user.");
      return Future.error(AppStrings.googleSignInAborted);
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    // User? user = userCredential.user;

    // print("✅ Google Sign-In Success!");
    // print("👤 User Email: ${user?.email}");
    // print("🆔 Provider: ${user?.providerData.map((e) => e.providerId).toList()}");

    return userCredential;
  } catch (e) {
    // print("❌ Google Sign-In Error: $e");
    return Future.error(e);
  }
}


  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }

  Future<void> reloadUser() async {
    await _firebaseAuth.currentUser?.reload();
  }
}
