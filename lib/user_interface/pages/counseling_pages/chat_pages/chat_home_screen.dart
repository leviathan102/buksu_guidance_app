import 'package:flutter/material.dart';

class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({Key? key}) : super(key: key);
  static String route = "chat";

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  final double opacity = 0.2;
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Chat Counseling'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.blueAccent[400]),
            onPressed: () {
              //passing to root
              Navigator.of(context).pop();
            },
          ),
        ),
        backgroundColor: const Color(0xFF000000),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(opacity),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              border: Border.all(
                width: 1.5,
                color: Colors.white.withOpacity(0.2),
              ),
              gradient: const RadialGradient(
                center: Alignment.center,
                radius: 1,
                colors: <Color>[Color(0xFF4FC3F7), Color(0xFFB2EBF2)],
                stops: [0, 1],
              ),
            ),
            child: Column(
              children: [Container()],
            ),
          ),
        ),
      );
}
