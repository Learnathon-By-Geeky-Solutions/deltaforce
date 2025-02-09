import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //Stream ensures app always reacts to authentication changes in real time.
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Sign up with email and password
  Future<UserCredential> signUpWithEmailAndPassword(String email, String password) async{
    UserCredential userCredential =  await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    await userCredential.user?.sendEmailVerification();
    return userCredential;
  }

  //sing in with email and password
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async{
    return _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  //sign out
  Future<void> signOut() async{
    return _firebaseAuth.signOut();
  }

  bool isEmailVerified(){
    return _firebaseAuth.currentUser?.emailVerified ?? false;
  }

  Future<void> reloadUser() async{
    await _firebaseAuth.currentUser?.reload();
  }
}