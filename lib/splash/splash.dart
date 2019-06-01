import 'dart:async';

import 'package:flutter/material.dart';

class AppSplashScreen extends StatefulWidget {
  @override
  _AppSplashScreenState createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen> {
  bool isUserLoggedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    startTimer();
  }

  startMainScreen() {
    Navigator.pushReplacementNamed(context, "/login");
  }

  startTimer() async {
    var _duration = new Duration(seconds: 1, milliseconds: 500);
    return new Timer(_duration, startMainScreen);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(32),
            child: Text("Hackathon")));
  }
}
