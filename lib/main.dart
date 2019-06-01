import 'package:firebase_mlkit_language/firebase_mlkit_language.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

final LanguageIdentifier languageIdentifier =
    FirebaseLanguage.instance.languageIdentifier();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ML Kit Demo")),
      body: Column(
        children: <Widget>[
          TextField(
            controller: textController,
          ),
          FlatButton(
              child: Text("IDENTIFY"),
              onPressed: () async {
                String text = textController.text;

                final List<LanguageLabel> labels =
                    await languageIdentifier.processText(text);
                for (LanguageLabel label in labels) {
                  final String text = label.toString();
                  final double confidence = label.confidence;
                  print("Text: " + text);
                  print("Confidence: " + confidence.toString());
                }
              }),
        ],
      ),
    );
  }
}
