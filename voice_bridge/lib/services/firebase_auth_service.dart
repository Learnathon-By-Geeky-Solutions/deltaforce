import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Sign up with email and password
  Future<UserCredential> signUpWithEmailAndPassword(String email, String password) async{
    return await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  //sing in with email and password
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async{
    return _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  //sign out
  Future<void> signOut() async{
    return _firebaseAuth.signOut();
  }
}