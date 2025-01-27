import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //sign up with email and password
  Future<User?> signUp(String email, String password) async{
    try{
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch(e){
      print("SignUp Error: $e");
      return null;
    }
  }

  //Login with email and password
  Future<User?> login(String email, String password) async{
    try{
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch(e){
      print("Login Error");
      return null;
    }
  }

  //Logout User
  Future<void> logout() async{
    await _firebaseAuth.signOut();
  }

  //Get currently logged-in user
  User? getCurrentUser(){
    return _firebaseAuth.currentUser;
  }


}