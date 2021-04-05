import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp_project/services/authenticationservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
  final Function toggleView;
  SignUpPage({this.toggleView});
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        title: Text("Register", style: TextStyle(fontSize: 25)),
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
                    "Enter your details below",
                    style: TextStyle(
                        color: Colors.blue[400],
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ),
                Divider(
                  height: 40,
                ),
                TextFormField(
                  controller: userNameController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Enter your Username",
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
                TextButton(
                  child: Text("Register",
                      style: TextStyle(fontSize: 25, color: Colors.white)),
                  onPressed: () async {
                   await context.read<AuthenticationService>().signUp(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim());
                    context
                        .read<AuthenticationService>()
                        .addUser(userNameController.text);
                    
                  },
                ),
                Divider(
                  height: 150,
                ),
                TextButton(
                  child: Text(
                    "Already have an account? Login",
                    style: TextStyle(
                        color: Colors.white54, fontStyle: FontStyle.italic),
                  ),
                  onPressed: () {
                    widget.toggleView();
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
