import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as snack;
import 'package:meatapp/adjust/bottomNavigation.dart';
import 'package:meatapp/adjust/custom_route.dart';
import 'package:meatapp/adjust/icons.dart';
import 'package:meatapp/adjust/short.dart';
import 'package:meatapp/adjust/widget.dart';
import 'package:meatapp/details/userDetails.dart';
import 'package:meatapp/model/address.dart';
import 'package:meatapp/screens/address/EditAddress.dart';
import 'package:meatapp/screens/order/DeliveryOptions.dart';
import '../../main.dart';
import 'package:http/http.dart' as hp;

class ChooseAddress extends StatelessWidget {
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
  final headers = {
    'Content-Type': 'application/json',
  };
  List<Address> address;
  Future<List<Address>> getAllAddress() async {
    try {
      print("getting address");
      AddressResponse = await hp.get(
        "${Short.baseUrl}/getaddress?cust_id=${userdetails.custId}",
        headers: headers,
      );

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
          Text("Choose Delivery Address"),
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
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 22.0, bottom: 50),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Center(
                  child: Text("Saved Addresses",
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
                FutureBuilder<List<Address>>(
                    future: getAllAddress(),
                    builder: (context, snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Text("Address",
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
                                      child: Text("Edit",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 18.0),
                                      child: Text("Delete",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                    ),
                                  ])
                            ]);
                      }
                      if (snap.connectionState == ConnectionState.done) {
                        print("done");
                        print(snap.data.length);

                        return Expanded(
                          child: ListView.builder(
                              // shrinkWrap: true,
                              itemCount:
                                  // 5,
                                  snap.data.length,
                              itemBuilder: (context, i) {
                                return Center(
                                  child: Container(
                                    // height: h * 0.17,
                                    // width: w*0.9,
                                    margin: EdgeInsets.all(20),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            CustomRoute(
                                              builder: (context) =>
                                                  DeliveryOptions(),
                                                  settings: RouteSettings(arguments:snap.data[i] )
                                            ));
                                      },
                                      child: i==0?Card(
                                        elevation: 10,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                               Row(children: [
                                            Padding(
                                              padding: EdgeInsets.only(top:8,left:15.0,right:8),
                                              child: Icon(CustomIcon.circle_empty),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top:8.0),
                                              child: Text("Default Address:",
                                                   style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color:
                                                                  Theme.of(context).primaryColor)),
                                            ),
                                          ]),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(18.0),
                                                child:
                                                    // Text("Cupidatat amet oc officia quis aliquip ipsum fugiat ut sint.",
                                                    Padding(
                                                      padding: const EdgeInsets.only(left:26.0),
                                                      child: Text(
                                                          "${snap.data[i].value}",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.grey)),
                                                    ),
                                              ),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 18.0),
                                                      child: FlatButton(
                                                        child: Text("Edit",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor)),
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              CustomRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          EditAddress(),
                                                                  settings: RouteSettings(
                                                                      arguments:
                                                                          user)));
                                                        },
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 18.0),
                                                      child: FlatButton(
                                                        child: Text("Delete",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Theme.of(
                                                                        context)
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
                                      ):Card(
                                        elevation: 10,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                      padding: const EdgeInsets.only(top:28,bottom:15,left:26.0),
                                                child:
                                                    // Text("Cupidatat amet oc officia quis aliquip ipsum fugiat ut sint.",
                                                    Text(
                                                        "${snap.data[i].value}",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color:
                                                                Colors.grey)),
                                              ),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 18.0),
                                                      child: FlatButton(
                                                        child: Text("Edit",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor)),
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              CustomRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          EditAddress(),
                                                                  settings: RouteSettings(
                                                                      arguments:
                                                                          user)));
                                                        },
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 18.0),
                                                      child: FlatButton(
                                                        child: Text("Delete",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Theme.of(
                                                                        context)
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
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
        floatingActionButton: Container(
          width: w * 0.92,
          height: 50.0,
          color: Theme.of(context).primaryColor,
          child: new RawMaterialButton(
              onPressed: () => Navigator.pushReplacement(
                  context,
                  CustomRoute(
                    builder: (context) => EditAddress(
                      type: "addnew",
                    ),
                  )),
              shape: new CircleBorder(),
              elevation: 0.0,
              child: ListTile(
                title: Text("ADD NEW ADDRESS",
                    style: TextStyle(color: Colors.white)),
                leading: Padding(
                  padding: EdgeInsets.only(left: w * 0.15),
                  child: Icon(Icons.add_circle, color: Colors.white),
                ),
              )),
        ));
  }
}
