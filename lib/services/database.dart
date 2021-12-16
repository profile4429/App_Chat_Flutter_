import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserbyUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .get();
  }


  dynamic getUserbyUserEmail(String userEmail) async {
    var docs = (await FirebaseFirestore.instance
            .collection("users")
            .where("email", isEqualTo: userEmail)
            .get())
        .docs;
    if (docs.isNotEmpty) {
      return docs[0].data();
    }
    return null;
  }

  upLoadUserInfo(userMap, String? uid) {
    FirebaseFirestore.instance
        .collection("users")
        .doc('${uid ?? 'unknown user'}')
        .set(userMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  upLoadUserPictureProfile(String? url, String uid) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'photoUrl': url}).catchError((e) {
      print(e.toString());
    });
  }

  createChatRoom(String charRoomId, chatRoomMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(charRoomId)
        .set(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addConversationMessages(String chatRoomId, messageMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getConversationMessages(String chatRoomId) async {
    return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("time", descending: false)
        .snapshots();
  }

  getChatRooms(String userName) async {
    return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .where("users", arrayContains: userName)
        .snapshots();
  }
}
