import 'package:chat_app/models/chat_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Api {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static User get users => auth.currentUser!;
  static Future<bool> userExist() async {
    return (await firestore.collection('users').doc(users.uid).get()).exists;
  }

  static Future<void> createUSer() async {
    final time = DateTime.now().microsecondsSinceEpoch.toString();
    final user = ChatUser(
        isOnline: false,
        id: users.uid,
        createdAt: time,
        pushToken: '',
        image: users.photoURL.toString(),
        email: users.email.toString(),
        about: "Hey",
        lastActive: time,
        name: users.displayName.toString());
    return await firestore
        .collection('users')
        .doc(users.uid)
        .set(user.toJson());
  }
}
