import 'dart:ui';

import 'package:counselingapp/main_screens/display_users_accounts.dart';
import 'package:counselingapp/main_screens/login_screen.dart';
import 'package:counselingapp/models/user_model.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);
  static String route = "admin-home";

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
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
                "Guidance Admin",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "${loggedInUser.firstName} ${loggedInUser.secondName}",
                style: const TextStyle(fontSize: 10),
              ),
            ],
          ),
          centerTitle: true,

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
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  width: 350,
                  height: 200,
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
                  child: Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: Row(
                            children: [
                              const Text('Users Statistics'),
                              const Spacer(),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, DisplayAppUsers.route);
                                },
                                child: const Text('Accounts'),
                              )
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.blue,
                        ),
                        const Text('User Count: ')
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  width: 350,
                  height: 200,
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
                  child: Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: Row(
                            children: [
                              const Text('Counseling Statistics'),
                              const Spacer(),
                              ElevatedButton(
                                onPressed: () {},
                                child: const Text('Button'),
                              )
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.blue,
                        ),
                        const Text('Chat Counseling: '),
                        const Text('VideoChat Counseling: '),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  width: 350,
                  height: 200,
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
                  child: Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: Row(
                            children: [
                              const Text('Exit Interview Statistics'),
                              const Spacer(),
                              ElevatedButton(
                                onPressed: () {},
                                child: const Text('Button'),
                              )
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.blue,
                        ),
                        const Text('Interviews: ')
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  width: 350,
                  height: 200,
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
                  child: Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: Row(
                            children: [
                              const Text('Psychological Test Statistics'),
                              const Spacer(),
                              ElevatedButton(
                                onPressed: () {},
                                child: const Text('Button'),
                              )
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.blue,
                        ),
                        const Text('Number of Request: ')
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
