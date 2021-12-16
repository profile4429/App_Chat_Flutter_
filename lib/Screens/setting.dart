import 'package:app_chat/helper/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_chat/services/auth.dart';
import 'package:app_chat/helper/authenticate.dart';
class Setting extends StatefulWidget{
  @override
  _SettingState createState() => _SettingState();

}
class _SettingState extends State<Setting>{
  bool valNotify1 = true;
  bool valNotify2 = true;
  bool valNotify3 = true;
  onchaneFuncion1(bool newValue1){
    setState(() {
      valNotify1 = newValue1;
    });
  }
  onchaneFuncion2(bool newValue2){
    setState(() {
      valNotify2 = newValue2;
    });
  }
  AuthMethods authMethods = new AuthMethods();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Setting')),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(height: 40),
            Row(
              children: [
                Icon(Icons.person,color: Colors.blue),
                SizedBox(width: 10),
                Text("General",style: TextStyle(fontSize: 22 , fontWeight: FontWeight.bold))
              ],
            ),
            Divider(height: 10.0,thickness: 1.0),
            SizedBox(height: 10.0),
            buildAccountOption(context,"Change Password"),
            buildAccountOption(context,"Content Settings"),
            buildAccountOption(context,"Social"),
            buildAccountOption(context,"Language"),
            buildAccountOption(context,"Privacy and Security"),
            SizedBox(height: 40),
            Row(
              children: [
                Icon(Icons.volume_up_outlined,color: Colors.blue,),
                SizedBox(width: 10,),
                Text("Notification",style: TextStyle(fontSize: 22 , fontWeight: FontWeight.bold),)
              ],
            ),
            Divider(height: 20.0,thickness: 1),
            SizedBox(height: 10.0),
            buildNotificationOption("Theme Dark" , valNotify1 , onchaneFuncion1),
            buildNotificationOption("Account Active" , valNotify2 , onchaneFuncion2),
            RaisedButton(
              onPressed: () {
                authMethods.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => Authenticate()
                ));

              },
              color: Colors.blue,
              child: Center(
                child: Text(
                  "Đăng Xuất",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

     Padding buildNotificationOption(String title , bool value , Function onChangeMethod){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8 , horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.grey[600]),),
          Transform.scale(
              scale: 0.7,
            child: CupertinoSwitch(
              activeColor: Colors.blue,
              trackColor: Colors.grey,
              value: value,
              onChanged: (bool newValue){
                onChangeMethod(newValue);
              },
            ),
          )
        ],
      ),
    );
     }

     GestureDetector buildAccountOption(BuildContext context , String title){
    return GestureDetector(
    onTap:() {
      showDialog(context: context, builder: (BuildContext context)
      {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Not found"),
              Text("Nothing")
            ],
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.of(context).pop();
            },
                child: Text("Close")
            )
          ],
        );
      }
      );
    },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0 , horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.grey[600]),),
            Icon(Icons.arrow_forward_ios,color: Colors.grey,)
          ],
        ),
      ),
       );
     }
}