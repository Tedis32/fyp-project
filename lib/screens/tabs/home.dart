import 'package:FYP_project/screens/tabs/chat.dart';
import 'package:FYP_project/screens/tabs/conversations.dart';
import 'package:FYP_project/services/authenticationservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  AuthenticationService auth;
  final tabs = [Chat(), Conversations()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
            onPressed: () {
              context.read<AuthenticationService>().signOut();
            },
            child: Text("Sign out", style: TextStyle(color: Colors.white)),
          )
        ],
        title: _currentIndex == 0 ? Text("Chat with Francine") : Text("Conversations"),
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              label: "Chat",
              icon: Icon(Icons.message),
            ),
            BottomNavigationBarItem(
                label: "Conversations", icon: Icon(Icons.list)),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          }),
    );
  }
}
