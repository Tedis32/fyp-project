import 'package:flutter/material.dart';

class CustomListTile extends StatefulWidget {
  final int index;
  final Image image;
  @override
  _CustomListTileState createState() => _CustomListTileState();
  const CustomListTile({Key key, this.index, this.image}) : super(key: key);
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset('assets/white-robot.jpg'),
      title: Text('Conversation: $this.index'),
    );
  }
}
