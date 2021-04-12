import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseService {
  // ignore: unused_field
  FirebaseService _firebaseService;

  Future<void> addMessage(String userID, String message, int index) async {
    try {
      CollectionReference chats =
          FirebaseFirestore.instance.collection('chats');
      return chats.doc(userID).set({
         'Messages': message,
      });
    } catch (e) {
      return e.message;
    }
  }

  Future<void> createNewChat(userID) {
    CollectionReference chats = FirebaseFirestore.instance.collection('chats');
    return chats.doc().set({
      'Messages': [],
    });
  }

  Future<void> getMessages(userID, chatID) async {

    DocumentReference doc = FirebaseFirestore.instance.collection('chats').doc(chatID).


  }

}
