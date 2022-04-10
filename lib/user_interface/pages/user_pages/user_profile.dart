import 'package:counselingapp/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserPage extends StatefulWidget {
  static String route = "user";
  final String? userId;

  const UserPage({Key? key, this.userId}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
// initializing some values
  File? _image;
  final imagePicker = ImagePicker();
  String? downloadURL;

  // picking the image

  Future imagePickerMethodGallery() async {
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      } else {
        showSnackBar("No File selected", const Duration(milliseconds: 400));
      }
    });
  }

  Future imagePickerMethodCamera() async {
    final pick = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      } else {
        showSnackBar("No File selected", const Duration(milliseconds: 400));
      }
    });
  }

  // uploading the image to firebase cloudstore
  Future uploadImage(File _image) async {
    final imgId = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('${widget.userId}/images')
        .child("post_$imgId");

    await reference.putFile(_image);
    downloadURL = await reference.getDownloadURL();

    // cloud firestore
    await firebaseFirestore
        .collection("users")
        .doc(widget.userId)
        .collection("images")
        .add({'downloadURL': downloadURL}).whenComplete(
            () => showSnackBar("Image Uploaded", const Duration(seconds: 2)));
  }

  final double opacity = 0.4;
  final TextEditingController forgotPasswordController =
      TextEditingController();
  bool isLoading = false;

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

//for change password
  Future<bool> _changePassword() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.blue.shade100,
            title: Column(
              children: [
                const Text(
                  'Change Password',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                Text(
                  "${loggedInUser.firstName} ${loggedInUser.secondName}",
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            ),
            content: isLoading
                ? const Center(
                    child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
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
                                hintText: 'Your Email',
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
                                    msg:
                                        "Requested, Kindly wait for the Email!");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const UserPage()));
                              });
                            },
                            child: const Text("Send Request"),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                                left: 20,
                              ),
                              child: Text(
                                "Reminder: !!Make Sure Your New Password Composes 8 Characters Long!!",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade300,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel',
                    style: TextStyle(
                      color: Colors.red,
                    )),
              ),
            ],
          ),
        )) ??
        false;
  }

  Future<String?> openDialog() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            SingleChildScrollView(
              child: Center(
                child: Row(
                  children: [
                    const Icon(Icons.picture_in_picture),
                    TextButton(
                      onPressed: imagePickerMethodGallery,
                      child: const Text('Gallery'),
                    ),
                    const Spacer(),
                    const Icon(Icons.camera),
                    TextButton(
                      onPressed: imagePickerMethodCamera,
                      child: const Text(
                        'Camera',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Profile"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blueAccent[400]),
          onPressed: () {
            //passing to root
            Navigator.of(context).pop();
          },
        ),
      ),
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 200,
                  child: Card(
                    child: _image == null
                        ? const Center(child: Text("No image selected"))
                        : Image.file(_image!),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        openDialog();
                      },
                      child: const Text('Select Image'),
                    ),
                    const Text(' '),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          //background color
                          primary: const Color(0xFF81C784),
                          //foreground color
                          //onPrimary: ,
                        ),
                        onPressed: () {
                          if (_image != null) {
                            uploadImage(_image!);
                          } else {
                            showSnackBar("Select Image first",
                                const Duration(milliseconds: 400));
                          }
                        },
                        child: const Text("Upload")),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Name: ${loggedInUser.secondName}, ${loggedInUser.firstName} ",
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Email: ${loggedInUser.email}",
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      _changePassword();
                    },
                    child: const Text('Change Password')),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(content: Text(snackText), duration: d);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
