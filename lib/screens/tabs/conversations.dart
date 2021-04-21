import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Conversations extends StatefulWidget {
  @override
  _ConversationsState createState() => _ConversationsState();
}

class _ConversationsState extends State<Conversations> {
  String userID = FirebaseAuth.instance.currentUser.uid;

  @override
  Widget build(BuildContext context) {
    int chats = 0;
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('users').doc(userID);

    docRef.get().then(
      (snapshot) {
        chats = snapshot.data()['chatCount'];
      },
    );
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: getDocument(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Text(snapshot.data["chat"].toString());
            } else if (snapshot.connectionState == ConnectionState.none) {
              return Text("No data");
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  //Widgets:
  Widget customListTile() {
    return ListTile(leading: Image.asset('assets/white-robot.jpg'));
  }

  Future<DocumentSnapshot> getDocument() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser.uid;
    return FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser)
        .get();
  }
}
