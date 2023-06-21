import 'package:chat_app/api/api.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/models/chat_user.dart';
import 'package:chat_app/widgets/chat_user_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<ChatUser> list = [];
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(CupertinoIcons.home),
        title: Text(
          'Senor Chat',
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: StreamBuilder(
          stream: Api.firestore.collection('users').snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case ConnectionState.active:
              case ConnectionState.done:
                final data = snapshot.data?.docs;
                list = data?.map((e) => ChatUser.fromJson(e.data())).toList() ??
                    [];
                if (list.isNotEmpty) {
                  return ListView.builder(
                      padding: EdgeInsets.only(top: mq.height * 0.01),
                      physics: BouncingScrollPhysics(),
                      itemCount: data!.length,
                      itemBuilder: (context, index) {
                        return ChatUserCard(
                          user: list[index],
                        );
                      });
                } else {
                  return Center(
                      child: Text(
                    'No Connection Found !',
                    style: TextStyle(fontSize: 18),
                  ));
                }
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Api.auth.signOut();
          await GoogleSignIn().signOut();
        },
        child: Icon(Icons.add_comment_rounded),
      ),
    );
  }
}
