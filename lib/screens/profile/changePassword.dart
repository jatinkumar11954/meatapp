import 'package:flutter/material.dart';
import 'package:meatapp/adjust/bottomNavigation.dart';
import 'package:meatapp/adjust/short.dart';
import 'package:meatapp/adjust/widget.dart';
import 'package:meatapp/details/userDetails.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>(debugLabel: "key1");
  bool nameTap = false, emailTap = false;
  TextEditingController email;
  TextEditingController name;
  @override
  void initState() {
    // TODO: implement initState
    email = new TextEditingController();
    name = new TextEditingController();

    super.initState();
  }

  void dispose() {
    super.dispose();
    email.dispose();
    name.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserDetails user = ModalRoute.of(context).settings.arguments;
    final appbar = AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      // Color.fromRGBO(191, 32, 37, 1.0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Manage Profile"),
        ],
      ),
    );
    // String pwd = "*";
    // int len = user.password.length;
    // for (int i = 0; i < len - 1; i++) {
    //   pwd = pwd + "*";
    // }
    print(Short.h.toString());
    print(Short.w.toString());
    var h = Short.h - appbar.preferredSize.height;
    var w = Short.w;

    return Scaffold(
        appBar: appbar,
        bottomNavigationBar: bottomBar(context, 2),
        drawer: Draw(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 18.0, left: 20, right: 20),
            child: Form(
              key: _formKey,
              child:Card() )))
      
    );
  }
}