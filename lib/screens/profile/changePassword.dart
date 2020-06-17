import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as snack;
import 'package:http/http.dart' as hp;

import 'package:meatapp/adjust/bottomNavigation.dart';
import 'package:meatapp/adjust/custom_route.dart';
import 'package:meatapp/adjust/short.dart';
import 'package:meatapp/adjust/widget.dart';
import 'package:meatapp/details/userDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'manageProfile.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  void callSnackBar(String me, int sec) {
    print("called me for scnack bar");
    final nackBar = new snack.SnackBar(
      content: new Text(me),
      duration: new Duration(seconds: sec),
    );
    _scaffoldkey.currentState.showSnackBar(nackBar);
  }

  hp.Response response;
  static const headers = {'Content-Type': 'application/json'};

  GlobalKey<FormState> _formKey = GlobalKey<FormState>(debugLabel: "key1");
  bool cnfrmPwdTap = false, newPwdTap = false;
  bool showPwd = true;
  bool showCnfrmPwd = true;
  bool _isLoading = false;

  Icon _iconCnfrm = Icon(
    Icons.visibility,
  );
  Icon _icon = Icon(
    Icons.visibility,
  );
  TextEditingController newPwd;
  TextEditingController cnfrmPwd;
  void _toggle() {
    setState(() {
      showPwd = !showPwd;
      if (showPwd) {
        _icon = Icon(
          Icons.visibility,
        );
      } else {
        _icon = Icon(Icons.visibility_off, color: Colors.grey);
      }
    });
  }

  void _toggleCnfrm() {
    setState(() {
      showCnfrmPwd = !showCnfrmPwd;
      if (showCnfrmPwd) {
        _iconCnfrm = Icon(
          Icons.visibility,
        );
      } else {
        _iconCnfrm = Icon(Icons.visibility_off, color: Colors.grey);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    newPwd = new TextEditingController();
    cnfrmPwd = new TextEditingController();

    super.initState();
  }

  void dispose() {
    super.dispose();
    newPwd.dispose();
    cnfrmPwd.dispose();
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
          Text("Change Password"),
        ],
      ),
    );

    print(Short.h.toString());
    print(Short.w.toString());
    var h = Short.h - appbar.preferredSize.height;
    var w = Short.w;

    return Scaffold(
        key: _scaffoldkey,
        appBar: appbar,
        bottomNavigationBar: bottomBar(context, 2),
        drawer: Draw(context),
        body: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Center(
                  child: Container(
                    width: w * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 22.0),
                      child: Card(
                        elevation: 3.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Change your Password",
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor)),
                            ),
                            Divider(
                                height: 15,
                                thickness: 3,
                                color: Colors.grey[300]),
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: ListTile(
                                  title: TextFormField(
                                obscureText: showPwd,
                                validator: Short().validatePwd,
                                controller: newPwd,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  hintText: "New Password",
                                  suffixIcon: IconButton(
                                    icon: _icon,
                                    onPressed: _toggle,
                                  ),
                                  prefixIcon: Icon(Icons.lock_outline),
                                  filled: true,
                                  fillColor: Colors.white70,
                                ),
                              )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: ListTile(
                                  title: TextFormField(
                                obscureText: showCnfrmPwd,
                                validator: Short().validatePwd,
                                controller: cnfrmPwd,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  hintText: "Confirm Password",

                                  // hintText: 'Enter Your newPwd Here...',
                                  suffixIcon: IconButton(
                                    icon: _iconCnfrm,
                                    onPressed: _toggleCnfrm,
                                  ),
                                  prefixIcon: Icon(Icons.lock_outline),

                                  filled: true,
                                  fillColor: Colors.white70,
                                ),
                              )),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 28.0, bottom: 28),
                              child: Center(
                                child: Container(
                                  width: w * 0.75,
                                  child: RaisedButton(
                                      padding: EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                      ),
                                      color: Theme.of(context).primaryColor,
                                      onPressed: () async {
                                        print("Login button is clicked");
                                        if (_formKey.currentState.validate()) {
                                          print("Form is validated");
                                          if (cnfrmPwd.text == newPwd.text) {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            Map<String, dynamic> data = {
                                              "phoneno":
                                                  // "6556121480",
                                                  user.phoneNo,
                                              "password":
                                                  // "152346"
                                                  cnfrmPwd.text
                                            };
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            print("before post" +
                                                data.toString());
                                            try {
                                              callSnackBar(
                                                  "Checking the entered details",
                                                  1);
                                              response = await hp.post(
                                                  "${Short.baseUrl}/changepassword",
                                                  body: json.encode(data),
                                                  headers: headers);

                                              if (response != null) {
                                                Map res =
                                                    json.decode(response.body);
                                                if (response.statusCode ==
                                                    200) {
                                                  print(
                                                      "inside response status");

                                                  // Map jwt = json.decode(ascii
                                                  //     .decode(base64.decode(base64
                                                  //         .normalize(res['token']
                                                  //             .split(".")[1]))));

                                                  // storeLocal() async {
                                                  //   SharedPreferences store =
                                                  //       await SharedPreferences
                                                  //           .getInstance();
                                                  //   print("storing jwt locally");
                                                  //   store.clear();
                                                  //   store.setString(
                                                  //       'jwt',
                                                  //       res['token']
                                                  //           .split(".")[1]
                                                  //           .toString());
                                                  // }
                                                  newPwd.clear();
                                                  cnfrmPwd.clear();

                                                  setState(() {
                                                    // storeLocal();
                                                    _isLoading = false;
                                                  });

                                                  //store jwt locally

                                                  // print("jwt");
                                                  // print(jwt.toString());
                                                  callSnackBar(
                                                      "Password Chnaged Successfully",
                                                      2);
                                                  await Future.delayed(Duration(
                                                      milliseconds: 3000));
                                                  Navigator.pushReplacement(
                                                      context,
                                                      CustomRoute(
                                                          builder: (context) =>
                                                              ManageProfile()
                                                           ,settings:RouteSettings(arguments:user)
                                                          ));

                                                  // Navigator.pushReplacementNamed(
                                                  //     context, "Main",
                                                  //     );
                                                }
                                                if (response.statusCode ==
                                                    400) {
                                                  callSnackBar(
                                                      "${res["msg"]}", 3);

                                                  print(
                                                      "invalid username or password");
                                                  setState(() {
                                                    // storeLocal();
                                                    _isLoading = false;
                                                  });
                                                }
                                              } //response is not null
                                              // else {
                                              //   //response is null
                                              //   callSnackBar(
                                              //       "network problem");
                                              //   print(
                                              //       "response is null");
                                              // }
                                            } on Exception catch (exception) {
                                              print("exeception from api");

                                              callSnackBar(
                                                  "network problem", 2);
                                            } catch (error) {
                                              print("error from api");
                                              setState(() {
                                                // storeLocal();
                                                _isLoading = false;
                                              });
                                              callSnackBar(error.toString(), 3);
                                            }
                                          } //new pwd and current pwd

                                          else {
                                            callSnackBar(
                                                "Confirm and New Password should be same",
                                                2);
                                          }
                                        } //form validation
                                      }, //onpressed of login button
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(50.0),
                                      ),
                                      child: _isLoading
                                          ? CircularProgressIndicator()
                                          : Text("CHANGE PASSWORD",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 22))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ))));
  }
}
