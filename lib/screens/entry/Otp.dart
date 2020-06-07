import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:meatapp/adjust/short.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class Otp extends StatefulWidget {
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> with TickerProviderStateMixin{
    var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();
                        //  ..text = "123456";

  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  



  
  AnimationController _controller;
  Animation<Offset> animation;
  void initState() {
    // TODO: implement initState
  
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();

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
       errorController.close();
    _controller.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    // List<String> i=ModalRoute.of(context).settings.arguments;
   String i=ModalRoute.of(context).settings.arguments;
    textEditingController.text="1526";//0 is for otp
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
            child: Padding(
              padding: const EdgeInsets.only(top:15.0),
              child: Text(
                "OTP Verification",
                style:
                    TextStyle(color: Theme.of(context).primaryColor, fontSize: 33,fontWeight: FontWeight.w600),
              ),
            ),
          ),
          // SizedBox(height:Short.h*0.1),
           Padding(
             padding:  EdgeInsets.only(top:50.0),
             child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "One time password(OTP) has been ",
                    style: TextStyle(
                        color: Colors.grey, fontSize: 20),
                  ),
                   Text(
                    "sent to your mobile ",
                    style: TextStyle(
                        color: Colors.grey, fontSize: 20),
                  ),
                  ]),
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Center(
               child:Text(
                              "+91-${i}",//1 is for phone number
                              
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400),
                            ), 
             ),
           ),
            Center(
              child: Text(
                      "Please enter the same here",
                      style: TextStyle(
                          color: Colors.grey, fontSize: 20),
                    ),
            ),

            GestureDetector(
                          child: Container(
                            width: Short.w*0.5,
                            child: PinCodeTextField(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              length: 4,
                              obsecureText: false,
                              animationType: AnimationType.fade,
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.underline,
                                // borderRadius: BorderRadius.circular(5),
                                fieldHeight: 50,
                                fieldWidth: 40,
                                activeFillColor: Colors.white,
                                inactiveFillColor: Colors.white,
                                selectedFillColor: Colors.white,
                                inactiveColor: Colors.grey
                              ),
                              animationDuration: Duration(milliseconds: 300),
                              // backgroundColor: Colors.blue.shade50,
                              enableActiveFill: true,
                              errorAnimationController: errorController,
                              controller: textEditingController,
                              onCompleted: (v) {
                                print("Completed");
                              },
                              onChanged: (value) {
                                print(value);
                                                  //frescd /var/www/html/apis/freshMeat-api

                                setState(() {
                                  currentText = value;
                                });
                              },
                              beforeTextPaste: (text) {
                                print("Allowing to paste $text");
                                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                return true;
                              },
                            ),
                          ),
            ),
            Padding(
                          padding: EdgeInsets.only(top: Short.h * 0.045),
                          child: RaisedButton(
                              padding: EdgeInsets.only(
                                  top: Short.h * 0.01,
                                  bottom: Short.h * 0.01,
                                  left: Short.w * 0.2,
                                  right: Short.w * 0.2),
                              color: Theme.of(context).primaryColor,
                              onPressed: () {
                                print("Verify OTP button is clicked");
                                 Navigator.pushReplacementNamed(
                                                  context, "Main");
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(50.0),
                              ),
                              child: Text("VERIFY OTP",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22))),
                        ),
                       
                        Center(
                            child: Padding(
                          padding: EdgeInsets.only(
                              top: Short.h * 0.018, bottom: Short.h * 0.018),
                          child: FlatButton(
                            onPressed: () {
                              print("Resend OTP");
                            },
                            child: Text(
                              "Resend OTP",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 22),
                            ),
                          ),
                        )),

         
 
         
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
            color: Theme.of(context).primaryColor,
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