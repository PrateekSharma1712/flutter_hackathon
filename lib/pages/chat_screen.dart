import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/flutter_dialogflow.dart';
import 'package:flutter_hackathon/constants/google_constants.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    init();

    return Scaffold(
      body: Container(),
    );
  }

  init() async {
    Dialogflow dialogFlow = Dialogflow(token: GoogleConstants.GOOGLE_CLIENT_KEY);
    AIResponse response = await dialogFlow.sendQuery("How can you help me?");
    print(response.getMessageResponse());
  }
}