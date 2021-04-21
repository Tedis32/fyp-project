import 'package:fyp_project/screens/authenticator.dart';
import 'package:fyp_project/screens/tabs/home.dart';
import 'package:fyp_project/services/authenticationservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project/services/bottomappbarprovider.dart';
import 'package:fyp_project/services/firebaseservice.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<BottomNavigationBarProvider>(
          create: (_) => BottomNavigationBarProvider(),
        ),
        Provider<FirebaseService>(
          create: (_) => FirebaseService(),
        ),
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
      return Authenticator();
    }
  }
}
