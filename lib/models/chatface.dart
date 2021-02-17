import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget chat(String message, int data) {
  return Container(
    padding: EdgeInsets.only(left: 20, right: 20),
    child: Row(
      mainAxisAlignment:
          data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        // Using data = 0 or 1 to differentiate between 2 users
        data == 0
            ? SizedBox(
                height: 60,
                width: 60,
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/white-robot.jpg"),
                ),
              )
            : SizedBox(),
        Bubble(
            radius: Radius.circular(15.0),
            color: data == 0 ? Colors.black54 : Colors.blue,
            elevation: 0.0,
            child: Padding(
              padding: EdgeInsets.all(2.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    width: 10.0,
                  ),
                  Flexible(
                      child: Container(
                    constraints: BoxConstraints(maxWidth: 200),
                    child: Text(
                      message,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ))
                ],
              ),
            )),
        data == 1
            ? SizedBox(
                height: 60,
                width: 60,
                child: CircleAvatar(
                  backgroundImage:
                      NetworkImage('https://i.pravatar.cc/150?'),
                ),
              )
            : SizedBox(),
      ],
    ),
  );
}
