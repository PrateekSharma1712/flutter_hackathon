import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon/database/database_collections.dart';

class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Firestore db = Firestore.instance;
  CollectionReference refereance;
  String _userEmail = "viv@test.com";

  var listMessage;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    refereance = db.collection(DatabaseCollections.USER_CHATS);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isSender = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              onPressed: () {
                refereance.add({
                  "email": _userEmail,
                  "message": "HIIII",
                  "created": new DateTime.now().millisecondsSinceEpoch,
                  "is_sender": !isSender
                }).then((value) {
                  print("added");
                }).catchError((e) {
                  print("not added");
                });
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Container(
        child: StreamBuilder(
          stream: refereance.where("email",isEqualTo: _userEmail).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              listMessage = snapshot.data.documents;
              return ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemBuilder: (context, index) =>
                    buildItem(index, snapshot.data.documents[index]),
                itemCount: snapshot.data.documents.length,
                reverse: true,
              );
            }
          },
        ),
      ),
    );
  }

  buildItem(index, document) {
    return Text("HI");
  }
}
