import 'dart:ui';

import 'package:counselingapp/home/student_home_screen.dart';
import 'package:counselingapp/main_screens/forgot_password_screen.dart';

import 'package:counselingapp/main_screens/registration_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String route = "login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
//bool for obscure text
  bool _obscureText = true;

//form key
  final _formKey = GlobalKey<FormState>();

//editing controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  final double opacity = 0.40;

  //firebase auth
  //final _auth = FirebaseAuth.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //email field
    final emailField = TextFormField(
      cursorColor: Colors.blue,
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Email");
        }
        //reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter Valid Email");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        focusColor: Colors.red,
        fillColor: Colors.lightBlue,
        prefixIcon: const Icon(
          Icons.mail,
          color: Colors.blueAccent,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: "Email",
        hoverColor: Colors.blueAccent,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //password field
    final passwordField = TextFormField(
      cursorColor: Colors.blue,
      autofocus: false,
      controller: passwordController,
      obscureText: _obscureText,
      validator: (value) {
        RegExp regex = RegExp(r'^.{8,}$');
        if (value!.isEmpty) {
          return ("Password is Required for Login");
        }
        if (!regex.hasMatch(value)) {
          return ("Minimum of 8 Characters Long");
        }
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        fillColor: Colors.lightBlue,
        prefixIcon: const Icon(
          Icons.vpn_key,
          color: Colors.red,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    // forgot password
    final forgotPassword = Material(
      color: Colors.transparent,
      child: Positioned(
        child: SizedBox(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ForgotPassword()));
            },
            child: const Text(
              "Forgot Password?",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 15,
                  decoration: TextDecoration.underline,
                  color: Colors.red,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
    //Login Button
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.lightGreenAccent,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          if (emailController.text.isNotEmpty &&
              passwordController.text.isNotEmpty) {
            setState(() {
              isLoading = true;
            });
          }

          signIn(emailController.text, passwordController.text);
        },
        child: const Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return MaterialApp(
      theme: ThemeData.light().copyWith(
          //hintColor: Colors.blue,
          ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: isLoading
            ? Center(
                child: SizedBox(
                  height: size.height / 20,
                  width: size.height / 20,
                  child: const CircularProgressIndicator(
                    color: Colors.lightGreen,
                  ),
                ),
              )
            : Center(
                child: Stack(
                  children: [
                    Container(
                      constraints: const BoxConstraints.expand(),
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
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 60,
                          ),
                          child: Form(
                            key: _formKey,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(opacity),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                border: Border.all(
                                  width: 1.5,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                              ),
                              //color: const Color.fromRGBO(63, 255, 255, 90),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    const SizedBox(height: 85),
                                    SizedBox(
                                      height: 200,
                                      child: Image.asset(
                                        './asset/theraphy.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    const Text(
                                      "Sign in to Continue",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.yellow,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 45),
                                    emailField,
                                    const SizedBox(height: 25),
                                    passwordField,
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    forgotPassword,
                                    const SizedBox(height: 35),
                                    loginButton,
                                    const SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        const Text("Don't Have an Account?"),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const RegistrationScreen()));
                                          },
                                          child: const Text(
                                            "Sign Up",
                                            style: TextStyle(
                                                color: Colors.redAccent,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
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

  //login function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Successful"),
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (Route<dynamic> route) => false,
                ),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
