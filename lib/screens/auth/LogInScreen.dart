import 'package:chat_app/main.dart';
import 'package:flutter/material.dart';

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
      ),
    );
  }
}
