import 'package:counselingapp/home/student_home_screen.dart';

import 'package:counselingapp/main_screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static String route = "splashscreen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //late double _progressValue;
  @override
  void initState() {
    super.initState();
    _navigatetohome();
    //_progressValue = 0.0;
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(seconds: 5), () {});
    if (_auth.currentUser != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 150,
              child: Image.asset(
                "./asset/splash.jpg",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: size.height / 80,
              width: size.width / 2,
              child: const LinearProgressIndicator(
                backgroundColor: Colors.greenAccent,
                //value: _progressValue,
              ),
            ),
            //Text('${(_progressValue * 100).round()}'),
          ],
        ),
      ),
    );
  }
}
