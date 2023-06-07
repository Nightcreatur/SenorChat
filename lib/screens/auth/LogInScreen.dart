import 'package:chat_app/main.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          AnimatedPositioned(
              duration: Duration(seconds: 1),
              top: mq.height * .15,
              width: mq.width * .4,
              left: mq.width * .3,
              child: Image.asset('assets/images/chat.png')),
          Positioned(
              bottom: mq.height * .15,
              width: mq.width * .5,
              height: mq.width * .09,
              left: mq.width * .25,
              child: ElevatedButton.icon(
                  onPressed: () {},
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
    );
  }
}
