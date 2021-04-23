import 'package:fyp_project/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'models/shop_item.dart';

List<ShopItem> itemsNotifier = [];


void removeItemGlobal(int index) {
  for (var item in itemsNotifier) {
    if (item.index == index) {
      itemsNotifier.removeAt(index);
    }
  }
}

double getTotalPrice() {
  double totalValue = 0;
  for (var item in itemsNotifier) {
    totalValue += item.price;
  }
  return totalValue;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}
