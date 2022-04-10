import 'package:counselingapp/main_screens/display_users_accounts.dart';
import 'package:counselingapp/user_interface/pages/counseling_pages/counseling_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:counselingapp/home/student_home_screen.dart';
import 'package:counselingapp/main_screens/login_screen.dart';
import 'package:counselingapp/main_screens/registration_screen.dart';

import 'package:counselingapp/main_screens/splash_screen.dart';

import 'package:counselingapp/user_interface/pages/about_pages/about_page.dart';
import 'package:counselingapp/user_interface/pages/brown_bag_pages/brownbag_session.dart';
import 'package:counselingapp/user_interface/pages/counseling_pages/chat_pages/chat_home_screen.dart';
import 'package:counselingapp/user_interface/pages/exit_interview_pages/exit_interview.dart';
import 'package:counselingapp/user_interface/pages/psychological_pages/psychological_page.dart';

import 'package:counselingapp/user_interface/pages/user_pages/user_profile.dart';
import 'package:counselingapp/user_interface/pages/counseling_pages/video_chat_pages/video_counseling.dart';
import 'package:counselingapp/home/admin_home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    upload();
  }

  Future upload() async {
    // initialize firebase
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BukSU Guidance App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        SplashScreen.route: (context) => const SplashScreen(),
        LoginScreen.route: (context) => const LoginScreen(),
        RegistrationScreen.route: (context) => const RegistrationScreen(),
        HomeScreen.route: (context) => const HomeScreen(),
        AboutPage.route: (context) => const AboutPage(),
        BrownBagPage.route: (context) => const BrownBagPage(),
        ChatHomeScreen.route: (context) => const ChatHomeScreen(),
        ExitInterviewPage.route: (context) => const ExitInterviewPage(),
        PsychologicalTestPage.route: (context) => const PsychologicalTestPage(),
        UserPage.route: (context) => const UserPage(),
        VideoCounselingPage.route: (context) => const VideoCounselingPage(),
        CounselingPage.route: (context) => const CounselingPage(),
        AdminHomeScreen.route: (context) => const AdminHomeScreen(),
        DisplayAppUsers.route: (context) => const DisplayAppUsers(),
      },
      initialRoute: AdminHomeScreen.route,
    );
  }
}

// Variant: debugAndroidTest
// Config: debug
// Store: C:\Users\Dell\.android\debug.keystore
// Alias: AndroidDebugKey
// MD5: A9:13:8A:21:56:77:C3:38:85:82:89:A9:12:CC:A4:02
// SHA1: 1E:2D:64:14:01:92:65:98:4C:12:83:95:95:ED:46:BC:A1:B5:FC:48
// SHA-256: C0:E0:41:98:C7:E5:8D:33:50:F6:2D:08:20:D4:C4:E9:85:41:D2:AE:81:FE:58:3E:41:A9:F9:F2:7E:F5:3D:C0
// Valid until: Monday, March 20, 2051

