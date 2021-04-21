import 'package:fyp_project/models/newmessage.dart';
import 'package:fyp_project/screens/emailscreen.dart';
import 'package:fyp_project/screens/tabs/chat.dart';
import 'package:fyp_project/screens/tabs/conversations.dart';
import 'package:fyp_project/screens/tabs/dualbots.dart';
import 'package:fyp_project/screens/tabs/shop.dart';
import 'package:fyp_project/screens/tabs/shopregulator.dart';
import 'package:fyp_project/screens/tabs/speechsreen.dart';
import 'package:fyp_project/services/authenticationservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  AuthenticationService auth;
  final tabs = [
    NewMessage(),
    SpeechScreen(),
    DualBots(),
    ShopRegulator(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: EdgeInsets.only(top: 40, bottom: 60),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ListView(
                children: [
                  ListTile(
                    title: Text("Send us an email!"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EmailSender(),
                        ),
                      );
                    },
                    trailing: Icon(Icons.email),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthenticationService>().signOut();
                },
                child: Text("Sign out", style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
          title: _currentIndex == 0
              ? Text("Chat with Francine")
              : _currentIndex == 1
                  ? Text("Speak to Francine")
                  : _currentIndex == 2
                      ? Text('Bot battle!')
                      : Text('Shop around!')),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
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
              label: "Speak",
              activeIcon: Icon(Icons.mic, color: Colors.blue),
              icon: Icon(
                Icons.mic,
                color: Colors.white60,
              ),
            ),
            BottomNavigationBarItem(
              label: "Dual-bots",
              activeIcon: Icon(Icons.emoji_people_sharp, color: Colors.blue),
              icon: Icon(
                Icons.emoji_people_sharp,
                color: Colors.white60,
              ),
            ),
            BottomNavigationBarItem(
              label: "Shop",
              activeIcon: Icon(Icons.shop, color: Colors.blue),
              icon: Icon(
                Icons.shop,
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

  int getCurrentIndex(int index) {
    return index;
  }
}
