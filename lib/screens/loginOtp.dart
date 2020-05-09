import 'package:flutter/material.dart';
import 'package:meatapp/adjust/short.dart';

class LoginOtp extends StatefulWidget {
  @override
  _LoginOtpState createState() => _LoginOtpState();
}

class _LoginOtpState extends State<LoginOtp> with TickerProviderStateMixin{

  TextEditingController phoneNumber;

  
  GlobalKey<FormState> _form = GlobalKey<FormState>(debugLabel: "key2");
  
  AnimationController _controller;
  Animation<Offset> animation;
  void initState() {
    // TODO: implement initState
  
    phoneNumber = new TextEditingController();

    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds:900),
      vsync: this,
    );
    animation = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
        .animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    var child = Container(
     
      height: Short.h * 0.82,
      width: Short.w,

      margin: EdgeInsets.only(top: Short.h * 0.18),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(80), topRight: Radius.circular(80))),
      child: Column(
        children: <Widget>[
          Center(
            child: Material(
              color: Colors.white,
              child: Text(
                "Login via OTP",
                style:
                    TextStyle(color: Colors.green, fontSize: Short.h * 0.04),
              ),
            ),
          ),
          // SizedBox(height:Short.h*0.1),

          Form(
            key: _form,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      top: 25, left: Short.w * 0.07, right: Short.w * 0.07),
                  child: Material(
                    color: Colors.white,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: Colors.grey, fontSize: Short.h * 0.02),
                        labelText: 'Phone Number',
                        hintText: "Enter your Phone Number",
                        hintStyle: TextStyle(
                            color: Colors.grey, fontSize: Short.h * 0.02),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(Short.h * 2.5)),
                      ),
                      controller: phoneNumber,
                      keyboardType: TextInputType.number,
                      // validator: emailValidator,
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
                              color: Colors.green,
                              onPressed: () {
                                print("Send OTP button is clicked");
                                 Navigator.pushNamed(context, "Otp");
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(50.0),
                              ),
                              child: Text("SEND OTP",
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
                              top: Short.h * 0.018, bottom: Short.h * 0.018),
                          child: FlatButton(
                            onPressed: () {
                              print("Login via Password");
                            },
                            child: Text(
                              "Login via Password",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: Short.h * 0.025),
                            ),
                          ),
                        )),
                        Divider(
                            color: Colors.grey[300], thickness: Short.h * 0.01),
 
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Material(
                    color: Colors.white,
                    child: Text(
                      "Don't have an account ?",
                      style: TextStyle(
                          color: Colors.grey, fontSize: Short.h * 0.025),
                    )),
                FlatButton(
                  onPressed: () {   print("SignUp");
                    Navigator.pushNamed(context, "SignUp");
                 
                  },
                  child: Text(
                    "SignUp",
                    style: TextStyle(
                        color: Colors.green, fontSize: Short.h * 0.025),
                  ),
                ),
              ]),
        ],
      ),
    );
    return
         Scaffold(
          body: 
          SingleChildScrollView(
            child:
        Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.green,
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