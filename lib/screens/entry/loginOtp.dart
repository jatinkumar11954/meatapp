import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as snack;

import 'package:meatapp/adjust/short.dart';
import 'package:http/http.dart' as hp;

class LoginOtp extends StatefulWidget {
  @override
  _LoginOtpState createState() => _LoginOtpState();
}

class _LoginOtpState extends State<LoginOtp> with TickerProviderStateMixin {
  TextEditingController phoneNumber;

  GlobalKey<FormState> _form = GlobalKey<FormState>(debugLabel: "key2");
  bool isLoading = false;
  AnimationController _controller;
  Animation<Offset> animation;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  hp.Response response;
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

    phoneNumber = new TextEditingController();

    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    animation = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
        .animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    phoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const headers = {'Content-Type': 'application/json'};
    var child = Container(
      height: Short.h * 0.75,
      width: Short.w,
      margin: EdgeInsets.only(top: Short.h * 0.25),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(80), topRight: Radius.circular(80))),
      child: Column(
        children: <Widget>[
          // Center(
          //   child: Material(
          //     color: Colors.white,
          //     child: Padding(
          //       padding: EdgeInsets.only(top: 18.0, bottom: 10),
          //       child: Text(
          //         "Login via OTP",
          //         style: TextStyle(
          //             color: Theme.of(context).primaryColor, fontSize: 26
          //             // Short.h * 0.04
          //             ),
          //       ),
          //     ),
          //   ),
          // ),
          // SizedBox(height:Short.h*0.1),

          Form(
            key: _form,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      top: Short.h * 0.15,
                      left: Short.w * 0.08,
                      right: Short.w * 0.08),
                  child: Material(
                    color: Colors.white,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey, fontSize: 19),
                        labelText: 'Phone Number',
                        hintText: "Enter your Phone Number",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 19),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Short.h * 2.5)),
                      ),
                      controller: phoneNumber,
                      keyboardType: TextInputType.number,
                      validator: Short().validateMobile,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: Short.h * 0.045),
            child: RaisedButton(
                padding: EdgeInsets.only(
                    top: Short.h * 0.01,
                    bottom: Short.h * 0.01,
                    left: Short.w * 0.28,
                    right: Short.w * 0.28),
                color: Theme.of(context).primaryColor,
                onPressed: () async {
                  print("Send OTP button is clicked");
                  if (_form.currentState.validate()) {
                    print("Form is validated");

                    setState(() {
                      isLoading = true;
                    });
                    Map<String, String> data = {"phoneno": phoneNumber.text};

                    print("before post" + data.toString());
                    try {
                      callSnackBar("Checking the entered details");
                      response = await hp.post('${Short.baseUrl}/loginviaotp',
                          headers: headers, body: json.encode(data));

                      if (response != null) {
                        Map res = json.decode(response.body);
                        if (response.statusCode == 200) {
                          print("inside response status");

                          setState(() {
                            isLoading = false;
                          });
                          phoneNumber.clear();
                          Navigator.pushReplacementNamed(context, "Otp",
                              arguments: phoneNumber.text);
                        }
                        if (response.statusCode == 400) {
                          callSnackBar("${res["msg"]}");
                          setState(() {
                            isLoading = false;
                          });
                          print("error with phone number");
                        }
                      } //response is not null

                    } on Exception catch (exception) {
                      print("exeception from api");
                      setState(() {
                        isLoading = false;
                      });
                      callSnackBar("network problem");
                    } catch (error) {
                      print("error from api");
                      setState(() {
                        isLoading = false;
                      });
                      callSnackBar(error.toString());
                    }
                  } //form validation
                }, //onpressed of login via otp button
//                           async {
//                   print("Send OTP button is clicked");
//                   Map<String, String> data = {"phoneno": phoneNumber.text};
//                         try {
//                                       response = await hp.post(
//                       '${Short.baseUrl}/loginviaotp',
//                       headers: headers,
//                       body: json.encode(data));
//                                         } on Exception catch (exception) {
//                                           print("exeception from api");

//                                           callSnackBar(
//                                               "Phone number already exists");
//                                         } catch (error) {
//                                           print("error from api");

//                                           callSnackBar(error.toString());
//                                         }

//                     // setState(() {
//                     //   isLoading=false;
//                     // });
//                     if(response!=null){
//                     if (response.statusCode == 200) {
//                       print("inside response status");
//                       Map res = json.decode(response.body);
//                       print(res.toString());
//  List<String> arg = List();
//                         arg.  add(res['msg']);
//                         arg.add(phoneNumber.text);
//                         print(arg.toString());
// phoneNumber.clear();
//                       if (res['status'] == 200) {
//                         setState(() {
//                           isLoading = false;
//                         });

//                       }
//                     } else {
//                          callSnackBar("Check your internet Connectivity");
//                     }
//                   }else {
//                          callSnackBar("Phone number already exists");
//                       }
//                 },

                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(50.0),
                ),
                child: Text("SEND OTP",
                    style: TextStyle(color: Colors.white, fontSize: 22))),
          ),
          // Row(children: <Widget>[
          //   Expanded(
          //     child: new Container(
          //         margin: const EdgeInsets.only(left: 10.0, right: 20.0),
          //         child: Divider(
          //           color: Colors.grey,
          //           height: 36,
          //         )),
          //   ),
          //   Material(
          //       color: Colors.white,
          //       child: Text(
          //         "or",
          //         style: TextStyle(color: Colors.grey, fontSize: 19),
          //       )),
          //   Expanded(
          //     child: new Container(
          //         margin: const EdgeInsets.only(left: 20.0, right: 10.0),
          //         child: Divider(
          //           color: Colors.grey,
          //           height: 36,
          //         )),
          //   ),
          // ]),
          // Center(
          //     child: Padding(
          //   padding:
          //       EdgeInsets.only(top: Short.h * 0.018, bottom: Short.h * 0.018),
          //   child: FlatButton(
          //     onPressed: () {
          //       print("Login via Password");
          //       Navigator.pushReplacementNamed(context, "Login",
          //           arguments: false);
          //     },
          //     child: Text(
          //       "Login via Password",
          //       style: TextStyle(
          //           color: Theme.of(context).primaryColor,
          //           fontSize: Short.h * 0.025),
          //     ),
          //   ),
          // )),
          Divider(
            color: Colors.grey[300],
            thickness: Short.h * 0.01,
            height: Short.h * 0.1,
          ),

          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Material(
                    color: Colors.white,
                    child: Text(
                      "Don't have an account ?",
                      style: TextStyle(color: Colors.grey, fontSize: 19),
                    )),
                FlatButton(
                  onPressed: () {
                    print("SignUp");
                    Navigator.pushReplacementNamed(context, "SignUp");
                  },
                  child: Text(
                    "SignUp",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 21),
                  ),
                ),
              ]),
        ],
      ),
    );
    return Scaffold(
      key: _scaffoldkey,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: Short.h * 0.3,
                color: Theme.of(context).primaryColor,
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "img/freshMeat.png",
                    alignment: Alignment.bottomCenter,
                  ),
                )),
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedBuilder(
                  child: child,
                  animation: _controller,
                  builder: (BuildContext context, Widget child) {
                    return SlideTransition(
                      position: animation,
                      child: child,
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
