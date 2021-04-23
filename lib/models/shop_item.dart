import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:fyp_project/screens/errorscreen.dart';
import 'package:fyp_project/screens/shopitemscreen.dart';
import 'package:fyp_project/screens/tabs/shop.dart';

import '../main.dart';

class ShopItem extends StatefulWidget {
  @override
  _ShopItemState createState() => _ShopItemState();

  final String name;
  final double price;
  final int index;
  final String description;
  bool basket;
  ShopItem({
    this.name,
    this.price,
    this.index,
    this.description,
  });
}

class _ShopItemState extends State<ShopItem> {
  @override
  Widget build(
    BuildContext context,
  ) {
    ShopItem _shopItem = new ShopItem(
      name: widget.name,
      description: widget.description,
      price: widget.price,
      index: widget.index,
    );
    int x = widget.index;
    List<ShopItem> _tempList = itemsNotifier;
    return ListTile(
      onTap: () async {
        widget.name != '1967 Ford Mustang' && widget.name != 'Mercedes Sprinter'
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
      subtitle: Text('Price: €' + widget.price.toString()),
      leading: Container(
        height: 70,
        width: 70,
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/' + '$x' + '.jpg'),
        ),
        decoration: BoxDecoration(shape: BoxShape.circle),
      ),
      trailing: TextButton(
        child: Text('Add to cart'),
        onPressed: () {
          setState(() {
            _tempList.add(_shopItem);
          });
          itemsNotifier = _tempList;
          print(itemsNotifier);
        },
      ),
    );
  }
}
