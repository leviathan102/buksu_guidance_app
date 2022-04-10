import 'dart:ui';
import 'dart:async';

import 'package:counselingapp/models/user_model.dart';

import 'package:counselingapp/navigation_bar/student_nav.dart';
import 'package:counselingapp/user_interface/pages/about_pages/about_page.dart';
import 'package:counselingapp/user_interface/pages/counseling_pages/counseling_pages.dart';
import 'package:counselingapp/user_interface/pages/user_pages/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';

import 'package:flutter/cupertino.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String route = "home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  String action = "Home";
  final double opacity = 0.2;
  //connect data from firebase
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  @override
  void initState() {
    // TODOimplement initState
    super.initState();
    _setMarker(const LatLng(
      8.157201,
      125.124619,
    ));
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

  //for maps
  final Completer<GoogleMapController> _mapController = Completer();

  final Set<Marker> _markers = <Marker>{};

  static const CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(
      8.157201,
      125.124619,
    ),
    tilt: 59.440717697143555,
    zoom: 17.151926040649414,
  );

  void _setMarker(LatLng points) {
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('marker'),
          position: points,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        extendBody: true,
        drawer: const NavigationDrawerWidget(),
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 8,
                ),
                child: Column(
                  children: [
                    const Text(
                      "Welcome",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "${loggedInUser.firstName} ${loggedInUser.secondName}",
                      style: const TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 50,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, UserPage.route);
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.blue.shade200,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          //elevation: 0,
        ),
        backgroundColor: const Color(0xFF000000),
        body: Center(
          child: Stack(
            children: [
              Container(
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
                  gradient: const RadialGradient(
                    center: Alignment.center,
                    radius: 1,
                    colors: <Color>[Color(0xFF4FC3F7), Color(0xFFB2EBF2)],
                    stops: [0, 1],
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 50,
                          ),
                          child: Image.asset(
                            "./asset/logo.png",
                            height: 150,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
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
                          width: double.maxFinite,
                          child: const Text(
                            "Welcome to Bukidnon State University Guidance Application",
                            style: TextStyle(
                              color: Color(0xFF000000),
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              decoration: TextDecoration.none,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 300,
                          child: GoogleMap(
                            mapType: MapType.hybrid,
                            markers: _markers,
                            initialCameraPosition: _kLake,
                            onMapCreated: (GoogleMapController controller) {
                              _mapController.complete(controller);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: FloatingNavbar(
          onTap: (int val) {
            switch (val) {
              case 0:
                {
                  action = "Home";
                }
                break;

              case 1:
                {
                  action = "Explore";
                  Navigator.pushNamed(
                      context, CounselingPage.route); //statements;
                }
                break;
              case 2:
                {
                  action = "Chats";
                  const Text('Chat with me ...');
                }
                break;
              case 3:
                {
                  action = "About";
                  Navigator.pushNamed(context, AboutPage.route);
                }
                break;
              default:
                {
                  //statements;
                }
                break;
            }

            setState(() => _index = val);
          },
          currentIndex: _index,
          items: [
            FloatingNavbarItem(icon: Icons.home, title: 'Home'),
            FloatingNavbarItem(icon: Icons.add_task, title: 'Request'),
            FloatingNavbarItem(icon: Icons.chat_bubble_outline, title: 'Chats'),
            FloatingNavbarItem(icon: Icons.info_rounded, title: 'About'),
          ],
        ),
      ),
    );
  }
}
