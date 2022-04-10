import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counselingapp/user_interface/pages/counseling_pages/counseling_pages.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:counselingapp/models/user_model.dart';
import 'package:counselingapp/user_interface/pages/about_pages/about_page.dart';
import 'package:counselingapp/user_interface/pages/brown_bag_pages/brownbag_session.dart';
import 'package:counselingapp/user_interface/pages/exit_interview_pages/exit_interview.dart';
import 'package:counselingapp/user_interface/pages/psychological_pages/psychological_page.dart';
import 'package:counselingapp/main_screens/login_screen.dart';

class NavigationDrawerWidget extends StatefulWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  final String? userId;

  const NavigationDrawerWidget({Key? key, this.userId}) : super(key: key);

  @override
  _NavigationDrawerWidgetState createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
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

  final hoverColor = Colors.amberAccent;
  final double opacity = 0.2;
  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return Drawer(
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(opacity),
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
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: <Widget>[
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SizedBox(
                          height: 150,
                          width: double.maxFinite,
                          child: Image.asset(
                            "./asset/logo.png",
                            fit: BoxFit.cover,
                            width: double.maxFinite,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(139, 207, 240, 90),
                              borderRadius: BorderRadius.circular(10)),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromRGBO(139, 207, 240, 90),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, CounselingPage.route);
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 15, 20, 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const <Widget>[
                                  Text(
                                    "Counseling",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  ImageIcon(
                                    AssetImage('./asset/talk.png'),
                                    size: 35,
                                    color: Colors.blueAccent,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(139, 207, 240, 90),
                              borderRadius: BorderRadius.circular(10)),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromRGBO(139, 207, 240, 90),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, PsychologicalTestPage.route);
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 15, 20, 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const <Widget>[
                                  Text(
                                    "Psychological Test",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  ImageIcon(
                                    AssetImage('./asset/brain.png'),
                                    size: 35,
                                    color: Colors.blueAccent,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(139, 207, 240, 90),
                              borderRadius: BorderRadius.circular(10)),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromRGBO(139, 207, 240, 90),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, ExitInterviewPage.route);
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 15, 20, 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const <Widget>[
                                  Text(
                                    "Exit Interview",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  ImageIcon(
                                    AssetImage('./asset/interview.png'),
                                    size: 35,
                                    color: Colors.blueAccent,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(139, 207, 240, 90),
                              borderRadius: BorderRadius.circular(10)),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromRGBO(139, 207, 240, 90),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, BrownBagPage.route);
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 15, 20, 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const <Widget>[
                                  Text(
                                    "Group Session",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  ImageIcon(
                                    AssetImage('./asset/session.png'),
                                    size: 35,
                                    color: Colors.blueAccent,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(139, 207, 240, 90),
                              borderRadius: BorderRadius.circular(10)),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              //background color
                              primary: const Color.fromRGBO(139, 207, 240, 90),
                              //foreground color
                              //onPrimary: ,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, AboutPage.route);
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 15, 20, 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const <Widget>[
                                  Text(
                                    "BukSU Guidance",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Icon(
                                    Icons.people,
                                    size: 35,
                                    color: Colors.blueAccent,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //user profile toggle
                      Center(
                        child: SingleChildScrollView(
                          child: Container(
                            //height: size.height / 4,
                            color: const Color.fromRGBO(139, 207, 240, 90),
                            child: Column(
                              children: <Widget>[
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 100,
                                  child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(widget.userId)
                                        .collection("images")
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (!snapshot.hasData) {
                                        return (const Center(
                                            child: Text("No Images Found")));
                                      } else {
                                        return Image.network(
                                          "https://buksu.edu.ph/wp-content/uploads/2020/11/DSC_6344.jpg",
                                          fit: BoxFit.cover,
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Text(
                                    "${loggedInUser.firstName} ${loggedInUser.secondName}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    )),
                                Text("${loggedInUser.email}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 100, right: 100),
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(139, 207, 240, 90),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextButton(
                              child: Row(
                                children: const [
                                  Text(
                                    "Logout",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(Icons.logout_outlined,
                                      color: Colors.red),
                                ],
                              ),
                              onPressed: () {
                                logOut(context);
                              }),
                        ),
                      ),

                      const Divider(color: Colors.white),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.copyright),
                          Text(
                            "Bukidnon State University",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        'Programmed by: Chritzan A. Sawayan',
                        style: TextStyle(
                          fontSize: 8,
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
    );
  }

  Future logOut(BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      await _auth.signOut().then((value) {
        //removing past route stock to handle logout service
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (Route<dynamic> route) => false,
        );
      });
    } catch (e) {
      return ("error");
    }
    return null;
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
