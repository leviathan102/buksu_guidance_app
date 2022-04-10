import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DisplayAppUsers extends StatefulWidget {
  static String route = 'display-users';
  const DisplayAppUsers({Key? key}) : super(key: key);

  @override
  State<DisplayAppUsers> createState() => _DisplayAppUsersState();
}

class _DisplayAppUsersState extends State<DisplayAppUsers> {
  //controller
  final firstNameEditingController = TextEditingController();
  final secondNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();

//for transparency
  final double opacity = 0.2;

//cally the firestore database
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Users Account'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: const Color(0xFF000000),
        body: Container(
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
          child: StreamBuilder(
            stream: _users.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(documentSnapshot['email']),
                        subtitle: Center(
                          child: Row(
                            children: [
                              Text(documentSnapshot['secondName']),
                              const Text(', '),
                              Text(documentSnapshot['firstName']),
                            ],
                          ),
                        ),
                        trailing: SizedBox(
                          width: 50,
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.blue.shade200,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      );
}
