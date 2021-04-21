import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);

  // This line listens for sign in status changes and will update Widget tree based on if some body is signed in or not
  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  //Sign out method
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Sign in method
  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Sign up method
  Future<String> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Account successfully created!";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> addUser(String userName) async {
    try {
      String userID = _firebaseAuth.currentUser.uid;
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      if (userID != null) {
        return users.doc(userID).set({
          'username': userName,
          'chatCount': 0,
          'balance': 1000000,
        });
      }
    } catch (e) {
      return e.message;
    }
  }

  //Useful getter
  Future<String> getUID() async {
    try {
      String userid = _firebaseAuth.currentUser.uid;
      return userid;
    } catch (e) {
      return e.message;
    }
  }
}
