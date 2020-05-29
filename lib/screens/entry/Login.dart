import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as snack;

import 'package:meatapp/adjust/short.dart';
import 'package:meatapp/adjust/widget.dart';
import 'package:http/http.dart' as hp;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static const headers = {'Content-Type': 'application/json'};

  hp.Response response;
  bool isLoading = false;

  TextEditingController email;
  TextEditingController pwd;

  bool showPwd = true;
  bool login = true;

  Icon _icon = Icon(
    Icons.visibility,
  );

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  void callSnackBar(String me) {
    print("called me for scnack bar");
    final nackBar = new snack.SnackBar(
      content: new Text(me),
      duration: new Duration(seconds: 3),
    );
    _scaffoldkey.currentState.showSnackBar(nackBar);
  }

  @override
  void initState() {
    // TODO: implement initState
    email = new TextEditingController();
    pwd = new TextEditingController();

    super.initState();
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
  
    // final style = TextStyle(color: Colors.green, fontSize: Short.h * 0.046);
    return Scaffold(
        key: _scaffoldkey,
        body: SingleChildScrollView(
          child: Stack(children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.green,
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
                            margin: EdgeInsets.only(top: Short.h * 0.18),

                            key: k2,
                            height: Short.h * 0.82,
                            width: Short.w,

                            // Define how long the animation should take.

                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(80),
                                    topRight: Radius.circular(80))),
                            child: Column(children: <Widget>[
                              Center(
                                child: Material(
                                  color: Colors.white,
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 30
                                        //  Short.h * 0.046
                                        ),
                                  ),
                                ),
                              ),
                              // SizedBox(height:Short.h*0.1),

                              Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 25,
                                          left: Short.w * 0.07,
                                          right: Short.w * 0.07),
                                      child: Material(
                                        color: Colors.white,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            labelStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: Short.h * 0.02),
                                            labelText: 'Email/Phone',
                                            hintText: "Enter your email /Phone",
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: Short.h * 0.02),
                                            border: OutlineInputBorder(
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
                                          left: Short.w * 0.07,
                                          right: Short.w * 0.07),
                                      child: Material(
                                        color: Colors.white,
                                        child: TextFormField(
                                          obscureText: showPwd,
                                          decoration: InputDecoration(
                                            labelStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: Short.h * 0.02),
                                            labelText: 'Password',
                                            hintText: "Enter your Password",
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: Short.h * 0.02),
                                            suffixIcon: IconButton(
                                              icon: _icon,
                                              onPressed: _toggle,
                                            ),
                                            border: OutlineInputBorder(
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
                                        left: Short.w * 0.33,
                                        right: Short.w * 0.33),
                                    color: Colors.green,
                                    onPressed: () async
                               {
                                      print("Login button is clicked");
                                      if (_formKey.currentState.validate())
                                   {
                                        print("Form is validated");

                                        setState(() {
                                          isLoading = true;
                                        });
                                        Map<String, dynamic> data = {
                                          "phoneno":
                                              // "6556121480",
                                              email.text,
                                          "password":
                                              // "152346"
                                              pwd.text
                                                };
                                        setState(() {
                                          isLoading = true;
                                                 });
                                        print("before post" + data.toString());
                                        try {
                                          callSnackBar("Checking the entered details");
                                          response = await hp.post(
                                              "${Short.baseUrl}/login",
                                              body: json.encode(data),
                                              headers: headers);
                                           

                                        if (response != null) 
                                      {

                                          Map res = json.decode(response.body);
                                          if (response.statusCode == 200) 
                                          {
                                            print("inside response status");

                                            setState(() {
                                              isLoading = false;
                                            });
                                            var jwt = json.decode(ascii.decode(base64.decode(base64.normalize(
                                                res['token'].split(".")[1]))));
                                                //store jwt locally
                                                
                                            print("jwt");
                                            print(jwt.toString());
                                            Navigator.pushReplacementNamed(context, "Main");
                                          }
                                          if (response.statusCode == 400) {
                                            callSnackBar("${res["msg"]}");

                                            print("invalid username or password");
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
                                              "network problem");
                                               } catch (error) {
                                          print("error from api");

                                          callSnackBar(error.toString());
                                                          }
                                       
              
                                        
                                     
                                     }//form validation
                                },//onpressed of login button
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(50.0),
                                    ),
                                    child: isLoading
                                        ? CircularProgressIndicator()
                                        : Text("LOGIN",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25))),
                              ),
                              Row(children: <Widget>[
                                Expanded(
                                  child: new Container(
                                      margin: const EdgeInsets.only(
                                          left: 10.0, right: 20.0),
                                      child: Divider(
                                        color: Colors.grey,
                                        height: 36,
                                      )),
                                ),
                                Material(
                                    color: Colors.white,
                                    child: Text(
                                      "or",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: Short.h * 0.02),
                                    )),
                                Expanded(
                                  child: new Container(
                                      margin: const EdgeInsets.only(
                                          left: 20.0, right: 10.0),
                                      child: Divider(
                                        color: Colors.grey,
                                        height: 36,
                                      )),
                                ),
                              ]),
                              Center(
                                  child: Padding(
                                padding: EdgeInsets.only(
                                    top: Short.h * 0.018,
                                    bottom: Short.h * 0.018),
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, "LoginOtp");
                                  },
                                  child: Text(
                                    "Login via OTP",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: Short.h * 0.025),
                                  ),
                                ),
                              )),
                              Divider(
                                  color: Colors.grey[300],
                                  thickness: Short.h * 0.01),
                              Center(
                                  child: Padding(
                                padding: EdgeInsets.only(top: Short.h * 0.01),
                                child: FlatButton(
                                  onPressed: () {
                                    print("Forgot Password");
                                  },
                                  child: Text(
                                    "Forgot Password",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: Short.h * 0.025),
                                  ),
                                ),
                              )),
                              Row(children: <Widget>[
                                Expanded(
                                  child: new Container(
                                      margin: const EdgeInsets.only(
                                          left: 10.0, right: 20.0),
                                      child: Divider(
                                        color: Colors.grey,
                                        height: 36,
                                      )),
                                ),
                                Material(
                                    color: Colors.white,
                                    child: Text(
                                      "or",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: Short.h * 0.02),
                                    )),
                                Expanded(
                                  child: new Container(
                                      margin: const EdgeInsets.only(
                                          left: 20.0, right: 10.0),
                                      child: Divider(
                                        color: Colors.grey,
                                        height: 36,
                                      )),
                                ),
                              ]),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Material(
                                        color: Colors.white,
                                        child: Text(
                                          "Don't have an account ? ",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: Short.h * 0.02),
                                        )),
                                    FlatButton(
                                      onPressed: () =>
                                          Navigator.pushReplacementNamed(
                                              context, "SignUp"),
                                      child: Text(
                                        "Sign Up",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: Short.h * 0.023),
                                      ),
                                    ),
                                  ]),
                            ]),
                          ))),
          ]),
        ));
  }
}

