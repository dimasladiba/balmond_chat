import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';


class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({super.key, required this.room});
  final types.Room room;

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final List<types.Message> _messages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    
    
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          title: Text(widget.room.name ?? "Chat"),
        ),
        body: StreamBuilder<types.Room>(
          initialData: widget.room,
          stream: FirebaseChatCore.instance.room(widget.room.id),
          builder: (context, snapshot) => StreamBuilder<List<types.Message>>(
            initialData: const [],
            stream: FirebaseChatCore.instance.messages(snapshot.data!),
            builder: (context, snapshot) => Chat(
              showUserNames: true,
              showUserAvatars: true,
              onMessageTap: _onMessageTap,
              messages: snapshot.data ?? [],
              onSendPressed: _handleSendPressed,
              user: types.User(
                id: FirebaseChatCore.instance.firebaseUser?.uid ?? '',
              ),
            ),
          ),
        ),
      );

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  String randomString() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  void _onMessageTap(BuildContext context, types.Message message){
    print(message.toJson());
  }

  void _handleSendPressed(types.PartialText message) {
    FirebaseChatCore.instance.sendMessage(
      message,
      widget.room.id,
    );    
  }
}