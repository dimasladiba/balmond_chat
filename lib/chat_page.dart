import 'package:balmond_chat/chat_room_page.dart';
import 'package:balmond_chat/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as type;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chat List",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                FirebaseAuth.instance.signOut().then((value) =>
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (c) => LoginPage()),
                        (route) => false));
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder<List<type.Room>>(
          stream: FirebaseChatCore.instance.rooms(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(
                  bottom: 200,
                ),
                child: const Text('No chat'),
              );
            }
            List<type.Room> rooms = snapshot.data!;
            return ListView.builder(
              itemBuilder: (context, i) {
                return ListTile(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                            builder: (c) => ChatRoomPage(room: rooms[i])));
                  },
                  leading: CircleAvatar(
                    child: Icon(Icons.person_2),
                  ),
                  title: Text(
                    rooms[i].name ?? "-",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  // subtitle: Text(rooms[i].lastMessages.first ?? "-"),
                );
              },
              itemCount: rooms.length,
            );
          }),
    );
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
