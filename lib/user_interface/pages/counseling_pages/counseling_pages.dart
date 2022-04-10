import 'package:counselingapp/user_interface/pages/counseling_pages/chat_pages/chat_home_screen.dart';
import 'package:counselingapp/user_interface/pages/counseling_pages/video_chat_pages/video_counseling.dart';

import 'package:flutter/material.dart';
import 'package:counselingapp/models/user_model.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CounselingPage extends StatefulWidget {
  const CounselingPage({Key? key}) : super(key: key);
  static String route = "counseling";

  @override
  State<CounselingPage> createState() => _CounselingPageState();
}

class _CounselingPageState extends State<CounselingPage> {
  final double opacity = 0.2;
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

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;

    final chatButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: const Color.fromRGBO(139, 207, 240, 90),
      child: MaterialButton(
        padding: const EdgeInsets.only(
          left: 40,
          right: 30,
        ),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.pushNamed(context, ChatHomeScreen.route);
        },
        child: Row(
          children: const [
            Text(
              "Chat",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(
              Icons.chat,
              size: 40,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );

    final videoButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: const Color.fromRGBO(139, 207, 240, 90),
      child: MaterialButton(
        padding: const EdgeInsets.only(
          left: 40,
          right: 30,
        ),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.pushNamed(context, VideoCounselingPage.route);
        },
        child: Row(
          children: const [
            Text(
              "Video Chat",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(
              Icons.video_call,
              size: 40,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text(
              "Welcome to Counseling",
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
                    "https://buksu.edu.ph/wp-content/uploads/2020/06/i-love-buksu-wideshot-min.jpg"),
                fit: BoxFit.cover),
            gradient: const RadialGradient(
              center: Alignment.center,
              radius: 1,
              colors: <Color>[Color(0xFF4FC3F7), Color(0xFFB2EBF2)],
              stops: [0, 1],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 50,
              right: 50,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Center(
                    child: Image.network(
                      "https://buksu.edu.ph/wp-content/uploads/2020/05/buksu-logo-min.png",
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  chatButton,
                  const SizedBox(
                    height: 10,
                  ),
                  videoButton,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
