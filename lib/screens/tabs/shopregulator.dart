import 'package:flutter/material.dart';
import 'package:fyp_project/screens/tabs/shop.dart';

import 'checkout.dart';

class ShopRegulator extends StatefulWidget {
  @override
  _ShopRegulatorState createState() => _ShopRegulatorState();
}

class _ShopRegulatorState extends State<ShopRegulator> {
  bool showCheckout = true;
  void toggleView() {
    setState(() => showCheckout = !showCheckout);
  }

  @override
  Widget build(BuildContext context) {
    if (showCheckout) {
      return Checkout(
        toggleView: toggleView, 
      );
    } else {
      return Shop(
        toggleView: toggleView, 
      );
    }
  }
}
