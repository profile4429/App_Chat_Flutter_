import 'package:app_chat/helper/constant.dart';
import 'package:app_chat/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:app_chat/chat_room/videoCall.dart';

class ConversationScreen extends StatefulWidget {
  late final String chatRoomId;
  ConversationScreen(this.chatRoomId);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController messageController = new TextEditingController();

  Stream? chatMessagesStream ;

  Widget ChatMessageList(){
    return StreamBuilder(
      stream: chatMessagesStream,
      builder: (context,AsyncSnapshot snapshot){
        return snapshot.hasData ? ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              return MessageTile(snapshot.data.docs[index]["message"],
                  snapshot.data.docs[index]["sendBy"] == Constants.myName);
            }) : Container();
      },
    );
  }

  sendMessage(){
    if (messageController.text.isNotEmpty){
      Map<String,dynamic> messageMap = {
        "message" : messageController.text,
        "sendBy" : Constants.myName,
        "time" : DateTime.now().millisecondsSinceEpoch
      };
      databaseMethods.addConversationMessages(widget.chatRoomId,messageMap) ;
      messageController.text = "" ;
    }
  }

  @override
  void initState(){
    databaseMethods.getConversationMessages(widget.chatRoomId).then((value){
      setState((){
        chatMessagesStream = value ;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundColor: Colors.orangeAccent,
              backgroundImage: NetworkImage(
                  "https://cuoifly.tuoitre.vn/820/0/ttc/r/2020/07/09/markfb01-1594306085.jpg"),
            ),
            SizedBox(width: 10.0),
            Column(
              children: [
                Text("User",style: TextStyle(fontSize: 16),),
                Text("Online",style: TextStyle(fontSize: 12),),

              ],
            )
          ],
        ),
        actions: [
// button video call
          GestureDetector(
            onTap: () {
              // Navigator.pushReplacement(context, MaterialPageRoute(
              //     builder: (context) => IndexPage()
              // ));
            },
            child: Container(
                child:  Icon(Icons.call,color: Colors.tealAccent,),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
          )
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            ChatMessageList(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 80,
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Row(
                  children: [
                    Icon(Icons.mic,color: Colors.blue),
                    SizedBox(width: 8),
                    Expanded(
                        child: TextField(
                          controller: messageController ,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(onPressed: (){},icon: Icon(Icons.photo), color: Colors.teal),
                              hintText: "Nhắn tin...",
                              hintStyle: TextStyle(
                                  color: Colors.black
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(45)
                              )
                          ),
                        )
                    ),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        sendMessage();
                      },
                      child: Container(
                          height: 40 ,
                          width: 40,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    const Color(0x36FFFFFF),
                                    const Color(0x0FFFFFFF)
                                  ]
                              ),
                              borderRadius: BorderRadius.circular(40)
                          ),
                          padding: EdgeInsets.all(2),
                          child: Image.asset("images/send.jpg",height: 50,)),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe ;
  MessageTile(this.message,this.isSendByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: isSendByMe? 0:8 , right: isSendByMe? 12 : 0),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 26, vertical: 8),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: isSendByMe ? [
                  Color.fromRGBO(0, 183, 97, 1),
                  Color.fromRGBO(0, 183, 97, 1)
                ] : [
                  Colors.red,
                  Colors.red
                ]
            ),
            borderRadius: isSendByMe ?
            BorderRadius.circular(30)
                :
            BorderRadius.circular(30)
        ),
        child: Text(message,
          style: TextStyle(
              color: Colors.white,
            fontSize: 15
          ),
        ),
      ),
    );
  }
}
