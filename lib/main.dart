import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:yogait/model/login.dart';
import 'package:yogait/model/dashboard.dart';
import 'package:yogait/model/signup.dart';

void main() {

  runApp(MaterialApp(
    home: Home(),
  ));

}


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home>
    with SingleTickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => Login(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => Dashboard(),
        '/signup': (context) => Signup(),
      },

    );

  }

}

