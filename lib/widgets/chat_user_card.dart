import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/models/chat_user.dart';

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
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              height: mq.height * .06,
              width: mq.height * .06,
              imageUrl: widget.user.image,
              placeholder: (context, url) => const Icon(Icons.person),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          title: Text(widget.user.name),
          subtitle: Text(
            widget.user.about,
            maxLines: 1,
          ),
          trailing: Container(
            height: 15,
            width: 15,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 41, 215, 47),
                borderRadius: BorderRadius.circular(30)),
          ),
          // trailing: const Text('12:00 PM'),
        ),
      ),
    );
  }
}
