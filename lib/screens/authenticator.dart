import 'package:FYP_project/screens/signinpage.dart';
import 'package:FYP_project/screens/signuppage.dart';
import 'package:flutter/material.dart';

class Authenticator extends StatefulWidget {
  @override
  _AuthenticatorState createState() => _AuthenticatorState();
}

class _AuthenticatorState extends State<Authenticator> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignInPage(
        toggleView: toggleView,
      );
    } else {
      return SignUpPage(
        toggleView: toggleView,
      );
    }
  }
}
