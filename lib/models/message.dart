import 'package:flutter/material.dart';

class Message {
  final String userID;
  final String message;
  final DateTime timeStamp;
  final int chatnumber;
  final int index;
  const Message(
      {@required this.userID,
      @required this.message,
      @required this.timeStamp,
      @required this.chatnumber,
      @required this.index});

  Map<String, dynamic> toJson() => {
        'userID': userID,
        'message': message,
        'timeStamp': timeStamp,
        'chatnumber': this.chatnumber,
        'index': this.index
      };
}
