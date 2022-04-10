import 'package:flutter/material.dart';

class PsychologicalTestPage extends StatefulWidget {
  const PsychologicalTestPage({Key? key}) : super(key: key);
  static String route = "psychologicaltest";

  @override
  State<PsychologicalTestPage> createState() => _PsychologicalTestPageState();
}

class _PsychologicalTestPageState extends State<PsychologicalTestPage> {
  final double opacity = 0.2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Psychological Test'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        //elevation: 0,
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
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(opacity),
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            border: Border.all(
              width: 1.5,
              color: Colors.white.withOpacity(0.2),
            ),
            image: const DecorationImage(
              image: NetworkImage(
                  "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/backgrounds%2Fluke-chesser-3rWagdKBF7U-unsplash.jpg?alt=media&token=9c5fd84c-2d31-4772-91c5-6e2be82797ba"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Request'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//for personality test
//https://www.16personalities.com/free-personality-test
//https://my-personality-test.com/personality-type-indicator