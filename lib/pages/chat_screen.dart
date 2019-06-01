import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon/database/database_collections.dart';
import 'package:flutter_hackathon/dialogflow/dialog_flow_service.dart';
import 'package:flutter_hackathon/widgets/chat_message_widget.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _textEditingController;
  Firestore db = Firestore.instance;
  CollectionReference reference;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    reference = db.collection(DatabaseCollections.USER_CHATS);
  }

  @override
  Widget build(BuildContext context) {
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
                          style:
                              TextStyle(color: Colors.white, fontSize: 14, fontStyle: FontStyle.normal),
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                              border: InputBorder.none,
                              hintText: "Type something",
                              hintStyle: TextStyle(
                                  color: Colors.white30, fontSize: 14, fontStyle: FontStyle.italic)),
                          textInputAction: TextInputAction.send,
                          onSubmitted: (text) {
                            sendQuery(text);
                            _textEditingController.clear();
                            _textEditingController.clearComposing();
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          sendQuery(_textEditingController.text);
                          _textEditingController.clear();
                          _textEditingController.clearComposing();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
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

  sendQuery(message) {

    Provider.of<DialogFlowService>(context).request(message).then((result) {

    });
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
