import 'package:chat/pages/chatMessages.dart';
import 'package:chat/pages/create-room.dart';
import 'package:chat/pages/home.dart';
import 'package:chat/services/server.service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    MySocketServer().initNetwork();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, brightness: Brightness.dark,),
      initialRoute: "/",
      routes: {
        "/": (context) => Home(),
        "/connect": (context) => MyForm(),
        "/j": (context) => chatMessages(
              roomName: 'g',
              ip: 'localhost',
            )
      },
    );
  }
}
