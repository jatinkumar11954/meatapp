import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meatapp/adjust/bottomNavigation.dart';
import 'package:meatapp/adjust/custom_route.dart';
import 'package:meatapp/adjust/short.dart';
import 'package:meatapp/adjust/widget.dart';
import 'package:meatapp/details/userDetails.dart';
import 'package:flutter/material.dart' as snack;
import 'package:http/http.dart' as hp;

import 'UserProfile.dart';
import 'UserProfile.dart';
import 'changePassword.dart';

class ManageProfile extends StatefulWidget {
  @override
  _ManageProfileState createState() => _ManageProfileState();
}

class _ManageProfileState extends State<ManageProfile> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  void callSnackBar(String msg, int sec) {
    print(msg + "snack msg");
    final Snack = new snack.SnackBar(
      content: new Text(msg),
      duration: new Duration(seconds: sec),
    );
    _scaffoldkey.currentState.showSnackBar(Snack);
  }

  bool changeName = false;
  bool changeEmail = false;
  hp.Response response;
  static const headers = {'Content-Type': 'application/json'};
  GlobalKey<FormState> _formKey = GlobalKey<FormState>(debugLabel: "key1");
  bool nameTap = false, emailTap = false;
  TextEditingController email;
  TextEditingController name;
  @override
  void initState() {
    // TODO: implement initState
    email = new TextEditingController();
    name = new TextEditingController();

    super.initState();
  }

  String varname;
  String varemail;

  void dispose() {
    super.dispose();
    email.dispose();
    name.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserDetails user = ModalRoute.of(context).settings.arguments;

    final appbar = AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      // Color.fromRGBO(191, 32, 37, 1.0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Manage Profile"),
        ],
      ),
    );
    String pwd = "*";
    int len = user.password.length;
    for (int i = 0; i < len - 1; i++) {
      pwd = pwd + "*";
    }
    print(pwd);
    print(Short.h.toString());
    print(Short.w.toString());
    var h = Short.h - appbar.preferredSize.height;
    var w = Short.w;

    return Scaffold(
        key: _scaffoldkey,
        appBar: appbar,
        bottomNavigationBar: bottomBar(context, 2),
        drawer: Draw(context),
        body: WillPopScope(
          onWillPop: () {
            Navigator.push(
                context,
                CustomRoute(
                    builder: (context) => UserProfile(),
                    settings: RouteSettings(arguments: user)));
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 18.0, left: 20, right: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text("Mobile Number",
                          style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).primaryColor)),
                      subtitle: Text("${user.phoneNo}"),
                      leading: Icon(Icons.phone),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(
                          height: 5, thickness: 3, color: Colors.grey[300]),
                    ),
                    // Expanded(
                    //                       child: Row(
                    //                         mainAxisAlignment: MainAxisAlignment.end,
                    //                         children: <Widget>[
                    //     IconButton(icon: Icon(Icons.email), onPressed:(){}),
                    //                           IconButton(icon: Icon(Icons.email), onPressed:(){})

                    //   ],),
                    // ),
                    ListTile(
                      title: Text("Name",
                          style: TextStyle(
                              // fontSize: 20,
                              color: Theme.of(context).primaryColor)),
                      subtitle: nameTap
                          ? TextFormField(
                              validator: Short().validateName,
                              controller: name,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                // hintText: 'Enter Your Email Here...',
                                suffixIcon:
                                    // Expanded(
                                    // child:

                                    IconButton(
                                        tooltip: "to save the name",
                                        icon: Icon(Icons.check_circle),
                                        onPressed: () {
                                          // if (_formKey.currentState.validate())
                                          // _formKey.currentState.save();
                                          setState(() {
                                            varname = name.text;
                                            print("inside check $varname");
                                            nameTap = false;
                                          });
                                          print("saved");
                                        }),

                                //               ),
                                // Icon(Icons.email),
                                filled: true,
                                fillColor: Colors.white70,
                                // enabledBorder: OutlineInputBorder(
                                // borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                // borderSide: BorderSide(color: Colors.green, width: 2),
                                //  ),
                                // focusedBorder: OutlineInputBorder(
                                // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                // borderSide: BorderSide(color: Colors.green, width: 2),
                                // ),
                              ),
                              onChanged: (newvalue) {
                                print(newvalue);
                                setState(() {
                                  varname = newvalue;
                                  changeName = true;
                                  print("name changes$varname");

                                  // nameTap = false;
                                });
                              },
                            )
                          : Text(!changeName ? "${user.fullName}" : "$varname"),
                      leading: Icon(Icons.account_circle),
                      trailing: Visibility(
                        visible: !nameTap,
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            setState(() {
                              nameTap = true;
                            });
                          },
                        ),
                        replacement: IconButton(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(
                            top: 24.0,
                          ),
                          icon: Icon(Icons.cancel),
                          onPressed: () {
                            setState(() {
                              varname = user.fullName;
                              nameTap = false;
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(
                          height: 5, thickness: 3, color: Colors.grey[300]),
                    ),
                    ListTile(
                      title: Text("Email",
                          style: TextStyle(
                              // fontSize: 20,
                              color: Theme.of(context).primaryColor)),
                      subtitle: emailTap
                          ? TextFormField(
                              validator: Short().validateEmail,
                              controller: email,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                // hintText: 'Enter Your Email Here...',
                                suffixIcon:
                                    // Expanded(
                                    // child:

                                    IconButton(
                                        tooltip: "to save the email",
                                        icon: Icon(Icons.check_circle),
                                        onPressed: () {
                                          // _formKey.currentState.save();
                                          setState(() {
                                            varemail = email.text;
                                            print("inside check $varemail");
                                            emailTap = false;
                                          });
                                          print("saved");
                                          // if (_formKey.currentState.validate())
                                        }),

                                //               ),
                                // Icon(Icons.email),
                                filled: true,
                                fillColor: Colors.white70,
                                // enabledBorder: OutlineInputBorder(
                                // borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                // borderSide: BorderSide(color: Colors.green, width: 2),
                                //  ),
                                // focusedBorder: OutlineInputBorder(
                                // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                // borderSide: BorderSide(color: Colors.green, width: 2),
                                // ),
                              ),
                              onChanged: (newvalue) {
                                print(newvalue);
                                setState(() {
                                  varemail = newvalue;
                                  changeEmail = true;
                                  print("name changes$varemail");

                                  // nameTap = false;
                                });
                              },
                            )
                          : Text(
                              !changeEmail ? "${user.email}" : "${varemail}"),
                      leading: Icon(Icons.account_circle),
                      trailing: Visibility(
                        visible: !emailTap,
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            setState(() {
                              emailTap = true;
                            });
                          },
                        ),
                        replacement: IconButton(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(
                            top: 24.0,
                          ),
                          icon: Icon(Icons.cancel),
                          onPressed: () {
                            setState(() {
                              varemail = user.email;
                              emailTap = false;
                            });
                          },
                        ),
                      ),
                    ),
                    // ListTile(
                    //   title: Text("Email",
                    //       style: TextStyle(
                    //           fontSize: 20,
                    //           color: Theme.of(context).primaryColor)),
                    //   subtitle: Text("${varemail}"),
                    //   leading: Icon(Icons.account_circle),
                    //   trailing: IconButton(
                    //     icon: Icon(Icons.edit),
                    //     onPressed: () {},
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(
                          height: 5, thickness: 3, color: Colors.grey[300]),
                    ),
                    ListTile(
                      title: Text("Password",
                          style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).primaryColor)),
                      subtitle: Text("${pwd}",
                          style: TextStyle(
                            fontSize: 20,
                          )),
                      leading: Icon(Icons.account_circle),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                              context,
                              CustomRoute(
                                  builder: (context) => ChangePassword(),
                                  settings: RouteSettings(arguments: user)));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(
                          height: 5, thickness: 3, color: Colors.grey[300]),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: Short.h * 0.045),
                        child: RaisedButton(
                          padding: EdgeInsets.only(
                              top: Short.h * 0.01,
                              bottom: Short.h * 0.01,
                              left: Short.w * 0.3,
                              right: Short.w * 0.3),
                          color: Theme.of(context).primaryColor,
                          onPressed: () async {
                            print("SIGN UP button is clicked");
                            if (changeName || changeEmail) {
                              if (_formKey.currentState.validate()) {
                                print("anu one in teur");
                                print("Form is validated");

                                setState(() {
                                  _isLoading = true;
                                });
                                Map<String, dynamic> data = {
                                  "fullname":
                                      // "jatin",
                                      varname,
                                  "email":
                                      // "test@gmail.com",
                                      varemail,
                                  "phoneno":
                                      // "6556121480",
                                      user.phoneNo,

                                  // "152346"
                                };
                                setState(() {
                                  _isLoading = true;
                                });
                                print("before post" + data.toString());

                                try {
                                  callSnackBar("Validating...", 1);
                                  response = await hp.post(
                                      "${Short.baseUrl}/updateprofile",
                                      body: json.encode(data),
                                      headers: headers);
                                  print(response.toString());
                                  if (response != null) {
                                    Map res = json.decode(response.body);
                                    if (response.statusCode == 200) {
                                      print("inside response status");

                                      setState(() {
                                        _isLoading = false;
                                      });
                                      await Future.delayed(
                                          Duration(milliseconds: 3000));
                                      Navigator.pushReplacement(
                                          context,
                                          CustomRoute(
                                              builder: (context) =>
                                                  UserProfile(),
                                              settings: RouteSettings(
                                                  arguments: user)));
                                    }
                                    if (response.statusCode == 400) {
                                      // callSnackBar("${res["msg"]}");
                                      callSnackBar(
                                          "User with these details already exists",
                                          2);

                                      print(
                                          "User with these details already exists");
                                    }
                                  } //response is not null
                                  // else {
                                  //   //response is null
                                  //   callSnackBar(
                                  //       "network problem");
                                  //   print(
                                  //       "response is null");
                                  // }

                                } //try
                                on Exception catch (exception) {
                                  print("exeception from api");

                                  callSnackBar(
                                      "User with these details already exists",
                                      2);
                                } catch (error) {
                                  print("error from api");

                                  callSnackBar(error.toString(), 3);
                                } //catch

                                // setState(() {
                                //   _isLoading=false;
                                // });
                              }

                              //form validation
                            } else {
                              callSnackBar("No changes were made", 3);
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(50.0),
                          ),
                          child: _isLoading
                              ? CircularProgressIndicator()
                              : Text("Update",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 21)),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
