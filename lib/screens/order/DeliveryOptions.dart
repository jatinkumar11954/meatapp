import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meatapp/Api/categoryApi.dart';
import 'package:meatapp/adjust/custom_route.dart';
import 'package:meatapp/adjust/short.dart';
import 'package:meatapp/main.dart';
import 'package:meatapp/model/address.dart';
import 'package:meatapp/model/cart.dart';
import 'package:meatapp/screens/order/ChooseAddress.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as hp;
import 'package:flutter/material.dart' as snack;

class DeliveryOptions extends StatelessWidget {
  static const headers = {'Content-Type': 'application/json'};
  hp.Response response;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  List<Map<dynamic, dynamic>> a = List<Map<dynamic, dynamic>>();

  void callSnackBar(String msg) {
    print(msg + "snack msg");
    final Snack = new snack.SnackBar(
      content: new Text(msg),
      duration: new Duration(seconds: 1),
    );
    _scaffoldkey.currentState.showSnackBar(Snack);
  }

  Razorpay r = Razorpay();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    Address def = ModalRoute.of(context).settings.arguments;
    var w = Short.w;
    final appbar = AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      // Color.fromRGBO(191, 32, 37, 1.0),
      title: Padding(
        padding: EdgeInsets.only(left: w * 0.15),
        child: Text("Delivery Options"),
      ),
    );
    print(Short.h.toString());
    print(Short.w.toString());
    return Scaffold(
      appBar: appbar,
      body: Column(
        children: <Widget>[
          Center(
              child: Container(
                  // height: h * 0.17,
                  width: w * 0.9,
                  margin: EdgeInsets.all(15),
                  child: Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Icon(
                                      Icons.location_on,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(" Delivery to: ",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.grey)),
                                  Spacer(),
                                  FlatButton(
                                      onPressed: () => Navigator.of(context)
                                              .pushReplacement(CustomRoute(
                                            builder: (context) =>
                                                ChooseAddress(),
                                          )),
                                      child: Text("Change",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Theme.of(context)
                                                  .primaryColor)))
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 30.0, right: 15, bottom: 25),
                                child:
                                    // Text("Cupidatat amet oc officia quis aliquip ipsum fugiat ut sint.",
                                    Text("${def.value}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey)),
                              ),
                            ]),
                      )))

              //rzp_test_GlkT86sBpHZqRH,KL6Y8oP2O5cmgHfBriyQJznC

              ),
          Center(
              child: Container(
                  // height: h * 0.17,
                  width: w * 0.9,
                  margin: EdgeInsets.all(15),
                  child: Card(
                      elevation: 10,
                      child: Padding(
                        padding: EdgeInsets.all(25),
                        child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Default Delivery \nOption",
                                      style: TextStyle(
                                          fontSize: w * 0.038,
                                          color: Colors.black)),
                                  Spacer(),
                                  Text("1 Shipment\nDelivery Charges Rs.50",
                                      softWrap: true,
                                      style: TextStyle(
                                          fontSize: w * 0.038,
                                          color: Colors.black)),
                                ],
                              ),
                            ]),
                      )))

              //rzp_test_GlkT86sBpHZqRH,KL6Y8oP2O5cmgHfBriyQJznC

              ),
          Center(
              child: Container(
                  color: Colors.grey[300],
                  // height: h * 0.17,
                  width: w * 0.9,
                  margin: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 20, right: 15),
                        child: Text("Select your delivery slot time",
                            style: TextStyle(
                                fontSize: w * 0.038,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20, left: 15, right: 15, bottom: 20),
                        child: Card(
                            elevation: 10,
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Icon(Icons.access_time),
                                        Text(" Today 2:00 P.M - 4:00 P.M",
                                            softWrap: true,
                                            style: TextStyle(
                                                fontSize: w * 0.038,
                                                color: Colors.black)),
                                        Spacer(),
                                        Icon(Icons.arrow_drop_down, size: 40)
                                      ],
                                    ),
                                  ]),
                            )),
                      ),
                    ],
                  ))

              //rzp_test_GlkT86sBpHZqRH,KL6Y8oP2O5cmgHfBriyQJznC

              ),
        ],
      ),
      floatingActionButton: Container(
        width: w * 0.92,
        height: 50.0,
        color: Theme.of(context).primaryColor,
        child: new RawMaterialButton(
            onPressed: () async {
              _handlePaymentSuccess(PaymentSuccessResponse response) async {
                // String selectedPlan=global.subPlan;
                // Fluttertoast.showToast(
                //   msg: "SUCCESS: " + response.paymentId,
                // );
                cart.items.forEach((element) {
                  a.add(element.toOrder());
                });

                Map<dynamic, dynamic> order = Map<dynamic, dynamic>();

                order = {
                  "cust_id": userdetails.custId,
                  "order": a,
                  "totalPrice": cart.totalAmount.toStringAsFixed(2)
                };
                try {
                  callSnackBar("Placing Order");
                  await Future.delayed(Duration(milliseconds: 1000));
                  response = await hp.post('${Short.baseUrl}/orders',
                      headers: headers, body: json.encode(order));

                  if (response != null) {
                    Map res = json.decode(response.body);
                    if (response.statusCode == 200) {
                      print("inside response status");
                      await callSnackBar("Order Placed Successfully 🎉🎉🎉");
                      await Future.delayed(Duration(milliseconds: 2000));

                      cart.endLoading();
                      productProvider.removeAll();
                      cart.clear();
                      cart.removeAll();

                      Navigator.pushReplacementNamed(context, "Main");
                    }
                    if (response.statusCode == 400) {
                      callSnackBar("${res["msg"]}");
                      cart.endLoading()();

                      print("error with phone number");
                    }
                  } //response is not null
                } on Exception catch (e) {
                  print("exception from   $e");
                  cart.endLoading();

                  callSnackBar("Check your Internet Connection");
                } catch (error) {
                  print("error from api");
                  cart.endLoading();

                  callSnackBar(error.toString());
                }

                print("success");
                print(response.paymentId);
                r.clear();
              }

              void _handlePaymentError(PaymentFailureResponse response) {
                // Fluttertoast.showToast(
                //   msg: "ERROR: " +
                //       response.code.toString() +
                //       " - " +
                //       response.message,
                // );
                print(response.message);
              }

              void _handleExternalWallet(ExternalWalletResponse response) {
                print(response.walletName);
              }

              print("Just came to opencheckout function");

              var json = {
                'key': 'rzp_test_GlkT86sBpHZqRH',
                'currency': "INR",
                'amount': 110, //in the smallest currency sub-unit.
                'name': 'FreshMeat',
                //'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
                'description': 'cart payment',
                'prefill': {
                  'contact': '+91' + userdetails.phoneNo.toString(),
                  'email': userdetails.email
                }
              };

              try {
                print("Trying to go to razorpay");
                r.open(json);
                r.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);

                r.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
                r.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
              } catch (e) {
                print(e.toString());
                debugPrint(e);
              }
            },
            shape: new CircleBorder(),
            elevation: 0.0,
            child: ListTile(
              title: Center(
                child: Text("PROCEED TO PAY",
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            )),
      ),
    );
  }
}
