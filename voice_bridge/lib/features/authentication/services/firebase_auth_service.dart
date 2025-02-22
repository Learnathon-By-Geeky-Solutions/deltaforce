import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  User? geCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    await userCredential.user?.sendEmailVerification();
    return userCredential;
  }

  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<User?> signInWithGoogle() async {
    try {
      // Ensure user is signed out before sign-in
      await _googleSignIn.signOut();

      // Start Google Sign-In process
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return null; // User canceled the login
      }

      // Retrieve authentication details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create Firebase credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      return userCredential.user;
    } catch (e) {
      print("❌ Google Sign-In Error: $e");
      return null;
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
