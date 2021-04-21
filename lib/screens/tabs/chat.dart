import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp_project/models/chatface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:flutter_dialogflow/v2/auth_google.dart';
import 'package:fyp_project/models/newmessage.dart';
import 'package:fyp_project/services/firebaseservice.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
  final bool enabledTTS;
  final Future<void> increment;
  final Widget chatwidget;
  const Chat({Key key, this.enabledTTS, this.increment, this.chatwidget})
      : super(key: key);
}

// Setting up the Chat interface state, getting it to interact with DialogFlow
class _ChatState extends State<Chat> with AutomaticKeepAliveClientMixin {
  String userID = FirebaseAuth.instance.currentUser.uid;
  int index;
  bool conversationStarter = false;
  bool closed = false;
  //Text to speech stuff
  FlutterTts _flutterTts = new FlutterTts();
  Future speak(String text) async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.speak(text);
  }

  //Messages will be mapped to this list
  List<Map> messsages = [];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    TextEditingController messageInsert = new TextEditingController();
    super.build(context);
    return closed == false
        ? Scaffold(
            body: Container(
              child: Column(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () async {
                      this.closed = true;
                      setState(() {});
                    },
                    child: Text('Close Conversation'),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15, bottom: 10),
                    child: Text(
                      "Today, ${DateFormat("Hm").format(DateTime.now())}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                  Flexible(
                      child: ListView.builder(
                          reverse: true,
                          itemCount: messsages.length,
                          itemBuilder: (context, index) => chat(
                              messsages[index]["message"].toString(),
                              messsages[index]["data"]))),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    height: 5.0,
                  ),
                  Container(
                    child: ListTile(
                      title: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        padding: EdgeInsets.only(left: 15),
                        child: TextFormField(
                          controller: messageInsert,
                          decoration: InputDecoration(
                            hintText: "Enter a Message...",
                            hintStyle: TextStyle(color: Colors.black45),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          onChanged: (value) {},
                        ),
                      ),
                      trailing: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Colors.blue,
                            size: 30.0,
                          ),
                          onPressed: () async {
                            if (messageInsert.text.isEmpty) {
                              print("empty message");
                            } else {
                              setState(() {
                                messsages.insert(0,
                                    {"data": 1, "message": messageInsert.text});
                                index = 1;
                                sendMessage(messageInsert.text);
                              });
                              response(messageInsert.text.replaceAll("'", ""));
                              messageInsert.clear();
                            }
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                          }),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  )
                ],
              ),
            ),
          )
        : NewMessage();
  }

  //Functions :

  //Function for sending messages
  void sendMessage(String message) async {
    //Remove focus of the keyboard
    FocusScope.of(context).unfocus();
    //Call a function to firebase upload message
    await FirebaseService.uploadMessage(userID, message, index);
  }

  //Response function called by both user message and dialoflow
  void response(query) async {
    //Asynchronously instantiating AuthGoogle, this is for Google Cloud services.
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/fyp-project-a8913-44600a68789d.json")
            .build();
    //Instantiate DialogFlow V2 refer to pubspec.yaml
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    //AIResponse is a class within DialogFlow package that speaks from dialogflow to flutter, this also has intent detection and also language detection
    AIResponse aiResponse;
    aiResponse = await dialogflow.detectIntent(query);
    setState(() {
      messsages.insert(0, {
        "data": 0,
        "message": aiResponse.getListMessage()[0]["text"]["text"][0].toString(),
      });
      index = 0;
    });
    sendMessage(aiResponse.getListMessage()[0]["text"]["text"][0].toString());
    if (widget.enabledTTS == true) {
      speak(aiResponse.getListMessage()[0]["text"]["text"][0].toString());
    }
    print(aiResponse.getListMessage()[0]["text"]["text"][0].toString());
  }

  void closeConvo(bool closed) {
    if (closed == true) {
      setState(() {
        NewMessage x = new NewMessage();
        return x;
      });
    }
  }
}
