import 'package:app_chat/chat_room/conversation_screen.dart';
import 'package:app_chat/chat_room/search.dart';
import 'package:app_chat/helper/authenticate.dart';
import 'package:app_chat/helper/helperfunctions.dart';
import 'package:app_chat/services/auth.dart';
import 'package:app_chat/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_chat/helper/constant.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream? chatRoomsStream;

  Widget chatRoomList() {
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  var x = snapshot.data.docs[index]["chatroomId"];
                  return ChatRoomTile(
                      snapshot.data.docs[index]["chatroomId"]
                          .toString()
                          .replaceAll("_", "")
                          .replaceAll(Constants.myName, ""),
                      snapshot.data.docs[index]["chatroomId"]);
                })
            : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName =
        (await HelperFunctions.getUserNamesharedPreference()) as String;
    databaseMethods.getChatRooms(Constants.myName).then((value) {
      setState(() {
        chatRoomsStream = value;
      });
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    AuthMethods authMethods = new AuthMethods();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundColor: Colors.orangeAccent,
              backgroundImage: NetworkImage(
                  _auth.currentUser!.photoURL.toString()),
            ),
            SizedBox(width: 8),
            Text("Chats" , style: TextStyle(fontSize: 22 , color: Colors.white),)
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              authMethods.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Authenticate()));
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app)),
          )
        ],
      ),
      body: chatRoomList(),
    );
  }
}

class ChatRoomTile extends StatelessWidget {
  final String userName;
  final String chatRoom;
  FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseMethods dbMethod = DatabaseMethods();

  ChatRoomTile(this.userName, this.chatRoom);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConversationScreen(chatRoom)));
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            FutureBuilder(
                future: dbMethod.getUserbyUsername(userName),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    ///when the future is null
                    case ConnectionState.waiting:
                      return CircularProgressIndicator();
                    case ConnectionState.done:
                      if (snapshot.hasError)
                        return Container(
                          height: 40,
                          width: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.lightGreenAccent,
                              borderRadius: BorderRadius.circular(40)),
                          child: Text(
                            "${userName.substring(0, 1).toUpperCase()}",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        );
                      else {
                        QuerySnapshot? searchSnapshot;
                        searchSnapshot = snapshot.data as QuerySnapshot;
                        ///task is complete with some data
                        return CircleAvatar(
                          foregroundImage: NetworkImage(
                              searchSnapshot.docs[0]['photoUrl']),
                        );
                      }
                  }
                  return Container();
                }),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "You received a message",
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Text(DateTime.now().toString().split(' ')[0] , style: TextStyle(fontSize: 10 , fontWeight: FontWeight.w400),)
          ],
        ),
      ),
    );
  }
}
