import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  // ignore: unused_field
  FirebaseService _firebaseService;

  Future<void> addMessage(String userID, String message) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      CollectionReference chats = users.doc(userID).collection('chats');
      return chats.doc().set({
        'Messages': message,
      });
    } catch (e) {
      return e.message;
    }
  }
}
