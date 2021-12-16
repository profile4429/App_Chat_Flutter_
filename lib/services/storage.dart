import 'dart:io';

import 'package:app_chat/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseMethods dbMethods = DatabaseMethods();
upProfilePicture(File profilePicture) async {
    Reference ref =
        _storage.ref().child('profilePictures/${_auth.currentUser!.uid}');
    String url;
    UploadTask uploadTask = ref.putFile(profilePicture);
    uploadTask.then((res) async {
      url = await res.ref.getDownloadURL();
       _auth.currentUser!.updatePhotoURL(url);
      dbMethods.upLoadUserPictureProfile(url,
         _auth.currentUser!.uid);
      return url.toString();
    });
  }
}
