import 'package:counselingapp/main_screens/login_screen.dart';
import 'package:counselingapp/models/user_model.dart';
import 'package:counselingapp/home/student_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  static String route = "registration";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // bool
  bool _obscureText = true;

  // firebase auth
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  // our form key
  final _formKey = GlobalKey<FormState>();

  // editing Controllers
  final firstNameEditingController = TextEditingController();
  final secondNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();
  bool isLoading = false;

  final double opacity = 0.4;

  @override
  Widget build(BuildContext context) {
    //responsiveness
    final size = MediaQuery.of(context).size;
    //first name field
    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("First Name is Required");
        }
        if (!regex.hasMatch(value)) {
          return ("Minimum 3 Characters");
        }
        return null;
      },
      onSaved: (value) {
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon:
            const Icon(Icons.account_circle, color: Colors.lightBlueAccent),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: "First Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //second name field
    final secondNameField = TextFormField(
      autofocus: false,
      controller: secondNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Second Name is Required");
        }
        if (!regex.hasMatch(value)) {
          return ("Minimum 3 Characters");
        }
      },
      onSaved: (value) {
        secondNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon:
            const Icon(Icons.account_circle, color: Colors.lightBlueAccent),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: "Second Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
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
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.mail, color: Colors.blue),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: _obscureText,
      validator: (value) {
        RegExp regex = RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

        if (value!.isEmpty) {
          return ("Password is Required for Login");
        }
        if (!regex.hasMatch(value)) {
          return ("Password must Consist at least one [Uppercase, lowercase, numeric number and special character]");
        }
      },
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.vpn_key, color: Colors.red),
        errorMaxLines: 4, // number of lines the error text would wrap
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //confirm password field
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: _obscureText,
      validator: (value) {
        if (passwordEditingController.text.isEmpty) {
          return ("No Password Entered");
        }
        if (value!.isEmpty) {
          return ("Please Confirm Your Password");
        }
        if (confirmPasswordEditingController.text !=
            passwordEditingController.text) {
          return ("Password Don't Match");
        }

        return null;
      },
      onSaved: (value) {
        confirmPasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.vpn_key, color: Colors.red),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: "Confirm Password",
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //Sign Up Button
    final signupButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.lightGreenAccent,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          if (firstNameEditingController.text.isNotEmpty &&
              secondNameEditingController.text.isEmpty &&
              emailEditingController.text.isNotEmpty &&
              passwordEditingController.text.isNotEmpty &&
              confirmPasswordEditingController.text.isNotEmpty) {
            setState(() {
              isLoading = true;
            });
          }
          signUp(emailEditingController.text, passwordEditingController.text);
        },
        child: const Text(
          "Sign Up",
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
      //
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
                          color: Colors.white.withOpacity(0.7),
                        ),
                        image: const DecorationImage(
                          image: NetworkImage(
                              "https://buksu.edu.ph/wp-content/uploads/2020/11/DSC_6344.jpg"),
                          //AssetImage(
                          //'./asset/ground.jpg',
                          //),
                          fit: BoxFit.cover,
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
                              //color: const Color.fromRGBO(63, 255, 255, 90),
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
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                        height: 180,
                                        child: Image.asset(
                                          "./asset/talk.png",
                                          fit: BoxFit.contain,
                                        )),
                                    const Text(
                                      "Registration Here",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.yellow,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 45),
                                    firstNameField,
                                    const SizedBox(height: 20),
                                    secondNameField,
                                    const SizedBox(height: 20),
                                    emailField,
                                    const SizedBox(height: 20),
                                    passwordField,
                                    const SizedBox(height: 20),
                                    confirmPasswordField,
                                    const SizedBox(height: 20),
                                    signupButton,
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    //const SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        const Text(
                                          "Already Have an Account?",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const LoginScreen()));
                                          },
                                          child: const Text(
                                            "Sign In",
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

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        Text(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sending these values
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;
    userModel.secondName = secondNameEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account Created Successfully");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false);
  }
}
