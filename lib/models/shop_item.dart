import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:fyp_project/screens/errorscreen.dart';
import 'package:fyp_project/screens/shopitemscreen.dart';

class ShopItem extends StatefulWidget {
  @override
  _ShopItemState createState() => _ShopItemState();

  final String name;
  final double price;
  final int index;
  final String description;

  ShopItem({
    this.name,
    this.price,
    this.index,
    this.description,
  });
}

class _ShopItemState extends State<ShopItem> {
  @override
  Widget build(BuildContext context) {
    int x = widget.index;
    return ListTile(
      onTap: () async {
        widget.name != '1967 Ford Mustang'
            ? setState(
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShopItemScreen(
                        shopItem: ShopItem(
                          name: widget.name,
                          price: widget.price,
                          index: widget.index,
                          description: widget.description,
                        ),
                      ),
                    ),
                  );
                },
              )
            : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ErrorScreen(name: widget.name)));
      },
      title: Text(widget.name),
      leading: SizedBox(
          height: 70, width: 70, child: Image.asset('assets/' + '$x' + '.jpg')),
      trailing: Text(widget.price.toString()),
    );
  }
}
