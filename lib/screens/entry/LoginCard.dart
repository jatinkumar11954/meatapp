import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meatapp/adjust/short.dart';
import 'package:meatapp/adjust/widget.dart';

class LoginCard extends StatefulWidget {
  @override
  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> animation;

  void initState() {
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Short().init(context);
    return Scaffold(
        body: WillPopScope(
            onWillPop: () {
              showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      // insetPadding:  EdgeInsets.all(20),
                      titlePadding: EdgeInsets.fromLTRB(40, 30, 40, 10),
                      contentPadding: EdgeInsets.fromLTRB(40, 5, 40, 0),
                      backgroundColor: Color.fromRGBO(46, 54, 67, 1),
                      title: Text('Exit from FreshMeat?',
                          style: TextStyle(color: Colors.white)),
                      content: Text('This will close the App!',
                          style: TextStyle(color: Colors.white)),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text('No'),
                        ),
                        FlatButton(
                          onPressed: () =>
                              SystemChannels.platform.invokeMethod<void>(
                            'SystemNavigator.pop',
                          ),
                          /*Navigator.of(context).pop(true)*/
                          child: Text('Exit'),
                        ),
                      ],
                    ),
                  ) ??
                  false;

              // Navigator.pushReplacementNamed(context, "Login");
            },
            child: SingleChildScrollView(
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
                      "img/logo.png",
                      alignment: Alignment.bottomCenter,
                    ),
                  )),
                  // Theme.of(context).primaryColor,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedBuilder(
                  child: LoginBftrAnim(context),
                  animation: _controller,
                  builder: (BuildContext context, Widget child) {
                    return SlideTransition(
                      position: animation,
                      child: child,
                    );
                  },
                ),
              )
            ]))));
  }
}
