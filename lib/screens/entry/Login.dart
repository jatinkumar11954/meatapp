import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as snack;
import 'package:meatapp/main.dart';
import 'package:meatapp/adjust/short.dart';
import 'package:meatapp/adjust/widget.dart';
import 'package:http/http.dart' as hp;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static const headers = {'Content-Type': 'application/json'};

  hp.Response response;
  bool _isLoading = false;

  TextEditingController email;
  TextEditingController pwd;

  bool showPwd = true;
  bool login = true;

  Icon _icon = Icon(
    Icons.visibility,
  );

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  void callSnackBar(String msg) {
    print(msg + "snack msg");
    final Snack = new snack.SnackBar(
      content: new Text(msg),
      duration: new Duration(seconds: 3),
    );
    _scaffoldkey.currentState.showSnackBar(Snack);
  }

  @override
  void initState() {
    // TODO: implement initState
    email = new TextEditingController();
    pwd = new TextEditingController();

    super.initState();
  }

  void dispose() {
    super.dispose();
    email.dispose();
    pwd.dispose();
  }

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

  void loginFalse() {
    setState(() {
      _child = false;
      login = false;
    });
  }

  bool ind = true;
  bool _child = true;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>(debugLabel: "key1");
  UniqueKey k1 = UniqueKey();
  UniqueKey k2 = UniqueKey();

  @override
  Widget build(BuildContext context) {
    ind = ModalRoute.of(context).settings.arguments;
    if (ind == false) {
      loginFalse();
    }
    Short().init(context);

    // final style = TextStyle(color: Theme.of(context).primaryColor, fontSize: Short.h * 0.046);
    return Scaffold(
        key: _scaffoldkey,
        body: SingleChildScrollView(
          child: Stack(children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: Theme.of(context).primaryColor,
                // Theme.of(context).primaryColor,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: Short.h * 0.35,
                color: Theme.of(context).primaryColor,
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "img/freshMeat.png",
                    alignment: Alignment.bottomCenter,
                  ),
                )),
                // Theme.of(context).primaryColor,
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 950),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      final offsetAnimation = Tween<Offset>(
                              begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
                          .animate(animation);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
// transitionBuilder: (Widget child, Animation<double> animation) {
// return ScaleTransition(
//         scale: animation,
//         child: child,
//        );
//    },
                    child: _child
                        ? LoginBftrAnim(context, loginFalse, k1)
                        : Container(
                            margin: EdgeInsets.only(top: Short.h * 0.27),

                            key: k2,
                            height: Short.h * 0.73,
                            width: Short.w,

                            // Define how long the animation should take.

                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 20.0,
                                      offset: Offset(0.0, -3.5),
                                      color: Colors.black45),
                                ],
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(80),
                                    topRight: Radius.circular(80))),
                            child: Column(children: <Widget>[
                              // Center(
                              //   child: Material(
                              //     color: Colors.white,
                              //     child: Text(
                              //       "Login",
                              //       style: TextStyle(
                              //           color: Theme.of(context).primaryColor, fontSize: 30
                              //           //  Short.h * 0.046
                              //           ),
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(height:Short.h*0.1),

                              Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: Short.h * 0.10,
                                          left: Short.w * 0.1,
                                          right: Short.w * 0.1),
                                      child: Material(
                                        color: Colors.white,
                                        child: TextFormField(
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          decoration: InputDecoration(
                                            fillColor:
                                                Theme.of(context).accentColor,
                                            filled: true,
                                            labelStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 19),
                                            labelText: 'Email/Phone',
                                            hintText: "Enter your email /Phone",
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 19),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Short.h * 2.5)),
                                          ),
                                          controller: email,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          validator: Short().validateMobile,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 25,
                                          left: Short.w * 0.1,
                                          right: Short.w * 0.1),
                                      child: Material(
                                        color: Colors.white,
                                        child: TextFormField(
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          obscureText: showPwd,
                                          decoration: InputDecoration(
                                            fillColor:
                                                Theme.of(context).accentColor,
                                            filled: true,
                                            labelStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 19),
                                            labelText: 'Password',
                                            hintText: "Enter your Password",
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 19),
                                            suffixIcon: IconButton(
                                              icon: _icon,
                                              onPressed: _toggle,
                                            ),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Short.h * 2.5)),
                                          ),
                                          controller: pwd,
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          validator: Short().validatePwd,
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
                                        left: Short.w * 0.29,
                                        right: Short.w * 0.29),
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () async {
                                      void a() {
                                        print("A");
                                      }

                                      print("Login button is clicked");
                                      if (_formKey.currentState.validate()) {
                                        
                                        print("Form is validated");

                                        setState(() {
                                          _isLoading = true;
                                        });
                                        Map<String, dynamic> data = {
                                          "phoneno":
                                              // "6556121480",
                                              email.text,
                                          "password": // "152346"
                                              pwd.text
                                        };
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        print("before post" + data.toString());
                                        try {
                                          callSnackBar(
                                              "Checking the entered details");

                                          response = await hp.post(
                                              "${Short.baseUrl}/login",
                                              body: json.encode(data),
                                              headers: headers);

                                          if (response != null) {
                                            Map res =
                                                json.decode(response.body);
                                            if (response.statusCode == 200) {
                                              print("inside response status");

                                              Map jwt = json.decode(ascii
                                                  .decode(base64.decode(base64
                                                      .normalize(res['token']
                                                          .split(".")[1]))));

                                              storeLocal() async {
                                                SharedPreferences store =
                                                    await SharedPreferences
                                                        .getInstance();
                                                print("storing jwt locally");

                                                store.setString(
                                                    'jwt',
                                                    res['token']
                                                        .split(".")[1]
                                                        .toString());
                                              }

                                              setState(() {
                                                storeLocal();
                                                _isLoading = false;
                                              });
                                              //store jwt locally

                                              print("jwt");
                                              print(jwt.toString());
                                              email.clear();
                                              pwd.clear();
                                              login = true;
                                              Navigator.pushReplacementNamed(
                                                  context, "Main",
                                                  arguments: jwt);
                                            }
                                            if (response.statusCode == 400) {
                                              callSnackBar("${res["msg"]}");
                                              setState(() {
                                                _isLoading = false;
                                              });
                                              print(
                                                  "invalid username or password");
                                            }
                                          } //response is not null

                                        } on Exception catch (exception) {
                                          print("exeception from api");
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          callSnackBar("network problem");
                                        } catch (error) {
                                          print("error from api");
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          callSnackBar(error.toString());
                                        }
                                      } //form validation
                                    }, //onpressed of login button
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(50.0),
                                    ),
                                    child: _isLoading
                                        ? CircularProgressIndicator()
                                        : Text("LOGIN",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25))),
                              ),
                              // Row(children: <Widget>[
                              //   Expanded(
                              //     child: new Container(
                              //         margin: const EdgeInsets.only(
                              //             left: 10.0, right: 20.0),
                              //         child: Divider(
                              //           color: Colors.grey,
                              //           height: 36,
                              //         )),
                              //   ),
                              //   Material(
                              //       color: Colors.white,
                              //       child: Text(
                              //         "or",
                              //         style: TextStyle(
                              //             color: Colors.grey,
                              //             fontSize: 19),
                              //       )),
                              //   Expanded(
                              //     child: new Container(
                              //         margin: const EdgeInsets.only(
                              //             left: 20.0, right: 10.0),
                              //         child: Divider(
                              //           color: Colors.grey,
                              //           height: 36,
                              //         )),
                              //   ),
                              // ]),
                              // Center(
                              //     child: Padding(
                              //   padding: EdgeInsets.only(
                              //       top: Short.h * 0.018,
                              //       bottom: Short.h * 0.018),
                              //   child: FlatButton(
                              //     onPressed: () {
                              //       Navigator.pushReplacementNamed(
                              //           context, "LoginOtp");
                              //     },
                              //     child: Text(
                              //       "Login via OTP",
                              //       style: TextStyle(
                              //           color: Theme.of(context).primaryColor,
                              //           fontSize: 195),
                              //     ),
                              //   ),
                              // )),
                              // Divider(
                              //     color: Colors.grey[300],
                              //     height: Short.h * 0.08,
                              //     thickness: 2),
                              Center(
                                  child: Padding(
                                padding: EdgeInsets.only(top: Short.h * 0.01),
                                child: FlatButton(
                                  onPressed: () {
                                    print("Forgot Password");
                                  },
                                  child: ListTile(
                                    title: Center(
                                      child: Text(
                                        "Forgot Password",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 22),
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                              // Row(children: <Widget>[
                              //   Expanded(
                              //     child: new Container(
                              //         margin: const EdgeInsets.only(
                              //             left: 10.0, right: 20.0),
                              //         child: Divider(
                              //           color: Colors.grey,
                              //           height: 36,
                              //         )),
                              //   ),
                              //   Material(
                              //       color: Colors.white,
                              //       child: Text(
                              //         "or",
                              //         style: TextStyle(
                              //             color: Colors.grey, fontSize: 19),
                              //       )),
                              //   Expanded(
                              //     child: new Container(
                              //         margin: const EdgeInsets.only(
                              //             left: 20.0, right: 10.0),
                              //         child: Divider(
                              //           color: Colors.grey,
                              //           height: 36,
                              //         )),
                              //   ),
                              // ]),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Material(
                                        color: Colors.white,
                                        child: Text(
                                          "Don't have an account ? ",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 19),
                                        )),
                                    FlatButton(
                                      onPressed: () =>
                                          Navigator.pushReplacementNamed(
                                              context, "SignUp"),
                                      child: Text(
                                        "Sign Up",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 21),
                                      ),
                                    ),
                                  ]),
                            ]),
                          ))),
          ]),
        ));
  }
}
