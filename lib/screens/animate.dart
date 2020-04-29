import 'package:flutter/material.dart';
import 'package:meatapp/adjust/short.dart';
import 'package:meatapp/adjust/widget.dart';
import 'package:meatapp/screens/Signup.dart';

class LoginA extends StatefulWidget {
  @override
  _LoginAState createState() => _LoginAState();
}

class _LoginAState extends State<LoginA> {
  void _animate() {
    // CircularProgressIndicator()
    setState(() {
      print("animate");
      _child = false;
    });
  }

  TextEditingController email;
  TextEditingController pwd;
  bool showPwd = true;
  bool login = true;

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

  void loginFalse() {
    setState(() {
      _child=false;
      login = false;
    });
  }

  void loginTrue() {
    setState(() {
      print("object");
      login = true;
    });
  }

  bool _child = true;
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: "key1");
  static final GlobalKey<FormState> _form =
      GlobalKey<FormState>(debugLabel: "key2");
  UniqueKey k1 = UniqueKey();
  UniqueKey k2 = UniqueKey();

  @override
  Widget build(BuildContext context) {
    Short().init(context);
    double _h = Short.h * 0.83;

    final style = TextStyle(color: Colors.green, fontSize: Short.h * 0.046);
    return Stack(children: <Widget>[
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
            transitionBuilder: (Widget child, Animation<double> animation) {
              final offsetAnimation =
                  Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
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
                ? LoginBftrAnim(context, _animate,loginFalse)
                : AnimatedSwitcher(
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
                    child: login
                        ? Container(
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
                                        color: Colors.green,
                                        fontSize: Short.h * 0.046),
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
                                          // validator: emailValidator,
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
                                          validator: pwdValidator,
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
                                        left: Short.w * 0.30,
                                        right: Short.w * 0.30),
                                    color: Colors.green,
                                    onPressed: () {
                                      print("Login button is clicked");
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(50.0),
                                    ),
                                    child: Text("Login",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: Short.h * 0.04))),
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
                                    print("Login via otp");
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
                                              fontSize: Short.h * 0.025),
                                        )),
                                    FlatButton(
                                      onPressed: loginFalse,
                                      child: Text(
                                        "Sign Up",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: Short.h * 0.025),
                                      ),
                                    ),
                                  ]),
                            ]),
                          )
                        : SignUp(loginTrue: login))),
      ),
    ]);
  }
}

String pwdValidator(String value) {
  if (value.length < 3) {
    return "please fill this field with atleast 3 characters";
  } else {
    return null;
  }
}
