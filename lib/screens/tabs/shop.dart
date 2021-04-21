import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project/models/shop_item.dart';
import 'package:fyp_project/screens/tabs/chat.dart';

class Shop extends StatefulWidget {
  @override
  _ShopState createState() => _ShopState();
  final List<ShopItem> shopItems = [
    ShopItem(
      name: "Panoz Roadster",
      price: 40000,
      index: 0,
      description:
          "This STUNNING Panoz classic is a rare machine that only the bravest of heart would dare push to the limit " +
              "\n\n" +
              "Sitting at a comfortable 305 BHP and a weight of only 1 tonne, it truly is one to behold!",
    ),
    ShopItem(
      name: "Tesla Model S",
      price: 55000,
      index: 1,
      description:
          "The Tesla Model S is a hyper-futuristic, electric vehicle manufactured by a company that belongs to the one and only Elon Musk.\n \nChances are, your favourite celebrity has one so OBVIOUSLY you should get one too!",
    ),
    ShopItem(
      name: "Nissan Leaf",
      price: 12000,
      index: 2,
      description:
          "The perfect car for criminals! \nIt's quiet! (So they can't hear you coming), \nIt's Fast! (If you never go on motorways) \nAnd most importantly; It's reliable! (Since it's electric, you never even have to fill it with fuel)",
    ),
    ShopItem(
      name: "1967 Ford Mustang",
      price: 100000,
      index: 3,
      description:
          "Like something straight out of a teen drama made in the early 2000s, this vintage classic is every protagonists dream! \nThis Rear Wheel Drive monster comes with a 225 BHP V8 engine and has no shortage of torquee power!",
    ),
    ShopItem(
      name: "Daewoo Matiz",
      price: 300,
      index: 4,
      description:
          "Here we have a second-hand Daewoo Matiz\nThere is not much to say for this car, what you see is what you get!",
    ),
    ShopItem(
      name: "1987 VW Golf GTI",
      price: 6000,
      index: 5,
      description:
          "For all top gear fans, this is a must-have.\nThis model comes 10 years after the genesis of the Golf GTI and is a GO-TO car if you are looking for speed and reliability",
    ),
    ShopItem(
      name: "Mercedes Sprinter",
      price: 8500,
      index: 6,
      description:
          "Perfect van for working hands!\nThe electric variation of the Sprinter is ideal for long distance transportation of goods as it means less stops for fuel!",
    ),
    ShopItem(
      name: "McLaren P1",
      price: 1000000,
      index: 7,
      description: "This is an epic car",
    ),
  ];
  final bool noError;
  Shop({this.noError});
}

class _ShopState extends State<Shop> {
  String uid = FirebaseAuth.instance.currentUser.uid;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    bool _noError = widget.noError;
    return _noError == false
        ? Chat()
        : Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  RefreshIndicator(
                    // ignore: missing_return
                    onRefresh: () {
                      _refreshing();
                    },
                    child: Text(''),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FutureBuilder<DocumentSnapshot>(
                        future: users.doc(uid).get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text("Something went wrong");
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            Map<String, dynamic> data = snapshot.data.data();
                            return Text("Balance: € ${data['balance']}");
                          }
                          return Text("loading");
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  ListView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(10),
                    children: widget.shopItems,
                  ),
                ],
              ),
            ),
          );
  }

  Future<Null> _refreshing() async {
    print('refreshing stocks...');
  }
}
