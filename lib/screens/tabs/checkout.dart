import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp_project/main.dart';
import 'package:fyp_project/models/basketitem.dart';
import 'package:fyp_project/models/shop_item.dart';
import 'package:fyp_project/screens/tabs/shop.dart';

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
  final List<ShopItem> items;

  final Function toggleView;
  Checkout({this.toggleView, this.items});
}

class _CheckoutState extends State<Checkout> {
  final key = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    List<ShopItem> _list = widget.items;
    _list = itemsNotifier;
    double _balance = 0;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
            itemsNotifier.length != 0
                ? SingleChildScrollView(
                    child: AnimatedList(
                      shrinkWrap: true,
                      key: key,
                      initialItemCount: itemsNotifier.length,
                      itemBuilder: (context, index, animation) => buildItem(
                          itemsNotifier[index],
                          index,
                          animation,
                          itemsNotifier),
                    ),
                  )
                : Text('Basket empty! Maybe shop around first'),
            SizedBox(
              height: 5,
            ),
            ElevatedButton(
                child: Text('Back to shop!'),
                onPressed: () {
                  widget.toggleView();
                }),
            ElevatedButton(
              child: Text('Purchase items'),
              onPressed: () async {
                if (itemsNotifier.length != 0) {
                  DocumentReference docRef = FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser.uid);
                  await docRef.get().then(
                    (DocumentSnapshot snapshot) {
                      _balance = snapshot['balance'];
                    },
                  );
                  if (_balance >= getTotalPrice()) {
                    docRef.update(
                      {
                        'balance': FieldValue.increment(-getTotalPrice()),
                      },
                    );
                    Fluttertoast.showToast(
                      msg: "Successfully purchased!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                    );
                    emptyCart();
                  } else {
                    print('error');
                    Fluttertoast.showToast(
                      msg: "Error, not enough money",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                    );
                  }
                }
                else {
                  Fluttertoast.showToast(
                      msg: "Nothing to purchase!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                    );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget buildItem(
          item, int index, Animation<double> animation, List<ShopItem> list) =>
      BasketItemWidget(
          item: item,
          animation: animation,
          onClicked: () {
            removeItem(index, list);
            removeItemGlobal(item.index);
            setState(() {});
          });

  void removeItem(int index, List<ShopItem> list) {
    final item = list.removeAt(index);
    key.currentState.removeItem(
      index,
      (context, animation) => buildItem(item, index, animation, list),
    );
  }

  void emptyCart() {
    itemsNotifier.clear();
    setState(() {});
  }
}
