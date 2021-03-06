import 'package:app_chat/helper/helperfunctions.dart';
import 'package:app_chat/main.dart';
import 'package:app_chat/services/auth.dart';
import 'package:app_chat/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_chat/chat_room/chatRoomScreen.dart';
import 'package:app_chat/services/database.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingController =
      new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();
  TextEditingController fullNameTextEditingController =
      new TextEditingController();

  signMeUp() async {
    if (formKey.currentState!.validate()) {
      Map<String, String> userInfoMap = {
        "username": userNameTextEditingController.text,
        "email": emailTextEditingController.text,
        "fullname": fullNameTextEditingController.text,
        "password": passwordTextEditingController.text,
        "photoUrl":'',
      };

      HelperFunctions.saveUserEmailsharedPreference(
          emailTextEditingController.text);
      HelperFunctions.saveUserNamesharedPreference(
          userNameTextEditingController.text);
      //HelperFunctions.saveUserNamesharedPreference(userNameTextEditingController.text);

      setState(() {
        isLoading = true;
      });

     await authMethods
          .signUpwithEmailAndPassword(
              userNameTextEditingController.text,
              fullNameTextEditingController.text,
              emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((val) {
        //print("${val.uid}");

        // databaseMethods.upLoadUserInfo(userInfoMap, FirebaseAuth.instance.currentUser!.uid);
        // HelperFunctions.saveUserLoggedInsharedPreference(true);
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => HomePage()));
      });
      databaseMethods.upLoadUserInfo(userInfoMap, FirebaseAuth.instance.currentUser!.uid);
      HelperFunctions.saveUserLoggedInsharedPreference(true);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "????ng k??",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none,
          ),
        ),
      ),
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Container(
              alignment: Alignment.center,
              child:
              SingleChildScrollView(
                child :
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (val) {
                              return val!.isEmpty || val.length < 4
                                  ? "T??n ????ng nh???p ph???i c?? ??t nh???t 4 k?? t???"
                                  : null;
                            },
                            controller: userNameTextEditingController,
                            style: TextStyle(color: Colors.black),
                            decoration: textFieldInputDecoration("username"),
                          ),
                          TextFormField(
                            controller: fullNameTextEditingController,
                            style: TextStyle(color: Colors.black),
                            decoration: textFieldInputDecoration("Fullname"),
                          ),
                          TextFormField(
                            validator: (val) {
                              return RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val!)
                                  ? null
                                  : "Email b???n nh???p kh??ng ????ng";
                            },
                            controller: emailTextEditingController,
                            style: TextStyle(color: Colors.black),
                            decoration: textFieldInputDecoration("email"),
                          ),
                          TextFormField(
                            obscureText: true,
                            validator: (val) {
                              return (val!.length) > 5
                                  ? null
                                  : "M???t kh???u ph???i c?? ??t nh???t 6 k?? t???";
                            },
                            controller: passwordTextEditingController,
                            style: TextStyle(color: Colors.black),
                            decoration: textFieldInputDecoration("password"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      alignment: Alignment.centerRight,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                    ),
                    SizedBox(height: 8),

                    //Button signIn
                    GestureDetector(
                      onTap: () {
                        signMeUp();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              const Color(0xff007EF4),
                              const Color(0xff2A75BC)
                            ]),
                            borderRadius: BorderRadius.circular(30)),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              fontSize: 20,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have account ?",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.toggle();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              "????ng nh???p lun",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                  ], //Children
                ),
              ),
              ),
            ),
    );
  }
}
