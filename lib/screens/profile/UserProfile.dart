import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meatapp/adjust/bottomNavigation.dart';
import 'package:meatapp/adjust/custom_route.dart';
import 'package:meatapp/adjust/short.dart';
import 'package:meatapp/adjust/widget.dart';
import 'package:meatapp/details/userDetails.dart';
import 'package:meatapp/screens/address/manageAddress.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../FirestScreen.dart';
import 'manageProfile.dart';

class UserProfile extends StatefulWidget {
  @override
  UserProfileState createState() => UserProfileState();
}

class UserProfileState extends State<UserProfile> {
  UserDetails user;
  bool _isLoading = false;
  String token;
  @override
  void initState() {
    // TODO: implement initState
    getDetails();
    super.initState();
  }

  Future<UserDetails> getDetails() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(Duration(milliseconds: 500));

    SharedPreferences store = await SharedPreferences.getInstance();

    print("getting jwt from the device");
    token = store.getString('jwt');
    if (token != null) {
      Map jwt =
          json.decode(ascii.decode(base64.decode(base64.normalize(token))));
      print(jwt["data"].toString());
      user = UserDetails.fromJson(jwt["data"]);
      // print(user.fullName);

    }
    setState(() {
      _isLoading = false;
    });
    // if(token==null){
    //   setState(() {
    //   _isLoading = true;
    // });
    // }
  }

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      // Color.fromRGBO(191, 32, 37, 1.0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("User Profile"),
        ],
      ),
    );
    print(Short.h.toString());
    print(Short.w.toString());
    var h = Short.h - appbar.preferredSize.height;
    var w = Short.w;

    return Scaffold(
        appBar: appbar,
        bottomNavigationBar: bottomBar(context, 2),
        drawer: Draw(context),
        body: WillPopScope(
          onWillPop: () {
            Navigator.push(
                context, CustomRoute(builder: (context) => FirstScreen()));
          },
          child: Column(
            children: <Widget>[
              _isLoading
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[400],
                      highlightColor: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(left: 18.0, top: 20),
                        child: ListTile(
                            title: Text("FullName",
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Theme.of(context).primaryColor)),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Phone : PhoneNumber",
                                      style: TextStyle(
                                          fontSize: 19, color: Colors.black)),
                                  SizedBox(height: 8),
                                  Text("Email  :  email@domain.com",
                                      style: TextStyle(
                                          fontSize: 19, color: Colors.black))
                                ],
                              ),
                            )),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(left: 18.0, top: 20),
                      child: ListTile(
                          isThreeLine: true,
                          title: Text(
                              user.fullName == null
                                  ? "FullName"
                                  : user.fullName,
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Theme.of(context).primaryColor)),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                    user.phoneNo == null
                                        ? "Phone : PhoneNumber"
                                        : "Phone : ${user.phoneNo}",
                                    style: TextStyle(
                                        fontSize: 19, color: Colors.black)),
                                SizedBox(height: 8),
                                Text(
                                    user.email == null
                                        ? "Email  :  email@domain.com"
                                        : "Email  :  ${user.email}",
                                    style: TextStyle(
                                        fontSize: 19, color: Colors.black))
                              ],
                            ),
                          )),
                    ),
              SizedBox(
                height: 5,
              ),
              Divider(height: 5, thickness: 3, color: Colors.grey[400]),
              Padding(
                padding: EdgeInsets.only(top: 18.0, left: 20, right: 20),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text("Manage Profile",
                          style: TextStyle(
                              fontSize: 22,
                              color: Theme.of(context).primaryColor)),
                      subtitle: Text("Number,Name,Email,Password"),
                      leading: Icon(Icons.account_box),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () => Navigator.push(
                          context,
                          CustomRoute(
                              builder: (context) => ManageProfile(),
                              settings: RouteSettings(arguments: user))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(
                          height: 5, thickness: 3, color: Colors.grey[300]),
                    ),
                    ListTile(
                      title: Text("Manage Address",
                          style: TextStyle(
                              fontSize: 22,
                              color: Theme.of(context).primaryColor)),
                      leading: Icon(Icons.location_on),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () => Navigator.push(
                          context,
                          CustomRoute(
                              builder: (context) => ManageAddress(),
                              settings: RouteSettings(arguments: user))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(
                          height: 5, thickness: 3, color: Colors.grey[300]),
                    ),
                    ListTile(
                      title: Text("Manage Payment",
                          style: TextStyle(
                              fontSize: 22,
                              color: Theme.of(context).primaryColor)),
                      leading: Icon(Icons.payment),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(
                          height: 5, thickness: 3, color: Colors.grey[300]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
