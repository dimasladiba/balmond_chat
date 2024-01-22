import 'package:balmond_chat/chat_room_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:oktoast/oktoast.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Contact List",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
        ),
      ),
      body: StreamBuilder<List<types.User>>(
          stream: FirebaseChatCore.instance.users(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(
                  bottom: 200,
                ),
                child: const Text('No contact'),
              );
            }
            List<types.User> users = snapshot.data!;
            return ListView.builder(
              itemBuilder: (context, i) {
                return ListTile(
                  onTap: () async {
                    showToast("Please wait");
                    FirebaseChatCore.instance.createRoom(users[i]).then(
                        (value) => Navigator.of(context).push(MaterialPageRoute(
                            builder: (c) => ChatRoomPage(room: value))));
                  },
                  leading: CircleAvatar(
                    child: Icon(Icons.person_2),
                  ),
                  title: Text(
                    "${users[i].firstName!} ${users[i].lastName!}",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                );
              },
              itemCount: users.length,
            );
          }),
    );
  }
}
