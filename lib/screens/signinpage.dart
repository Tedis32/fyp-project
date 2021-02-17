import 'package:FYP_project/screens/signuppage.dart';
import 'package:FYP_project/services/authenticationservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        title: Text("Sign-in", style: TextStyle(fontSize: 25)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 120, 30, 0),
          child: Container(
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Welcome to my application...",
                    style: TextStyle(
                        color: Colors.blue[400],
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ),
                Divider(
                  height: 30,
                ),
                TextFormField(
                  controller: emailController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    hintStyle: TextStyle(color: Colors.white),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    border: new OutlineInputBorder(
                      borderSide: const BorderSide(style: BorderStyle.none),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(20.0),
                      ),
                    ),
                    suffixIcon: Icon(
                      Icons.email,
                      color: Colors.blue,
                    ),
                    fillColor: Colors.black,
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    hintStyle: TextStyle(color: Colors.white),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    border: new OutlineInputBorder(
                      borderSide: const BorderSide(style: BorderStyle.none),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(20.0),
                      ),
                    ),
                    suffixIcon: Icon(
                      Icons.lock,
                      color: Colors.blue,
                    ),
                    fillColor: Colors.black,
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FlatButton(
                  child: Text("Login",
                      style: TextStyle(fontSize: 25, color: Colors.white)),
                  onPressed: () {
                    context.read<AuthenticationService>().signIn(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim());
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
