import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as snack;

import 'package:http/http.dart' as hp;
import 'package:meatapp/adjust/bottomNavigation.dart';
import 'package:meatapp/adjust/custom_route.dart';
import 'package:meatapp/adjust/short.dart';
import 'package:meatapp/adjust/widget.dart';
import 'package:meatapp/details/userDetails.dart';
import 'package:meatapp/screens/profile/UserProfile.dart';
import 'package:meatapp/screens/profile/manageProfile.dart';

class EditAddress extends StatefulWidget {
  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  TextEditingController flatNo;
  TextEditingController street;
  TextEditingController area;
  TextEditingController pincode;
  static const headers = {'Content-Type': 'application/json'};
  GlobalKey<FormState> _form = GlobalKey<FormState>(debugLabel: "key2");
  bool isLoading = false;
  bool getLocation = false;

  hp.Response response;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  void callSnackBar(String me) {
    print("called me for scnack bar");
    final nackBar = new snack.SnackBar(
      content: new Text(me),
      duration: new Duration(seconds: 3),
    );
    _scaffoldkey.currentState.showSnackBar(nackBar);
  }

  void initState() {
    // TODO: implement initState
    flatNo = new TextEditingController();
    street = new TextEditingController();
    area = new TextEditingController();
    pincode = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    flatNo.dispose();
    street.dispose();
    area.dispose();
    pincode.dispose();
    super.dispose();
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
          Text("Edit Address"),
        ],
      ),
    );

    print(Short.h.toString());
    print(Short.w.toString());
    var h = Short.h - appbar.preferredSize.height;
    var w = Short.w;

    return Scaffold(
      key:_scaffoldkey,
      backgroundColor: Colors.white,
      appBar: appbar,
      bottomNavigationBar: bottomBar(context, 2),
      drawer: Draw(context),
      body: WillPopScope(
        onWillPop: () {
                             Navigator.push(context, CustomRoute(builder: (context) => UserProfile()));

        },
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Form(
                  key: _form,
                  child: Column(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          top: Short.h * 0.018,
                          left: Short.w * 0.07,
                          right: Short.w * 0.07),
                      child: Material(
                        color: Colors.white,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                color: Theme.of(context).primaryColor, fontSize: 19),
                            labelText: 'Flat No',
                            // hintText: "Flat No",
                            // hintStyle: TextStyle(
                            //     color: Theme.of(context).primaryColor,, fontSize: 19),
                            // border: OutlineInputBorder(
                            //     borderRadius:
                            //         BorderRadius.circular(Short.h * 2.5)),
                          ),
                          controller: flatNo,
                          keyboardType: TextInputType.text,
                          validator: Short().validateName,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: Short.h * 0.018,
                          left: Short.w * 0.07,
                          right: Short.w * 0.07),
                      child: Material(
                        color: Colors.white,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                color: Theme.of(context).primaryColor, fontSize: 19),
                            labelText: 'Street',
                            // hintText: "Enter your Email pincode",
                            // hintStyle: TextStyle(
                            //     color: Theme.of(context).primaryColor, fontSize: 19),
                            // border: OutlineInputBorder(
                            //     borderRadius:
                            //         BorderRadius.circular(Short.h * 2.5)),
                          ),
                          controller: area,
                          keyboardType: TextInputType.text,
                          validator: Short().validateName,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: Short.h * 0.018,
                          left: Short.w * 0.07,
                          right: Short.w * 0.07),
                      child: Material(
                        color: Colors.white,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                color: Theme.of(context).primaryColor, fontSize: 19),
                            labelText: 'Area',
                            // hintText: "Enter your Mobile Number",
                            // hintStyle: TextStyle(
                            //     color: Theme.of(context).primaryColor, fontSize: 19),
                            // border: OutlineInputBorder(
                            //     borderRadius:
                            //         BorderRadius.circular(Short.h * 2.5)),
                          ),
                          controller: street,
                          keyboardType: TextInputType.text,
                          validator: Short().validateName,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: Short.h * 0.018,
                          left: Short.w * 0.07,
                          right: Short.w * 0.07),
                      child: Material(
                        color: Colors.white,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                color: Theme.of(context).primaryColor, fontSize: 19),
                            labelText: 'Pin Code',
                            // hintText: "Enter your Mobile Number",
                            // hintStyle: TextStyle(
                            //     color: Theme.of(context).primaryColor, fontSize: 19),
                            // border: OutlineInputBorder(
                            //     borderRadius:
                            //         BorderRadius.circular(Short.h * 2.5)),
                          ),
                          controller: pincode,
                          keyboardType: TextInputType.number,
                          validator: Short().validatePin,
                        ),
                      ),
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
                          print("Continue is clicked");
                          if (_form.currentState.validate()) {
                            print("Form is validated");

                            setState(() {
                              isLoading = true;
                            });
                            print(user.address);
                            user.address = flatNo.text +","+
                                area.text +","+
                                street.text +","+
                                pincode.text;
                                                            print(user.phoneNo.toString());

                            Map<String, dynamic> data = {
                              "phoneno": user.phoneNo,
                              "address": user.address,
                            };
                            setState(() {
                              isLoading = true;
                            });
                            print("before post" + data.toString());

                            try {
                              callSnackBar("Connecting...");
                              response = await hp.post(
                                  "${Short.baseUrl}/updateaddress",
                                  body: json.encode(data),
                                  headers: headers);
                              print(response.toString());
                              if (response != null) {
                                print(response.statusCode.toString());
                                Map res = json.decode(response.body);
                                if (response.statusCode == 200) {
                                  print("inside response status");

                                  setState(() {
                                    isLoading = false;
                                  });
                                        await Future.delayed(Duration(
                                                      milliseconds: 3000));
                                                  Navigator.pushReplacement(
                                                      context,
                                                      CustomRoute(
                                                          builder: (context) =>
                                                              UserProfile()
                                                           ,settings:RouteSettings(arguments:user)
                                                          ));
                                 
                                }
                                if (response.statusCode == 400) {
                                  // callSnackBar("${res["msg"]}");
                                  callSnackBar(
                                      "error while editing");
                                        setState(() {
                                    isLoading = false;
                                  });

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
                                  "User with these details already exists");
                            } catch (error) {
                              print("error from api");

                              callSnackBar(error.toString());
                            } //catch

                            // setState(() {
                            //   isLoading=false;
                            // });
                          } //form validation
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(50.0),
                        ),
                        child: isLoading
                            ? CircularProgressIndicator()
                            : Text("CONTINUE",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 21)),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
