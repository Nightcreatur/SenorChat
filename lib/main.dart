import 'package:chat_app/screens/auth/LogInScreen.dart';
import 'package:flutter/material.dart';

late Size mq;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            elevation: 1,
          ),
        ),
        home: const LoginScreen());
  }
}