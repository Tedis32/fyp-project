import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp_project/models/chatface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:flutter_dialogflow/v2/auth_google.dart';
import 'package:fyp_project/services/firebaseservice.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreen createState() => _SpeechScreen();
}

// Setting up the Chat interface state, getting it to interact with DialogFlow
class _SpeechScreen extends State<SpeechScreen> {
  //Speech to text stuff
  stt.SpeechToText _speech;
  String _textSpeech;
  bool _isListening = false;
  double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

// This function is necessary for the bot to hear a human speak and regulate the speech into the widget tree
  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _textSpeech = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
            setState(() {
              messsages.insert(0, {"data": 1, "message": _textSpeech});
              response(_textSpeech);
            });
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  //Text to speech stuff
  FlutterTts _flutterTts = new FlutterTts();
  Future speak(String text) async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.speak(text);
  }

  void response(query) async {
    //Asynchronously instantiating AuthGoogle, this is for Google Cloud services.
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/fyp-project-a8913-44600a68789d.json")
            .build();
    //Instantiate DialogFlow V2 refer to pubspec.yaml
    Dialogflow dialogflowspeech =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    //AIResponse is a class within DialogFlow package that speaks from dialogflow to flutter, this also has intent detection and also language detection
    AIResponse aiResponse;
    aiResponse = await dialogflowspeech.detectIntent(query);
    setState(() {
      /* context.read<FirebaseService>().addMessage(
          FirebaseAuth.instance.currentUser.uid,
          aiResponse.getListMessage()[0]["text"]["text"][0].toString(), 0 ); */
      messsages.insert(0, {
        "data": 0,
        "message": aiResponse.getListMessage()[0]["text"]["text"][0].toString()
      });
    });
    speak(aiResponse.getListMessage()[0]["text"]["text"][0].toString());
    print(aiResponse.getListMessage()[0]["text"]["text"][0].toString());
  }

  //final messageInsert = new TextEditingController();
  List<Map> messsages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
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
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(60)),
                  ),
                  padding: EdgeInsets.only(left: 15),
                  child: AvatarGlow(
                    animate: _isListening,
                    glowColor: Theme.of(context).primaryColor,
                    endRadius: 80,
                    duration: Duration(milliseconds: 2000),
                    repeat: true,
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: FloatingActionButton(
                        onPressed: _listen,
                        child: Icon(
                          _isListening ? Icons.mic : Icons.mic_none,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            )
          ],
        ),
      ),
    );
  }
}
