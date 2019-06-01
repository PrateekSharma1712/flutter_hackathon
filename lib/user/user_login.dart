import 'package:flutter/material.dart';
import 'package:flutter_hackathon/delegates/snackbar_delegate.dart';
import 'package:flutter_hackathon/statics/color_pallets.dart';
import 'package:flutter_hackathon/statics/text_styles.dart';
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
  final nameTextController = TextEditingController();

  final emailTextController = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  bool isLoggedIn = false;
  var profileData;
  FocusNode textSecondFocusNode = new FocusNode();
  bool isLoading = false;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    emailTextController.text = "viv@test.com";
    passwordTextController.text = "111111";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    updateData() {
      String name = nameTextController.text;
      String email = emailTextController.text;
      LoginServer().uploadUserData(email, name).then((isComplete) {
        if (isComplete) {
          SnackBarDelegate.showSnackBar(
              context, "Registration complete", _scaffoldKey);
        } else {}
        setState(() {
          isLoading = false;
        });
      });
    }

    askUserName() {
      showDialog(
        context: context,
        builder: (BuildContext context) => new AlertDialog(
              title: new Text("Details"),
              content: Column(
                children: <Widget>[
                  new Text("Enter your name to continue"),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
//                    color: Colors.black38,
                        borderRadius: BorderRadius.circular(75),
                        border: Border.all(color: Colors.black26)),
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 48),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: nameTextController,
                            style: TextStyle(letterSpacing: 1),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Name',
                                hintStyle: TextStyle(
                                    fontSize: 16,
//                                color: Colors.white54,
                                    letterSpacing: 1)),
                            validator: Validator.validateEmail,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (value) {
                              updateData();
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              actions: [
                FlatButton(
                  child: new Text('Submit'),
                  onPressed: () async {
                    updateData();

                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
      );
    }

    showError(error) {
      SnackBarDelegate.showSnackBar(context, error, _scaffoldKey);
    }

    signIn() {
      String email = emailTextController.text.toString().trim();
      String password = passwordTextController.text.toString().trim();
      LoginServer().handleSignIn(email, password).then((user) {
        if (user == "no_user_data") {
          askUserName();
        } else if (user == "error") {
          showError(user);
        } else {
          print(user);
          User u = user;
          if (u != null) {
            UserSharedPreference.updateLoggedInUserDetails(
              email,
              u.name,
            );
            UserSharedPreference.getLoggedInUserDetails().then((userData) {
              print(userData);
              Navigator.pushReplacementNamed(context, "/chat");
            });
          }
        }
      });
    }

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
//      appBar: AppBar(
//        primary: true,
//        title: Text("Login"),
//        centerTitle: true,
//      ),
      body: Container(
        alignment: Alignment.center,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(),
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(75))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/images/icons8-google-96.png",
                        scale: 2,
                      ),
                    )),
              ),
              SizedBox(
                height: 32,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
//                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(75),
                    border: Border.all(color: Colors.black26)),
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 48),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: emailTextController,
                        style: TextStyle(letterSpacing: 1),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email',
                            hintStyle: TextStyle(
                                fontSize: 16,
//                                color: Colors.white54,
                                letterSpacing: 1)),
                        validator: Validator.validateEmail,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(textSecondFocusNode);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
//                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(75),
                    border: Border.all(color: Colors.black26)),
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 48),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: passwordTextController,
                        style: TextStyle(letterSpacing: 1),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password',
                            hintStyle:
                                TextStyle(fontSize: 16, letterSpacing: 1)),
                        validator: Validator.validatePassword,
                        focusNode: textSecondFocusNode,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          signIn();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(32.0),
              ),
              (isLoading)
                  ? CircularProgressIndicator()
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 48),
                      alignment: Alignment.center,
                      child: (isLoading)
                          ? CircularProgressIndicator()
                          : RaisedButton(
                              color: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(75.0)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: 16.0,
                                          bottom: 16.0,
                                          left: 16,
                                          right: 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'Sign in',
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            textScaleFactor: 1,
                                            style: CustomTextStyles
                                                .primaryButtonTextStyle,
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                              onPressed: () {
                                signIn();
//                                String email =
//                                    emailTextController.text.toString().trim();
//                                String password = passwordTextController.text
//                                    .toString()
//                                    .trim();
//
//                                setState(() {
//                                  isLoading = true;
//                                });
//                                LoginServer()
//                                    .handleSignIn(email, password)
//                                    .then((user) {
//                                  print(user);
//                                  User u = user;
//                                  if (u != null) {
//                                    UserSharedPreference
//                                        .updateLoggedInUserDetails(
//                                      email,
//                                      u.name,
//                                    );
//                                    UserSharedPreference
//                                            .getLoggedInUserDetails()
//                                        .then((userData) {
//                                      setState(() {
//                                        isLoading = false;
//                                      });
//                                      print(userData);
//                                      Navigator.pushReplacementNamed(
//                                          context, "/dashboard");
//                                    });
//                                  }
//                                }).catchError((error) {
//                                  print(error);
//                                  showCenterShortToast("Can't Login");
//                                  setState(() {
//                                    isLoading = false;
//                                  });
//                                });
                              }),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void showCenterShortToast(message) {
//    Fluttertoast.showToast(
//        msg: message,
//        toastLength: Toast.LENGTH_SHORT,
//        gravity: ToastGravity.CENTER,
//        timeInSecForIos: 1);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
  }
}
