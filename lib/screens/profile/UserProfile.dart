import 'package:flutter/material.dart';
import 'package:meatapp/adjust/short.dart';
import 'package:meatapp/adjust/widget.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      backgroundColor: Colors.green,
      // Color.fromRGBO(191, 32, 37, 1.0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("FirstMeat"),
      
         
        ],
      ),
    );
    print(Short.h.toString());
    print(Short.w.toString());
    var h = Short.h - appbar.preferredSize.height;
    var w = Short.w;

    return 
    Scaffold(
      drawer: Draw(context),
      body:
      Column(
        children: <Widget>[
         ListTile(
           isThreeLine: true,
           title:Text("chaitanya"),
           subtitle:  Column(

                children: <Widget>[
             Text("chaitanya"),
              Text("chaitanya")
        ],
      )   
         ),
         SizedBox(height: 25,),
         Divider(),
         ListTile(
            title:Text("chaitanya"),
            leading: Icon(Icons.account_box),
         ),
                  ListTile(
                     title:Text("chaitanya"),
                  ),
                           ListTile(
                              title:Text("chaitanya"),
                           ),

        ],
      )

    )
  ;
  }
}