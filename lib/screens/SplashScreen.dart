import 'package:chat_app/screens/auth/LogInScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    Future.delayed(Duration(milliseconds: 1500), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    });
  }

  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
                top: mq.height * .15,
                width: mq.width * .4,
                left: mq.width * .3,
                child: Image.asset('assets/images/chat.png')),
            Positioned(
              top: mq.height * .4,
              width: mq.width * .5,
              left: mq.width * .25,
              child: const Text(
                'Welcom to Senor Chat!',
                style: TextStyle(fontSize: 18),
              ),
            ),
            // Positioned(
            //   bottom: mq.height * .15,
            //   width: mq.width,
            //   child: const Text(
            //     'Giga Chat 💪',
            //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            //     textAlign: TextAlign.center,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
