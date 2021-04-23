import 'package:flutter/material.dart';
import 'package:fyp_project/models/shop_item.dart';

class BasketItemWidget extends StatelessWidget {
  final ShopItem item;
  final Animation animation;
  final VoidCallback onClicked;

  const BasketItemWidget({
    @required this.item,
    @required this.animation,
    @required this.onClicked,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ScaleTransition(
        scale: animation,
        child: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            leading: CircleAvatar(
              radius: 32,
              backgroundImage: AssetImage('assets/${item.index}' + '.jpg'),
            ),
            title: Text(item.name, style: TextStyle(fontSize: 20)),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red, size: 32),
              onPressed: onClicked,
            ),
          ),
        ),
      );
}