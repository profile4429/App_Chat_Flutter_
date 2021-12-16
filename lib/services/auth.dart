import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_chat/modal/user.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserId? _userFromFirebaseUser(User user) {
    return user != null ? UserId(userId: user.uid) : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser!);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signUpwithEmailAndPassword(String username, String fullname , String email , String password) async {
    try {
      UserCredential result = await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) => -_createUser(
              user.user!.uid, username , fullname , email , password));
      User? firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser!);
    } catch (e) {
      print(e.toString());
    }
  }

  _createUser(String userId, String name, String fullname , String email , String  password) {
    var user = {"username": name, "fullname": fullname , "email" :email , "password":password};
    var ref = FirebaseDatabase.instance.reference().child("user");
    ref.child(userId).set(user).then((user) {}).catchError((err) {
      //TODO
    });
  }

  Future signUpwithGoogle(String email, String password) async {}
  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
