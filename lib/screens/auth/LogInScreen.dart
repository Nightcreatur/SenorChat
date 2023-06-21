import 'dart:developer';
import 'dart:io';

import 'package:chat_app/api/api.dart';
import 'package:chat_app/helper/dialogs.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/screens/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAnimated = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isAnimated = true;
      });
    });
  }

  _handleGoogleButtonClick() {
    Dialogs.showProgressBar(context);
    _signInWithGoogle().then((user) async {
      Navigator.pop(context);
      if (user != null) {
        if (await Api.userExist()) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const HomeScreen()));
        } else {
          await Api.createUSer().then((value) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const HomeScreen()));
          });
        }
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await Api.auth.signInWithCredential(credential);
    } catch (e) {
      log('_signInWithGoogle: $e');
      Dialogs.showSnackBar(context, 'Something went wrong,check internet');
    }
    return null;

    // Once signed in, return the UserCredential
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            AnimatedPositioned(
                duration: Duration(seconds: 1),
                top: _isAnimated ? mq.height * .15 : -mq.height * .5,
                width: mq.width * .4,
                left: mq.width * .3,
                child: Image.asset('assets/images/chat.png')),
            AnimatedPositioned(
              duration: Duration(seconds: 2),
              top: mq.height * .4,
              width: mq.width * .5,
              left: mq.width * .25,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 1500),
                child: const Text(
                  'Welcom to Senor Chat!',
                  style: TextStyle(fontSize: 18),
                ),
                opacity: _isAnimated ? 1 : 0,
              ),
            ),
            Positioned(
                bottom: mq.height * .15,
                width: mq.width * .5,
                height: mq.width * .09,
                left: mq.width * .25,
                child: ElevatedButton.icon(
                    onPressed: () {
                      _handleGoogleButtonClick();
                    },
                    icon: Image.asset(
                      'assets/images/google.png',
                      height: mq.height * .03,
                    ),
                    label: RichText(
                        text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            children: [
                          TextSpan(text: 'Sign In with '),
                          TextSpan(
                              text: 'Google',
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ])))),
          ],
        ),
      ),
    );
  }
}
