import 'package:flutter/material.dart';
import 'package:meatapp/short.dart';

class LoginA extends StatefulWidget {
  @override
  _LoginAState createState() => _LoginAState();
}

class _LoginAState extends State<LoginA> {
  TextEditingController email;
  TextEditingController pwd;
  bool showPwd = true;
  String _log = "Login via Email/Phone";
  Icon _icon = Icon(
    Icons.visibility,
  );
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

  bool _child = true;

  void _tap() {}
  @override
  Widget build(BuildContext context) {
    Short().init(context);
    double _h = Short.h * 0.83;
    void _animate() {
      // CircularProgressIndicator()
      setState(() {
        _h = Short.h * 0.9;
        print("animate");
        _child = false;
      });
    }

    final style = TextStyle(color: Colors.green, fontSize: Short.h * 0.046);
    return Stack(children: <Widget>[
      Align(
        alignment: Alignment.topCenter,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          color: Colors.green,
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: AnimatedContainer(
            // Use the properties stored in the State class.
            height: _h,
            width: Short.w,

            // Define how long the animation should take.
            duration: Duration(seconds: 3),
            // Provide an optional curve to make the animation feel smoother.
            curve: Curves.fastOutSlowIn,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(80),
                    topRight: Radius.circular(80))),
            child: _child
                ? Padding(
                    padding: EdgeInsets.only(
                        bottom: Short.h * 0.15,
                        top: Short.h * 0.18,
                        left: Short.w * 0.03,
                        right: Short.w * 0.03),
                    child: Card(
                      elevation: 15.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                              child: FlatButton(
                            onPressed: _animate,
                            child: Text(
                              "Login via Email / Phone",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: Short.h * 0.025),
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
                          Center(
                              child: Padding(
                            padding: EdgeInsets.only(
                                top: Short.h * 0.02, bottom: Short.h * 0.02),
                            child: FlatButton(
                              onPressed: () {
                                print("LoginA via otp");
                              },
                              child: Text(
                                "Login via OTP",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: Short.h * 0.025),
                              ),
                            ),
                          )),
                          Padding(
                            padding: EdgeInsets.only(top: Short.h * 0.09),
                            child:
                                Divider(color: Colors.grey[300], thickness: Short.h * 0.01),
                          ),
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
                                          fontSize: Short.h * 0.025),
                                    )),
                                FlatButton(
                                  onPressed: () {
                                    print("Forgot Password");
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: Short.h * 0.025),
                                  ),
                                ),
                              ]),
                        ],
                      ),
                    ))
                : Column(children: <Widget>[
                    Center(
                      child: Material(
                        color: Colors.white,
                        child: Text(
                          "LoginA",
                          style: TextStyle(
                              color: Colors.green, fontSize: Short.h * 0.046),
                        ),
                      ),
                    ),
                    // SizedBox(height:Short.h*0.1),
                    Padding(
                      padding: EdgeInsets.only(
                          top: Short.h * 0.05,
                          left: Short.w * 0.07,
                          right: Short.w * 0.07),
                      child: Material(
                        color: Colors.white,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                color: Colors.grey, fontSize: Short.h * 0.02),
                            labelText: 'Email/Phone',
                            hintText: "Enter your email /Phone",
                            hintStyle: TextStyle(
                                color: Colors.grey, fontSize: Short.h * 0.02),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(Short.h * 2.5)),
                          ),
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          // validator: emailValidator,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: Short.h * 0.04,
                          left: Short.w * 0.07,
                          right: Short.w * 0.07),
                      child: Material(
                        color: Colors.white,
                        child: TextFormField(
                          obscureText: showPwd,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                color: Colors.grey, fontSize: Short.h * 0.02),
                            labelText: 'Password',
                            hintText: "Enter your Password",
                            hintStyle: TextStyle(
                                color: Colors.grey, fontSize: Short.h * 0.02),
                            suffixIcon: IconButton(
                              icon: _icon,
                              onPressed: _toggle,
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(Short.h * 2.5)),
                          ),
                          controller: pwd,
                          keyboardType: TextInputType.emailAddress,
                          // validator: emailValidator,
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: Short.h * 0.045),
                      child: RaisedButton(
                          padding: EdgeInsets.only(
                              top: Short.h * 0.015,
                              bottom: Short.h * 0.015,
                              left: Short.w * 0.30,
                              right: Short.w * 0.30),
                          color: Colors.green,
                          onPressed: () {
                            print("LoginA button is clicked");
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(50.0),
                          ),
                          child: Text("LoginA",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Short.h * 0.04))),
                    ),
                    Row(children: <Widget>[
                      Expanded(
                        child: new Container(
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 20.0),
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
                                color: Colors.grey, fontSize: Short.h * 0.02),
                          )),
                      Expanded(
                        child: new Container(
                            margin:
                                const EdgeInsets.only(left: 20.0, right: 10.0),
                            child: Divider(
                              color: Colors.grey,
                              height: 36,
                            )),
                      ),
                    ]),
                    Center(
                        child: Padding(
                      padding: EdgeInsets.only(
                          top: Short.h * 0.02, bottom: Short.h * 0.02),
                      child: FlatButton(
                        onPressed: () {
                          print("LoginA via otp");
                        },
                        child: Text(
                          "LoginA via OTP",
                          style: TextStyle(
                              color: Colors.green, fontSize: Short.h * 0.025),
                        ),
                      ),
                    )),
                    Divider(color: Colors.grey[300], thickness: Short.h * 0.01),
                    Center(
                        child: Padding(
                      padding: EdgeInsets.only(
                          top: Short.h * 0.02, bottom: Short.h * 0.02),
                      child: FlatButton(
                        onPressed: () {
                          print("Forgot Password");
                        },
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(
                              color: Colors.green, fontSize: Short.h * 0.025),
                        ),
                      ),
                    )),
                    Row(children: <Widget>[
                      Expanded(
                        child: new Container(
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 20.0),
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
                                color: Colors.grey, fontSize: Short.h * 0.02),
                          )),
                      Expanded(
                        child: new Container(
                            margin:
                                const EdgeInsets.only(left: 20.0, right: 10.0),
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
                                    fontSize: Short.h * 0.025),
                              )),
                          FlatButton(
                            onPressed: () {
                              print("Forgot Password");
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: Short.h * 0.025),
                            ),
                          ),
                        ]),
                  ])),
      ),
      
    ]);
  }
}
