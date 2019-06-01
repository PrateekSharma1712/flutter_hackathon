import 'package:flutter/material.dart';
import 'package:flutter_hackathon/dialogflow/dialog_flow_service.dart';
import 'package:flutter_hackathon/pages/chat_screen.dart';
import 'package:flutter_hackathon/splash/splash.dart';
import 'package:flutter_hackathon/user/user_login.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color(0xffC523FF), canvasColor: Colors.white),
      home: AppSplashScreen(),
      routes: {
        "/login": (context) => UserLogin(),
        "/chat": (context) => Provider<DialogFlowService>(
              child: ChatScreen(),
              builder: (context) => DialogFlowService(),
            ),
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
