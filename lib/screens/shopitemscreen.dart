import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project/models/shop_item.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp_project/screens/errorscreen.dart';

class ShopItemScreen extends StatefulWidget {
  @override
  _ShopItemScreenState createState() => _ShopItemScreenState();
  final ShopItem shopItem;
  ShopItemScreen({this.shopItem});
}

class _ShopItemScreenState extends State<ShopItemScreen> {
  @override
  Widget build(BuildContext context) {
    int x = widget.shopItem.index;
    String description = widget.shopItem.description;
    double price = widget.shopItem.price;
    String name = widget.shopItem.name;
    String uid = FirebaseAuth.instance.currentUser.uid;
    double _balance = 0;
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 18)),
            SizedBox(
              child: Image.asset('assets/' + '$x' + '.jpg', fit: BoxFit.fill),
            ),
            Divider(),
            SizedBox(
              height: 30,
            ),
            Container(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  '$name',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Center(
                child: Text('$description'),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Center(
              child: Text(
                "Price: € $price",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () async {
                    DocumentReference docRef =
                        FirebaseFirestore.instance.collection('users').doc(uid);
                    await docRef.get().then(
                      (DocumentSnapshot snapshot) {
                        _balance = snapshot['balance'];
                      },
                    );
                    if (_balance >= price) {
                      docRef.update(
                        {
                          'balance': FieldValue.increment(-price),
                        },
                      );
                      Navigator.pop(context);
                      setState(() {});
                    } else {
                      print('error');
                      Fluttertoast.showToast(
                        msg: "Error, not enough money",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                      );
                    }
                  },
                  child: Text('Purchase $name')),
            ),
          ],
        ),
      ),
    );
  }
}
