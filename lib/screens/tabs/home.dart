import 'package:FYP_project/screens/tabs/chat.dart';
import 'package:FYP_project/screens/tabs/conversations.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final tabs = [
    Chat(),
    Conversations()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chatting time"),
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
