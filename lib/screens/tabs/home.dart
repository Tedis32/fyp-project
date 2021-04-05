import 'package:fyp_project/screens/tabs/chat.dart';
import 'package:fyp_project/screens/tabs/conversations.dart';
import 'package:fyp_project/services/authenticationservice.dart';
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
          TextButton(
            onPressed: () {
              context.read<AuthenticationService>().signOut();
            },
            child: Text("Sign out", style: TextStyle(color: Colors.white)),
          )
        ],
        title: _currentIndex == 0
            ? Text("Chat with Francine")
            : Text("Conversations"),
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              label: "Chat",
              activeIcon: Icon(Icons.message, color: Colors.blue),
              icon: Icon(
                Icons.message,
                color: Colors.white60,
              ),
            ),
            BottomNavigationBarItem(
              label: "Conversations",
              activeIcon: Icon(Icons.message, color: Colors.blue),
              icon: Icon(
                Icons.message,
                color: Colors.white60,
              ),
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          }),
    );
  }
}
