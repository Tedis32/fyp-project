import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Preface extends StatefulWidget {
  Preface({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _PrefaceState createState() => _PrefaceState();
}

class _PrefaceState extends State<Preface> {
  final _formKey = GlobalKey<FormState>();
  String name;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future upload(String name) async {
    await Firebase.initializeApp();

    // Test, upload document to firestore
    final refUser = FirebaseFirestore.instance.collection('user').doc();
    await refUser.set({'username': name});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat-Bot"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(25, 25, 25, 25),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    name = value;
                    return null;
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Center(
                    child: FloatingActionButton(
                      child: Text("Enter"),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          upload(name);
                          Navigator.pushNamed(context, '/second');
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('Processing Data')));
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
