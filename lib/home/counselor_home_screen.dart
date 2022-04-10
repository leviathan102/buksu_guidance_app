import 'dart:ui';

import 'package:counselingapp/main_screens/login_screen.dart';
import 'package:counselingapp/models/user_model.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CounselorHomeScreen extends StatefulWidget {
  const CounselorHomeScreen({Key? key}) : super(key: key);
  static String route = "home";

  @override
  _CounselorHomeScreenState createState() => _CounselorHomeScreenState();
}

class _CounselorHomeScreenState extends State<CounselorHomeScreen> {
  final double opacity = 0.2;
  //connect data from firebase
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  @override
  void initState() {
    // TODOimplement initState
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      // ignore: unnecessary_this
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  //handle device back button
  Future<bool> _onBackPressed() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.blue.shade100,
            title: const Text(
              'Alert!!',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            content: const Text('Do you want to exit the App?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Stay',
                    style: TextStyle(
                      color: Colors.green,
                    )),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Exit',
                    style: TextStyle(
                      color: Colors.red,
                    )),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              const Text(
                "Guidance Counselor",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "${loggedInUser.firstName} ${loggedInUser.secondName}",
                style: const TextStyle(fontSize: 10),
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,

          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Icon(Icons.logout_outlined),
            ),
          ],
          //elevation: 0,
        ),
        backgroundColor: const Color(0xFF509BE4),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: double.maxFinite,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/backgrounds%2Fluke-chesser-3rWagdKBF7U-unsplash.jpg?alt=media&token=9c5fd84c-2d31-4772-91c5-6e2be82797ba"),
                  fit: BoxFit.cover,
                ),
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
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 50,
                      ),
                      child: Image.network(
                        "https://buksu.edu.ph/wp-content/uploads/2020/05/buksu-logo-min.png",
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 200,
                      width: 500,
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
                          ),
                          child: Column(
                            children: [
                              const Text('Chat'),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 150,
                                  width: 300,
                                  child: Card(
                                    child: Column(
                                      children: const [
                                        Text('Request'),
                                        Text('Done')
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 200,
                      width: 500,
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
                        ),
                        child: Column(
                          children: [
                            const Text('VideoChat'),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 150,
                                width: 300,
                                child: Card(
                                  child: Column(
                                    children: const [
                                      Text('Request'),
                                      Text('Done')
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 200,
                      width: 500,
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
                        ),
                        child: Column(
                          children: [
                            const Text('Psycholgical Test'),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 150,
                                width: 300,
                                child: Card(
                                  child: Column(
                                    children: const [
                                      Text('Request'),
                                      Text('Done')
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 200,
                      width: 500,
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
                        ),
                        child: Column(
                          children: [
                            const Text('Exit Interview'),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 150,
                                width: 300,
                                child: Card(
                                  child: Column(
                                    children: const [
                                      Text('Request'),
                                      Text('Done')
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 200,
                      width: 500,
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
                        ),
                        child: Column(
                          children: [
                            const Text('Brownbag Session Statistics'),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 150,
                                width: 300,
                                child: Card(
                                  child: Column(
                                    children: const [
                                      Text('Request'),
                                      Text('Done')
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
