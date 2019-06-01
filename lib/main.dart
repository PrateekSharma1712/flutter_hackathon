import 'package:flutter/material.dart';
import 'package:flutter_hackathon/splash/splash.dart';
import 'package:flutter_hackathon/user/user_login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xffC523FF),
      ),
      home: AppSplashScreen(),
      routes: {
        "/login": (context) => UserLogin(),
      },
    );
  }
}

//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  final String title;
//
//  @override
//  _MyHomePageState createState() => ChatScreen();
//}
