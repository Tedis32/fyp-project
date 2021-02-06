import 'package:FYP_project/models/action_button.dart';
import 'package:FYP_project/models/chat_message.dart';
import 'package:FYP_project/models/message_input_box.dart';
import 'package:FYP_project/models/page_wrapper.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlatPageWrapper(
        scrollType: ScrollType.floatingHeader,
        reverseBodyList: true,
        children: [
          FlatChatMessage(
            message: "",
            messageType: MessageType.sent,
            showTime: true,
            time: "2 mins ago",
          ),
          
          FlatChatMessage(
            message: "",
            showTime: true,
            time: "2 mins ago",
          ),
          FlatChatMessage(
            message: "",
            showTime: true,
            time: "2 mins ago",
          ),
        ],
        footer: FlatMessageInputBox(
          prefix: FlatActionButton(
            iconData: Icons.add,
            iconSize: 24.0,
          ),
          roundedCorners: true,
          suffix: FlatActionButton(
            iconData: Icons.image,
            iconSize: 24.0,
          ),
        ),
      ),
    );
  }
}