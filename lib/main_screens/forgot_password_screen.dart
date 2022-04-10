import 'dart:ui';

import 'package:counselingapp/main_screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);
  static String route = "forgotpassword";

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final double opacity = 0.4;
  final TextEditingController forgotPasswordController =
      TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
      body: isLoading
          ? Center(
              child: SizedBox(
              height: size.height / 20,
              width: size.height / 20,
              child: const CircularProgressIndicator(
                color: Colors.lightGreen,
              ),
            ))
          : SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(opacity),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  border: Border.all(
                    width: 1.5,
                    color: Colors.black.withOpacity(0.2),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 200,
                      child: Image.asset(
                        './asset/logo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Text(
                      "Reset Password",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.lightBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        autofocus: false,
                        autocorrect: false,
                        controller: forgotPasswordController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.mail),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hoverColor: Colors.greenAccent,
                          hintText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (forgotPasswordController.text.isNotEmpty) {
                          setState(() {
                            isLoading = true;
                          });
                        }
                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(
                                email: forgotPasswordController.text)
                            .then((value) {
                          Fluttertoast.showToast(
                              msg: "Requested, Kindly wait for the Email!");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        });
                      },
                      child: const Text("Send Request"),
                    ),
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 10,
                          left: 20,
                        ),
                        child: Text(
                          "Alert: !!Make Sure Your New Password Composes 8 Characters Long!!",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
