import 'package:chat_app/models/chat_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatUserCard extends StatefulWidget {
  const ChatUserCard({super.key, required this.user});
  final ChatUser user;

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: ListTile(
          leading: CircleAvatar(
            child: Icon(CupertinoIcons.person),
          ),
          title: Text(widget.user.name),
          subtitle: Text(
            widget.user.about,
            maxLines: 1,
          ),
          trailing: const Text('12:00 PM'),
        ),
      ),
    );
  }
}
