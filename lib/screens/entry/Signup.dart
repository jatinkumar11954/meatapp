import 'package:geolocator/geolocator.dart';
import 'package:meatapp/adjust/short.dart';
import 'package:meatapp/screens/entry/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as snack;
import 'package:meatapp/location/locator.dart';
import 'package:http/http.dart' as hp;
import 'dart:convert';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with TickerProviderStateMixin {
  static const headers = {'Content-Type': 'application/json'};
  TextEditingController fullName;
  TextEditingController phoneNumber;
  TextEditingController signUPemail;
  TextEditingController signUppwd;
  TextEditingController address;
  bool showPwd = true;
  Icon _icon = Icon(
    Icons.visibility,
  );
  Position _currentPosition;
  GlobalKey<FormState> _form = GlobalKey<FormState>(debugLabel: "key2");
  bool isLoading = false;
    bool getLocation = false;

  AnimationController _controller;
  Animation<Offset> animation;
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
    fullName = new TextEditingController();
    phoneNumber = new TextEditingController();
    signUPemail = new TextEditingController();
    signUppwd = new TextEditingController();
    address = new TextEditingController();
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
    fullName.dispose();
    phoneNumber.dispose();
    signUPemail.dispose();
    signUppwd.dispose();
    address.dispose();
    super.dispose();
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
                "SignUp",
                style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 29
                    // Short.h * 0.046
                    ),
              ),
            ),
          ),
          Form(
            key: _form,
            child: Column(
              children: <Widget>[
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
                            color: Colors.grey, fontSize: Short.h * 0.02),
                        labelText: 'Full Name',
                        hintText: "Enter your Full Name",
                        hintStyle: TextStyle(
                            color: Colors.grey, fontSize: Short.h * 0.02),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Short.h * 2.5)),
                      ),
                      controller: fullName,
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
                            color: Colors.grey, fontSize: Short.h * 0.02),
                        labelText: 'Email',
                        hintText: "Enter your Email Address",
                        hintStyle: TextStyle(
                            color: Colors.grey, fontSize: Short.h * 0.02),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Short.h * 2.5)),
                      ),
                      controller: signUPemail,
                      keyboardType: TextInputType.emailAddress,
                      validator: Short().validateEmail,
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
                            color: Colors.grey, fontSize: Short.h * 0.02),
                        labelText: 'Mobile Number',
                        hintText: "Enter your Mobile Number",
                        hintStyle: TextStyle(
                            color: Colors.grey, fontSize: Short.h * 0.02),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Short.h * 2.5)),
                      ),
                      controller: phoneNumber,
                      keyboardType: TextInputType.number,
                      validator: Short().validateMobile,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: Short.h * 0.018,
                      left: Short.w * 0.07,
                      right: Short.w * 0.07),
                  child: 
                   TextFormField(
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: Colors.grey, fontSize: Short.h * 0.02),
                        labelText: 'Address',
                        hintText: "Enter your Address",
                        hintStyle: TextStyle(
                            color: Colors.grey, fontSize: Short.h * 0.02),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Short.h * 2.5)),
                      ),
                      controller: address,
                      keyboardType: TextInputType.text,
                      validator: Short().validateAddr,
                    ),
//                   RaisedButton(
//                     padding:EdgeInsets.only(
//                       top: Short.h * 0.018,
//                       left: Short.w * 0.07,
//                       right: Short.w * 0.07),
//                    child:getLocation
//                     ? CircularProgressIndicator()
//                     : Text("Get Location",
//                         style: TextStyle(color: Colors.white, fontSize: 21)),
//                 onPressed:(){
//    setState(() {

//   getLocation=true;
// });
//                   //  print(  _currentPosition.longitude);
//                    setState(() {
//   getLocation=false;
// });
                   
//                    },
//                   ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: Short.h * 0.018,
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
                            borderRadius: BorderRadius.circular(Short.h * 2.5)),
                      ),
                      controller: signUppwd,
                      keyboardType: TextInputType.visiblePassword,
                      // validator: Short().validatePwd,
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
                    left: Short.w * 0.3,
                    right: Short.w * 0.3),
                color: Theme.of(context).primaryColor,
                onPressed: () async {
                  print("SIGN UP button is clicked");
                  if (_form.currentState.validate()) 
                {          

                    print("Form is validated");

                    setState(() {
                      isLoading = true;
                    });
                    _currentPosition=getCurrentLocation();
                    Map<String, dynamic> data = {
                      "fullname":
                          // "jatin",
                          fullName.text,
                      "email":
                          // "test@gmail.com",
                          signUPemail.text,
                      "phoneno":
                          // "6556121480",
                          phoneNumber.text,
                      "address":
                          // "no addres",
                          address.text+" " +_currentPosition.toString(),
                                               "password":
                          // "152346"
                          signUppwd.text
                    };
                    setState(() {
                      isLoading = true;
                    });
                    print("before post" + data.toString());
                   
                    try {
                      callSnackBar("Validating...");
                      response = await hp.post("${Short.baseUrl}/signup",
                          body: json.encode(data), headers: headers);
                               print(response.toString());
                      if (response != null) {
                        Map res = json.decode(response.body);
                        if (response.statusCode == 200) {
                          print("inside response status");

                          setState(() {
                            isLoading = false;
                          });
                          Navigator.pushReplacementNamed(context, "Login",
                              arguments: false);
                                                         }
                        if (response.statusCode == 400) {
                          // callSnackBar("${res["msg"]}");
                          callSnackBar(
                              "User with these details already exists");

                          print("User with these details already exists");
                                                   }
                                            } //response is not null
                      // else {
                      //   //response is null
                      //   callSnackBar(
                      //       "network problem");
                      //   print(
                      //       "response is null");
                      // }

                    }//try
                     on Exception catch (exception) {

                      print("exeception from api");

                      callSnackBar("User with these details already exists");
                    } catch (error) {
                      print("error from api");

                      callSnackBar(error.toString());
                    }//catch

                    // setState(() {
                    //   isLoading=false;
                    // });
                  }//form validation
                },
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(50.0),
                ),
                child: isLoading
                    ? CircularProgressIndicator()
                    : Text("SIGN UP",
                        style: TextStyle(color: Colors.white, fontSize: 21)),
              )),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Material(
                    color: Colors.white,
                    child: Text(
                      "Already have an account ?",
                      style: TextStyle(
                          color: Colors.grey, fontSize: Short.h * 0.022),
                    )),
                FlatButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "Login",
                        arguments: false);
                    print("login");
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,  fontSize: 21),
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
