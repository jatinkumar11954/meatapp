import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as snack;
import 'package:meatapp/adjust/bottomNavigation.dart';
import 'package:meatapp/adjust/custom_route.dart';
import 'package:meatapp/adjust/short.dart';
import 'package:meatapp/adjust/widget.dart';
import 'package:meatapp/details/userDetails.dart';
import 'EditAddress.dart';
import 'package:http/http.dart' as hp;

class ManageAddress extends StatefulWidget {
  @override
  _ManageAddressState createState() => _ManageAddressState();
}

class _ManageAddressState extends State<ManageAddress> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  // @override
  // void initState() {
  //   super.initState();
  //   getAllAddress();
  // }
  void callSnackBar(String msg) {
    print(msg + "snack msg");
    final Snack = new snack.SnackBar(
      content: new Text(msg),
      duration: new Duration(seconds: 3),
    );
    _scaffoldkey.currentState.showSnackBar(Snack);
  }

  hp.Response AddressResponse;
  final headers = {'Content-Type': 'application/json',};
  List<Address> address;
  Future<List<Address>> getAllAddress() async {
    try {
      AddressResponse =
          await hp.get("${Short.baseUrl}/getaddress", headers: headers,);

      if (AddressResponse != null) {
        Map AddressJson = json.decode(AddressResponse.body);
        if (AddressResponse.statusCode == 200) {
          print("inside response status");
          address = (AddressJson['data'] as List)
              .map((item) => new Address.fromJson(item))
              .toList();

          return address;
        }
        if (AddressResponse.statusCode == 400) {
          callSnackBar("${AddressJson["msg"]}");

          print("carousel api bad req");
        }
      } //response is not null

    } on Exception catch (exception) {
      callSnackBar(" $exception");
    } catch (error) {
      callSnackBar(error.toString());
    }
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
          Text("Manage Address"),
        ],
      ),
    );
    print(Short.h.toString());
    print(Short.w.toString());
    var h = Short.h - appbar.preferredSize.height;
    var w = Short.w;
    return Scaffold(
      key: _scaffoldkey,
      appBar: appbar,
      bottomNavigationBar: bottomBar(context, 2),
      drawer: Draw(context),
      body: 
      SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 22.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Addresses",
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        width: w * 0.9,
                        child: Card(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Text("${user.address}",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey)),
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 18.0),
                                        child: FlatButton(
                                          child: Text("Edit",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .primaryColor)),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                CustomRoute(
                                                    builder: (context) =>
                                                        EditAddress(),
                                                    settings: RouteSettings(
                                                        arguments: user)));
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 18.0),
                                        child: FlatButton(
                                          child: Text("Delete",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .primaryColor)),
                                          onPressed: () {
                                            print("delete");
                                            // Navigator.push(
                                            //     context,
                                            //     CustomRoute(
                                            //         builder: (context) => EditAddress()
                                            // ,settings:RouteSettings(arguments:user)
                                          },
                                        ),
                                      ),
                                    ])
                              ]),
                        )),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: h * 0.5),
                  child: Container(
                    width: w * 0.82,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {},
                      child: Center(
                          child: ListTile(
                        title: Text("ADD NEW ADDRESS",
                            style: TextStyle(color: Colors.white)),
                        leading: Icon(Icons.add_circle, color: Colors.white),
                      )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
  
      // SingleChildScrollView(
      //   child: Center(
      //     child: Padding(
      //       padding: const EdgeInsets.only(top: 22.0),
      //       child: ListView(
      //         shrinkWrap: true,
      //         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: <Widget>[
      //           Text("Addresses",
      //               style: TextStyle(
      //                   fontSize: 23,
      //                   fontWeight: FontWeight.bold,
      //                   color: Theme.of(context).primaryColor)),
      //           FutureBuilder<List<Address>>(
      //               future: getAllAddress(),
      //               builder: (context, snapshot) {
      //                 if (snapshot.connectionState == ConnectionState.waiting) {
      //                   return Container(
      //                     child: Column(
      //                         crossAxisAlignment: CrossAxisAlignment.start,
      //                         children: <Widget>[
      //                           Padding(
      //                             padding: const EdgeInsets.all(18.0),
      //                             child: Text("Address",
      //                                 style: TextStyle(
      //                                     fontSize: 22,
      //                                     fontWeight: FontWeight.bold,
      //                                     color: Colors.grey)),
      //                           ),
      //                           Row(
      //                               mainAxisAlignment:
      //                                   MainAxisAlignment.spaceBetween,
      //                               children: <Widget>[
      //                                 Padding(
      //                                   padding:
      //                                       const EdgeInsets.only(left: 18.0),
      //                                   child: Text("Edit",
      //                                       style: TextStyle(
      //                                           fontSize: 18,
      //                                           fontWeight: FontWeight.bold,
      //                                           color: Theme.of(context)
      //                                               .primaryColor)),
      //                                 ),
      //                                 Padding(
      //                                   padding:
      //                                       const EdgeInsets.only(right: 18.0),
      //                                   child: Text("Delete",
      //                                       style: TextStyle(
      //                                           fontSize: 18,
      //                                           fontWeight: FontWeight.bold,
      //                                           color: Theme.of(context)
      //                                               .primaryColor)),
      //                                 ),
      //                               ])
      //                         ]),
      //                   );
      //                 }
      //                 if (snapshot.connectionState == ConnectionState.done) {
      //                   print("done");
      //                   return ListView.builder(
      //                       shrinkWrap: true,
      //                       itemCount: 1,
      //                       itemBuilder: (context, i) {
      //                         return Container(
      //                           height: h * 0.2,
      //                           child: Card(
      //                             elevation: 10,
      //                             child: Column(
      //                                 crossAxisAlignment:
      //                                     CrossAxisAlignment.start,
      //                                 children: <Widget>[
      //                                   Padding(
      //                                     padding: const EdgeInsets.all(18.0),
      //                                     child: Text("${user.address}",
      //                                         style: TextStyle(
      //                                             fontSize: 22,
      //                                             fontWeight: FontWeight.bold,
      //                                             color: Colors.grey)),
      //                                   ),
      //                                   Row(
      //                                       mainAxisAlignment:
      //                                           MainAxisAlignment.spaceBetween,
      //                                       children: <Widget>[
      //                                         Padding(
      //                                           padding: const EdgeInsets.only(
      //                                               left: 18.0),
      //                                           child: FlatButton(
      //                                             child: Text("Edit",
      //                                                 style: TextStyle(
      //                                                     fontSize: 18,
      //                                                     fontWeight:
      //                                                         FontWeight.bold,
      //                                                     color: Theme.of(
      //                                                             context)
      //                                                         .primaryColor)),
      //                                             onPressed: () {
      //                                               Navigator.push(
      //                                                   context,
      //                                                   CustomRoute(
      //                                                       builder: (context) =>
      //                                                           EditAddress(),
      //                                                       settings:
      //                                                           RouteSettings(
      //                                                               arguments:
      //                                                                   user)));
      //                                             },
      //                                           ),
      //                                         ),
      //                                         Padding(
      //                                           padding: const EdgeInsets.only(
      //                                               right: 18.0),
      //                                           child: FlatButton(
      //                                             child: Text("Delete",
      //                                                 style: TextStyle(
      //                                                     fontSize: 18,
      //                                                     fontWeight:
      //                                                         FontWeight.bold,
      //                                                     color: Theme.of(
      //                                                             context)
      //                                                         .primaryColor)),
      //                                             onPressed: () {
      //                                               print("delete");
      //                                               // Navigator.push(
      //                                               //     context,
      //                                               //     CustomRoute(
      //                                               //         builder: (context) => EditAddress()
      //                                               // ,settings:RouteSettings(arguments:user)
      //                                             },
      //                                           ),
      //                                         ),
      //                                       ])
      //                                 ]),
      //                           ),
      //                         );
      //                       });
      //                 }
      //               }),
      //           Padding(
      //             padding: EdgeInsets.only(top: h * 0.5),
      //             child: Container(
      //               width: w * 0.82,
      //               child: RaisedButton(
      //                 color: Theme.of(context).primaryColor,
      //                 onPressed: () {},
      //                 child: Center(
      //                     child: ListTile(
      //                   title: Text("ADD NEW ADDRESS",
      //                       style: TextStyle(color: Colors.white)),
      //                   leading: Icon(Icons.add_circle, color: Colors.white),
      //                 )),
      //               ),
      //             ),
      //           )
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}

class Address {
  String value;

  Address({this.value});
  factory Address.fromJson(Map<dynamic, dynamic> json) {
    return Address(value: json["newaddress"]);
  }
}
