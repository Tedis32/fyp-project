import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project/models/message.dart';

class FirebaseService {
  // ignore: unused_field
  FirebaseService _firebaseService;

  static Future<void> uploadMessage(
      String userID, String message, int index) async {
    final messagesRef =
        FirebaseFirestore.instance.collection('chats/$userID/messages');
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('users').doc(userID);
    int chat;
    await docRef.get().then(
      (snapshot) {
        chat = snapshot.data()['chatCount'];
      },
    );

    final newMessage = Message(
      userID: userID,
      message: message,
      timeStamp: DateTime.now(),
      chatnumber: chat,
      index: index,
    );
    await messagesRef.add(newMessage.toJson());
  }

  Future<void> incrementchatcount(userID) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('users').doc(userID);
    docRef.update({
      'chatCount': FieldValue.increment(1),
    });
  }

  Future<double> getBalance() async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid);
    docRef.get().then((DocumentSnapshot snapshot) {
      return snapshot['balance'];
    });
  }
}
