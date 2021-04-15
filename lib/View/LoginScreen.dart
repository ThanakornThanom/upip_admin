import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'GloabalVar.dart';
import 'Mainapp.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String emailstring, passwordstring;

  @override
  void initState() async {
    super.initState();
    await Firebase.initializeApp();
  }

  InputDecoration textFieldInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
        color: Colors.grey,
      )),
    );
  }

  void myAlert(String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: ListTile(
              leading: Icon(
                Icons.alarm_on,
                color: Colors.black,
              ),
              title: Text(
                title,
                style: TextStyle(color: Colors.black),
              ),
            ),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
          backgroundColor: Colors.black12,
          body: Center(
            child: Container(
              width: screenwidth(context) * 0.3,
              height: screenHeight(context) * 0.5,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(colors: [
                    Colors.grey[300],
                    Colors.grey[500],
                  ]),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "UPIP Administration",
                      style:
                          GoogleFonts.lato(fontSize: 20, color: Colors.black),
                    ),
                    TextFormField(
                      onSaved: (String value) {
                        emailstring = value.trim();
                      },
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: textFieldInputDecoration('email'),
                      validator: (String value) {
                        if (!((value.contains('@')) && (value.contains('.')))) {
                          return 'please enter your email ex. UPIP@google.com';
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      onSaved: (String value) {
                        passwordstring = value.trim();
                      },
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration:
                          textFieldInputDecoration('password'), //custom widget
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        _formKey.currentState.save();

                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Mainapp()));
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, -2),
                                blurRadius: 30,
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(colors: [
                              Colors.grey[500],
                              Colors.grey[900],
                            ])),
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
