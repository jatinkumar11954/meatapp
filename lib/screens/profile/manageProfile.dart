import 'package:flutter/material.dart';
import 'package:meatapp/adjust/bottomNavigation.dart';
import 'package:meatapp/adjust/short.dart';
import 'package:meatapp/adjust/widget.dart';
import 'package:meatapp/details/userDetails.dart';

class ManageProfile extends StatefulWidget {
  @override
  _ManageProfileState createState() => _ManageProfileState();
}

class _ManageProfileState extends State<ManageProfile> {
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
    String pwd = "*";
    int len = user.password.length;
    for (int i = 0; i < len - 1; i++) {
      pwd = pwd + "*";
    }
    print(pwd);
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
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text("Mobile Number",
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).primaryColor)),
                    subtitle: Text("${user.phoneNo}"),
                    leading: Icon(Icons.phone),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(
                        height: 5, thickness: 3, color: Colors.grey[300]),
                  ),
                  // Expanded(
                  //                       child: Row(
                  //                         mainAxisAlignment: MainAxisAlignment.end,
                  //                         children: <Widget>[
                  //     IconButton(icon: Icon(Icons.email), onPressed:(){}),
                  //                           IconButton(icon: Icon(Icons.email), onPressed:(){})

                  //   ],),
                  // ),
                  ListTile(
                    title: Text("Name",
                        style: TextStyle(
                            // fontSize: 20,
                            color: Theme.of(context).primaryColor)),
                    subtitle: nameTap
                        ? TextFormField(
                          validator: Short().validateName,
                            controller: name,
                            keyboardType: TextInputType.text,

                            decoration: InputDecoration(
                              // hintText: 'Enter Your Email Here...',
                              suffixIcon:
                                  // Expanded(
                                  // child:

                                  IconButton(
                                    tooltip: "to save the name",
                                      icon: Icon(Icons.check_circle),
                                      onPressed: () {
                                      if(  _formKey.currentState.validate())
                                        _formKey.currentState.save();
                                      }),

                              //               ),
                              // Icon(Icons.email),
                              filled: true,
                              fillColor: Colors.white70,
                              // enabledBorder: OutlineInputBorder(
                              // borderRadius: BorderRadius.all(Radius.circular(12.0)),
                              // borderSide: BorderSide(color: Colors.green, width: 2),
                              //  ),
                              // focusedBorder: OutlineInputBorder(
                              // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              // borderSide: BorderSide(color: Colors.green, width: 2),
                              // ),
                            ),
                            onSaved: (newValue) {
                              user.fullName=newValue;
                              
                              setState(() {
                                
                                nameTap=false;
                              });
                            },
                          )
                        : Text("${user.fullName}"),
                    leading: Icon(Icons.account_circle),
                    trailing: Visibility(
                      visible: !nameTap,
                      child: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          setState(() {
                            nameTap = true;
                          });
                        },
                      ),
                      replacement: IconButton(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                          top: 24.0,
                        ),
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          setState(() {
                            nameTap = false;
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(
                        height: 5, thickness: 3, color: Colors.grey[300]),
                  ),
                  ListTile(
                    title: Text("Email",
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).primaryColor)),
                    subtitle: Text("${user.email}"),
                    leading: Icon(Icons.account_circle),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(
                        height: 5, thickness: 3, color: Colors.grey[300]),
                  ),
                  ListTile(
                    title: Text("Password",
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).primaryColor)),
                    subtitle: Text("${pwd}",
                        style: TextStyle(
                          fontSize: 20,
                        )),
                    leading: Icon(Icons.account_circle),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(
                        height: 5, thickness: 3, color: Colors.grey[300]),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
