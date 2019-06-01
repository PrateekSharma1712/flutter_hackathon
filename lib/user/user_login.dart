import 'package:flutter/material.dart';
import 'package:flutter_hackathon/user/server/login_server.dart';
import 'package:flutter_hackathon/user/storage/user_shared_pref.dart';
import 'package:flutter_hackathon/utils/validators.dart';

import 'model/user_model.dart';

class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  final passwordTextController = TextEditingController();
  final emailTextController = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  bool isLoggedIn = false;
  var profileData;
  FocusNode textSecondFocusNode = new FocusNode();


  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        primary: true,
        title: Text("Login"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(75)),
              margin: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: passwordTextController,
                      style: TextStyle(color: Colors.white, letterSpacing: 1),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          hintStyle: TextStyle(
                              color: Colors.white54,
                              fontSize: 16,
                              letterSpacing: 1)),
                      validator: Validator.validatePassword,
                      focusNode: textSecondFocusNode,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        String email =
                            emailTextController.text.toString().trim();
                        String password =
                            passwordTextController.text.toString().trim();
                        LoginServer()
                            .handleSignIn(email, password)
                            .then((user) {
                          print(user);
                          User u = user;
                          if (u != null) {
                            UserSharedPreference.updateLoggedInUserDetails(
                              email,
                              u.name,
                            );
                            UserSharedPreference.getLoggedInUserDetails()
                                .then((userData) {
                              print(userData);
                              Navigator.pushReplacementNamed(
                                  context, "/dashboard");
                            });
                          }
                        });
                      },
                    ),
                  ),
                  new Container(
                    width: 48.0,
                    height: 48.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black),
                    child: Icon(
                      Icons.vpn_key,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
