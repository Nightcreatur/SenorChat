import 'dart:developer';
import 'dart:io';
import 'package:chat_app/models/chat_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Api {
  // for fire authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

// for accesing firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

// to store self info
  static late ChatUser me;

  // to access storage server
  static FirebaseStorage storage = FirebaseStorage.instance;

  static Future<void> getSelfInfo() async {
    await firestore.collection('users').doc(users.uid).get().then((user) async {
      if (user.exists) {
        me = ChatUser.fromJson(user.data()!);
      } else {
        await createUSer().then((value) => getSelfInfo());
      }
    });
  }

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

  static Stream<QuerySnapshot<Map<String, dynamic>>> getUsers() {
    return firestore
        .collection('users')
        .where('id', isNotEqualTo: users.uid)
        .snapshots();
  }

  static Future<void> updateUserInfo() async {
    await firestore
        .collection('users')
        .doc(users.uid)
        .update({'name': me.name, 'about': me.about});
  }

  static Future<void> updateProfilePicture(File file) async {
    final ext = file.path.split('.').last;
    final ref = storage.ref().child('pofile_picture/${users.uid}.$ext');
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data transfer:${p0.bytesTransferred / 1000}kb');
    });

    await firestore
        .collection('users')
        .doc(users.uid)
        .update({'image': me.image});
  }
}
