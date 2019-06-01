import 'dart:async';

import '../chat_message.dart';
import '../chat_message_widget.dart';

class ChatBloc {

  StreamController _controller = StreamController<ChatMessage>();

  Stream<ChatMessage> get chatStream => _controller.stream;
  StreamSink<ChatMessage> get chatSink => _controller.sink;

  dispose() {
    _controller.close();
  }
}