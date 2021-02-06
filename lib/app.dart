import 'package:FYP_project/main.dart';
import 'package:FYP_project/screens/preface.dart';
import 'package:FYP_project/screens/tabs/home.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(initialRoute: '/', routes: {
      
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => Preface(),
      '/second': (context) => Home(),
    });
  }
}

