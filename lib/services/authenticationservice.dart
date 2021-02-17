import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);

  // This line listens for sign in status changes and will update Widget tree based on if some body is signed in or not
  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  //Sign out method
  Future <void> signOut ()async{
    await _firebaseAuth.signOut();
  }
  
  // Sign in method
  Future <String> signIn ({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
          return "Signed In";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
  // Sign up method
  Future<String> signUp ({String email, String password}) async {
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return "Account successfully created!";
    } on FirebaseAuthException catch (e) {
    return e.message;

    }
  }
}
