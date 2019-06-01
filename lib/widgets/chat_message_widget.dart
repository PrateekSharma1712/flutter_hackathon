import 'package:flutter/material.dart';
import 'package:auro_avatar/auro_avatar.dart';

class ChatMessageWidget extends StatelessWidget {
  final bool isUser;
  final String message;

  ChatMessageWidget({this.isUser, this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if(!isUser)
          InitialNameAvatar(
          'John Doe',
          circleAvatar: true,
          borderColor: Colors.grey,
          borderSize: 4.0,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          padding: 20.0,
          textSize: 30.0,
        ),
        SizedBox(width: 20),
        Expanded(
          flex: 4,
          child: Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Text(
              message,
              style: TextStyle(color: isUser ? Colors.white : Colors.black, fontSize: 14.0),
            ),
          ),
        ),
        Spacer(flex: 1),
      ],
    );
  }
}
