import 'package:flutter/material.dart';
import 'package:fyp_project/app.dart';
import 'package:fyp_project/screens/tabs/home.dart';
import 'package:fyp_project/screens/tabs/shop.dart';

class ErrorScreen extends StatefulWidget {
  @override
  _ErrorScreenState createState() => _ErrorScreenState();
  final String name;
  ErrorScreen({this.name});
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    String carName = widget.name;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 80),
        color: Colors.black,
        child: Column(
          children: [
            Center(
              child: Text(
                'UH OH, You have run into a known error with:\n$carName\n\nMaybe you should refer to Francine for help!',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent),
              ),
            ),
            Divider(),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
              child: Text('Go back!'),
            )
          ],
        ),
      ),
    );
  }
}
