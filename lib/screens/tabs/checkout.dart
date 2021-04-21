import 'package:flutter/material.dart';
import 'package:fyp_project/models/shop_item.dart';
import 'package:fyp_project/screens/tabs/shop.dart';

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
  List<ShopItem> items = [];

  final Function toggleView;
  Checkout({this.toggleView, this.items});
}

class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 50)),
          Center(
            child: Text(
              'Welcome to the checkout!',
              style: TextStyle(fontSize: 30),
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.items.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  leading: FlutterLogo(size: 40.0),
                  title: Text(widget.items[index].name),
                  trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        removeFromBasket(widget.items, index);
                      }),
                  isThreeLine: true,
                ),
              );
            },
          ),
          SizedBox(
            height: 5,
          ),
          ElevatedButton(
              child: Text('Back to shop!'),
              onPressed: () {
                widget.toggleView();
              })
        ],
      ),
    );
  }

  /* Widget BasketListTile(List<ShopItem> basket) {
    if (basket.isEmpty) {
      return Text('Basket currently empty');
    } else {
      List<ListTile> newBasket = [];
      for (var item in basket) {
        newBasket.add(
          ListTile(
            leading: Image.asset('assets/$item.index' + 'jpg'),
            title: Text(item.name + '\t' + item.price.toString()),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await removeFromBasket(basket, basket.indexOf(item));
              },
            ),
          ),
        );
      }
    }
  } */

  Future<void> removeFromBasket(List<ShopItem> basket, int index) async {
    basket.removeAt(index);
  }
}
