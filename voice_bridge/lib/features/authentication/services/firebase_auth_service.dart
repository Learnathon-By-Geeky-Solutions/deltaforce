import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  User? getCurrentUser() => _firebaseAuth.currentUser;

  Future<UserCredential> signUpWithEmailAndPassword(String email, String password) async {
    print('Attempting to sign up with email: $email');
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    print('User signed up: ${userCredential.user?.uid}');
    await userCredential.user?.sendEmailVerification();
    print('Email verification sent');
    return userCredential;
  }

  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    print('Attempting to sign in with email: $email');
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    print('User signed in: ${userCredential.user?.uid}');
    return userCredential;
  }

  Future<User?> signInWithGoogle() async {
    try {
      print('Starting Google sign-in...');
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print('Google sign-in aborted by user.');
        return null;
      }

      print('Google user signed in: ${googleUser.email}');
      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(credential);
      print('Firebase user after Google sign-in: ${userCredential.user?.uid}');
      return userCredential.user;
    } catch (e) {
      print('Error during Google sign-in: $e');
      rethrow;
    }
  }

  Future<void> reloadUser() async {
    print('Reloading user info...');
    await _firebaseAuth.currentUser?.reload();
    print('User info reloaded.');
  }

  Future<void> signOut() async {
    print('Signing out...');
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
    print('User signed out.');
  }
}
