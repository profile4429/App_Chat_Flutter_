import 'dart:io';
import 'dart:ui';
import 'dart:async';

import 'package:app_chat/helper/helperfunctions.dart';
import 'package:app_chat/services/storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_chat/services/database.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _profileState();
}

class _profileState extends State<Profile> {
  late final ref = FirebaseDatabase.instance;
  late DatabaseReference databaseReference;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController fullNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmTextEditingController = TextEditingController();
  DatabaseMethods dbMethods = DatabaseMethods();
  StorageMethods storageMethods = StorageMethods();

  Future fetchData() async {
    String? email = await HelperFunctions.getUserEmailsharedPreference();
    if (email != null) {
      var user = await dbMethods.getUserbyUserEmail(email);
      if (user != null) {
        setState(() {
          userNameTextEditingController.text = user['username'];
          fullNameTextEditingController.text = user['fullname'];
          emailTextEditingController.text = user['email'];
        });
      }
    }
  }

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser() {
    return users
        .doc('ABC123')
        .set({
          'fullname': fullNameTextEditingController.text,
          'password': passwordTextEditingController.text
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Profile"),
        elevation: 0.0,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1),
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            _auth.currentUser!.photoURL.toString()),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(180.0, 100.0, 0.0, 0.0),
                child: CircleAvatar(
                  backgroundColor: Colors.lightBlue,
                  child: IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      try {
                        File image;
                        //Get the file from the image picker and store it
                        var _imagePicker = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        image = File(_imagePicker!.path);
                        storageMethods.upProfilePicture(image);
                      } catch (e) {
                        print(e.toString());
                      }
                    },
                  ),
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 400,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextField(
                      controller: userNameTextEditingController,
                      decoration: InputDecoration(
                        enabled: false,
                        labelText: "User Name",
                        hintText: "User name",
                        hintStyle: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    TextField(
                      controller: emailTextEditingController,
                      decoration: InputDecoration(
                          enabled: false,
                          labelText: "Email",
                          hintText: "Email"),
                    ),
                    TextField(
                      controller: fullNameTextEditingController,
                      decoration: InputDecoration(
                          labelText: "Fullname", hintText: "Fullname"),
                    ),
                    TextField(
                      controller: passwordTextEditingController,
                      decoration: InputDecoration(
                          labelText: "PassWord", hintText: "PassWord"),
                    ),
                    Container(
                      height: 45,
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({
                            'fullname': fullNameTextEditingController.text,
                          }).then((value) => showDialog(context: context, builder: (BuildContext context){
                            return AlertDialog(
                              title: Text("Success"),
                            );
                          }     ));
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue)),
                        child: const Center(
                          child: Text(
                            "Update",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      )),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xff555555);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 100, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
