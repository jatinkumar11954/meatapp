import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as hp;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as snack;

import 'package:meatapp/adjust/short.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Otp extends StatefulWidget {
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> with TickerProviderStateMixin {
  var onTapRecognizer;

  TextEditingController otpController = TextEditingController();
  //  ..text = "123456";

  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  hp.Response response;
  void callSnackBar(String msg) {
    print(msg + "snack msg");
    final Snack = new snack.SnackBar(
      content: new Text(msg),
      duration: new Duration(seconds: 3),
    );
    _scaffoldkey.currentState.showSnackBar(Snack);
  }

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
      duration: const Duration(milliseconds: 900),
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
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const headers = {'Content-Type': 'application/json'};

    // List<String> i=ModalRoute.of(context).settings.arguments;
    String i = ModalRoute.of(context).settings.arguments;
//0 is for otp
    var child = Container(
      height: Short.h * 0.73,
      width: Short.w,
      margin: EdgeInsets.only(top: Short.h * 0.27),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 20.0,
                offset: Offset(0.0, -3.5),
                color: Colors.black45),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(80), topRight: Radius.circular(80))),
      child: Column(
        children: <Widget>[
          // Center(
          //   child: Padding(
          //     padding: const EdgeInsets.only(top:15.0),
          //     child: Text(
          //       "OTP Verification",
          //       style:
          //           TextStyle(color: Theme.of(context).primaryColor, fontSize: 33,fontWeight: FontWeight.w600),
          //     ),
          //   ),
          // ),
          // SizedBox(height:Short.h*0.1),
          Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "One time password(OTP) has been ",
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                  Text(
                    "sent to your mobile ",
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                ]),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "+91-${i}", //1 is for phone number

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
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
          ),

          GestureDetector(
            child: Container(
              width: Short.w * 0.5,
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
                    inactiveColor: Colors.grey),
                animationDuration: Duration(milliseconds: 300),
                // backgroundColor: Colors.blue.shade50,
                enableActiveFill: true,
                errorAnimationController: errorController,
                controller: otpController,
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
                onPressed: () async {
                  print("Send OTP button is clicked");
                  if (otpController.text.length == 4) {
                    print("4 digit otp is entered");

                    setState(() {
                      _isLoading = true;
                    });
                    print(otpController.text);
                    Map<String, String> data = {
                      "phoneno": i,
                      "otp": otpController.text
                    };
                    print("before post" + data.toString());
                    try {
                      callSnackBar("Checking the entered details");
                      response = await hp.post('${Short.baseUrl}/verifyotp',
                          headers: headers, body: json.encode(data));

                      if (response != null) {
                        Map res = json.decode(response.body);
                        if (response.statusCode == 200) {
                          print("inside response status");

                          setState(() {
                            _isLoading = false;
                          });
                          otpController.clear();
                          Navigator.pushReplacementNamed(context, "Main");
                        }
                        if (response.statusCode == 400) {
                          callSnackBar("${res["msg"]}");
                          setState(() {
                            _isLoading = false;
                          });
                          otpController.clear();

                          print("error with phone number");
                        }
                      } //response is not null

                    } on Exception catch (exception) {
                      print("exeception from api");
                      setState(() {
                        _isLoading = false;
                      });
                      callSnackBar("network problem");
                      otpController.clear();
                    } catch (error) {
                      print("error from api");
                      setState(() {
                        _isLoading = false;
                      });
                      callSnackBar(error.toString());
                      otpController.clear();
                    }
                  } //form validation
                } //onpressed of login via otp button

                ,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(50.0),
                ),
                child: _isLoading
                    ? CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      )
                    : Text("VERIFY OTP",
                        style: TextStyle(color: Colors.white, fontSize: 22))),
          ),

          Center(
              child: Padding(
            padding:
                EdgeInsets.only(top: Short.h * 0.018, bottom: Short.h * 0.018),
            child: FlatButton(
              onPressed: () {
                print("Resend OTP");
              },
              child: Text(
                "Resend OTP",
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 22),
              ),
            ),
          )),
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
                height: Short.h * 0.35,
                color: Theme.of(context).primaryColor,
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "img/logo.png",
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
