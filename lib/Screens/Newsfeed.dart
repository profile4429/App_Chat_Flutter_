import 'package:app_chat/helper/constant.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Newsfeed extends StatefulWidget {
  @override
  _NewsfeedState createState() => _NewsfeedState();
}

class _NewsfeedState extends State<Newsfeed> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Newsfeed')),
        body: Container(
          padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
          color: Colors.white,
          height: 600.0,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundColor: Colors.orangeAccent,
                      backgroundImage: NetworkImage(
                          _auth.currentUser!.photoURL.toString()),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration.collapsed(
                          hintText: "What are you thinking ?",
                        ),
                      ),
                    )
                  ],
                ),
                const Divider(height: 10.0, thickness: 0.5),
                Container(
                    height: 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FlatButton.icon(
                            onPressed: () => print("Hi"),
                            icon: const Icon(Icons.videocam, color: Colors.red),
                            label: Text('Live')),
                        const VerticalDivider(width: 8.0),
                        FlatButton.icon(
                            onPressed: () => print("Hi"),
                            icon: const Icon(Icons.photo_library,
                                color: Colors.green),
                            label: Text('Photo')),
                        const VerticalDivider(width: 8.0),
                        FlatButton.icon(
                            onPressed: () => print("Hi"),
                            icon: const Icon(Icons.video_call,
                                color: Colors.purpleAccent),
                            label: Text('Room')),
                        const VerticalDivider(width: 8.0),
                      ],
                    )),
                const Divider(height: 40.0, thickness: 0.5),
                Column(
                  children: [
                    Container(
                      height: 350.0,
                      child: Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              radius: 20.0,
                              backgroundColor: Colors.orangeAccent,
                              backgroundImage: NetworkImage(
                                  _auth.currentUser!.photoURL.toString()),
                            ),
                            title: Text("Nguyen Xuan Son"),
                            subtitle: Text("Tue Oct 12 2021 8:45 CH"),
                          ),
                          Expanded(
                              child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://salenhanh.com/wp-content/uploads/2020/05/meo-Scotland-Fold.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.thumb_up, color: Colors.grey),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text("Like")
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.comment, color: Colors.grey),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text("Comment")
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.share, color: Colors.grey),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text("Share")
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const Divider(height: 40.0, thickness: 0.5),
                Column(
                  children: [
                    Container(
                      height: 350.0,
                      child: Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              radius: 20.0,
                              backgroundColor: Colors.orangeAccent,
                              backgroundImage: NetworkImage(
                                  _auth.currentUser!.photoURL.toString()),
                            ),
                            title: Text("Nguyen Xuan Son"),
                            subtitle: Text("Tue Oct 12 2021 10:10 CH"),
                          ),
                          Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "https://media.ohay.tv/v1/upload/content/2019-07/08/35015-56ea1a9b4d49b3556b2fb483f47781b6-ohaytv.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.thumb_up, color: Colors.grey),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text("Like")
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.comment, color: Colors.grey),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text("Comment")
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.share, color: Colors.grey),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text("Share")
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const Divider(height: 40.0, thickness: 0.5),
                Column(
                  children: [
                    Container(
                      height: 350.0,
                      child: Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              radius: 20.0,
                              backgroundColor: Colors.orangeAccent,
                              backgroundImage: NetworkImage(
                                  _auth.currentUser!.photoURL.toString()),
                            ),
                            title: Text("Nguyen Xuan Son"),
                            subtitle: Text("Tue Oct 12 2021 10:10 CH"),
                          ),
                          Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "https://static.tuoitre.vn/tto/i/s626/2017/01/18/selfie-dong-vat-1-1484705632.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.thumb_up, color: Colors.grey),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text("Like")
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.comment, color: Colors.grey),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text("Comment")
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.share, color: Colors.grey),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text("Share")
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),


              ],
            ),
          ),
        ));
  }
}
