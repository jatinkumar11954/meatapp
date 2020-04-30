import 'package:meatapp/adjust/short.dart';
import 'package:meatapp/screens/animate.dart';
import 'package:flutter/material.dart';
import 'package:meatapp/screens/animate.dart'as ani;
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();

}

class _SignUpState extends State<SignUp>  with TickerProviderStateMixin {
  



  TextEditingController fullName;
  TextEditingController phoneNumber;
  TextEditingController signUPemail;
  TextEditingController signUppwd;
  TextEditingController address;
    bool showPwd = true;
  Icon _icon = Icon(
    Icons.visibility,
  );
  final GlobalKey<FormState> _form = GlobalKey<FormState>(debugLabel: "key2");
  UniqueKey k3 = UniqueKey();
    AnimationController _controller;
     Animation<Offset> animation;
   void initState() {
    // TODO: implement initState
  fullName = new TextEditingController();
    phoneNumber = new TextEditingController();
    signUPemail = new TextEditingController();
    signUppwd= new TextEditingController();
    address = new TextEditingController();
    super.initState();
   _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
     animation =
                  Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
                      .animate( _controller); 
                      _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
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
  
                        var child=Container

      (
        key: k3,
                height:Short.h*0.82,
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
                        "SignUp",
                        style: TextStyle(
                            color: Colors.green, fontSize: Short.h * 0.046),
                      ),
                    ),
                  ),
                  // SizedBox(height:Short.h*0.1),

                  Form(
                    key: _form,
                    child: Column(
                      children: <Widget>[ Padding(
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
                                    borderRadius: BorderRadius.circular(
                                        Short.h * 2.5)),
                              ),
                              controller: signUPemail,
                              keyboardType: TextInputType.emailAddress,
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
                                    borderRadius: BorderRadius.circular(
                                        Short.h * 2.5)),
                              ),
                              controller: signUppwd,
                              keyboardType: TextInputType.visiblePassword,
                              validator: pwdValidator,
                            ),
                          ),
                        ),
                      ],
                    ),
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
                                  onPressed:(){print("login");},
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: Short.h * 0.025),
                                  ),
                                ),
                              ]),

                  ],
                  
                  ),
        
      );   
    return  Stack(children: <Widget>[
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
          child:child,
      animation: _controller,builder: (BuildContext context, Widget child) {
        return SlideTransition(
          position: animation,
                child: child,
              );},)),],);
  }
}
