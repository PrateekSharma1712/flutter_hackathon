import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon/dialogflow/dialog_flow_service.dart';
import 'package:flutter_hackathon/widgets/chat_message_widget.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var resp = "";
  TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<DialogFlowService>(context).request("Hi How can you help me").then((result) {
      setState(() {
        resp = result;
      });
    });

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          FractionallySizedBox(
            alignment: Alignment.topCenter,
            heightFactor: 0.8,
            child: StreamBuilder(
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? Center(child: CircularProgressIndicator())
                    : _buildChatList(context, snapshot.data.documents);
              },
            ),
          ),
          FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: 0.2,
            child: Container(
              padding: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius:
                    BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: _textEditingController,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                              border: InputBorder.none,
                              hintText: "Type something",
                              hintStyle:
                              TextStyle(color: Colors.white30, fontSize: 14, fontStyle: FontStyle.italic)),
                          textInputAction: TextInputAction.send,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.send, color: Colors.white, size: 20,),
                      ),
                    ],
                  ),
                  Spacer()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatList(BuildContext context, List<DocumentSnapshot> snapshots) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return ChatMessageWidget(isUser: false, message: "Hi");
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 10);
      },
      itemCount: 10,
    );
  }
}
