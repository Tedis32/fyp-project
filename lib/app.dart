import 'package:FYP_project/screens/signinpage.dart';
import 'package:FYP_project/screens/tabs/home.dart';
import 'package:FYP_project/services/authenticationservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: GoogleFonts.josefinSans().fontFamily,
          appBarTheme: AppBarTheme(
            textTheme: TextTheme(headline1: TextStyle(color: Colors.white)),
            color: Colors.black,
          ),
          brightness: Brightness.light,
          primaryColor: Colors.blue,
        ),
        title: 'FYP',
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      return Home();
    } else {
      return SignInPage();
    }
  }
}
