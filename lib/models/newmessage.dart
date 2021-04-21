import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project/screens/tabs/chat.dart';
import 'package:fyp_project/services/firebaseservice.dart';
import 'package:provider/provider.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
  final int index;
  NewMessage({this.index});
}

class _NewMessageState extends State<NewMessage> {
  bool tts;

  @override
  Widget build(BuildContext context) {
    return tts == true
        ? Chat(
            enabledTTS: tts,
            increment: context
                .read<FirebaseService>()
                .incrementchatcount(FirebaseAuth.instance.currentUser.uid),
          )
        : tts == false
            ? Chat(
                enabledTTS: tts,
                increment: context
                    .read<FirebaseService>()
                    .incrementchatcount(FirebaseAuth.instance.currentUser.uid),
              )
            : Scaffold(
                body: Center(
                  child: TextButton(
                      onPressed: () async {
                        Widget allowButton = TextButton(
                          child: Text("Allow"),
                          onPressed: () async {
                            this.tts = true;
                            setState(() {});
                            Navigator.pop(context);
                          },
                        );
                        Widget dontAllowButton = TextButton(
                          child: Text("Do not allow"),
                          onPressed: () async {
                            tts = false;

                            setState(() {});
                            Navigator.pop(context);
                          },
                        );
                        AlertDialog alert = AlertDialog(
                          title: Text("Alert"),
                          content: Text("Allow text to speech?"),
                          actions: [
                            allowButton,
                            dontAllowButton,
                          ],
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      },
                      child: Text('Click to start conversation')),
                ),
              );
  }
}
