import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as snack;

import 'package:meatapp/adjust/bottomNavigation.dart';
import 'package:meatapp/adjust/custom_route.dart';
import 'package:meatapp/adjust/short.dart';
import 'package:meatapp/details/userDetails.dart';
import 'package:meatapp/model/bottom.dart';
import 'package:meatapp/model/subCategory.dart';
import 'package:meatapp/screens/FirestScreen.dart';
import 'package:meatapp/screens/tabScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as hp;

import '../model/cart.dart';

class CartScreen extends StatelessWidget {
  static const headers = {'Content-Type': 'application/json'};
  hp.Response response;
  static const routeName = '/cart';
  var catgry = {
    0: "CHICKEN",
    1: "MUTTON",
    2: "SEA FOOD",
    3: "EGGS",
    4: "DEALS",
  };

  static var chicken = {
    0: "ChickenCurryLeg",
    1: "ChickenCurry",
    2: "ChickenLeg",
    3: "Chicken65",
  };
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  void callSnackBar(String msg) {
    print(msg + "snack msg");
    final Snack = new snack.SnackBar(
      content: new Text(msg),
      duration: new Duration(seconds: 1),
    );
    _scaffoldkey.currentState.showSnackBar(Snack);
  }

  @override
  Widget build(BuildContext context) {
    Short().init(context);
    var w = Short.w;

    final cart = Provider.of<Cart>(context);
    final bottom = Provider.of<Bottom>(context);

    final productProvider = Provider.of<Products>(context);
    List<Map<dynamic, dynamic>> a = List<Map<dynamic, dynamic>>();

    return Scaffold(
        key: _scaffoldkey,
        appBar: AppBar(
          title: Text('Your Cart'),
        ),
        bottomNavigationBar: bottomBar(context, 1),
        body: WillPopScope(
          onWillPop: () {
            bottom.updateINdex(0);
            Navigator.pushReplacement(
                context,
                CustomRoute(
                  builder: (context) => FirstScreen(),
                ));
          },
          child: Column(
            children: <Widget>[
              // Card(
              //   margin: EdgeInsets.all(15),
              //   child: Padding(
              //     padding: EdgeInsets.all(8),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: <Widget>[
              //         Text(
              //           'Total',
              //           style: TextStyle(fontSize: 20),
              //         ),
              //         Spacer(),
              //         Chip(
              //           label: Text(
              //             '₹${cart.totalAmount.toStringAsFixed(2)}',
              //             style: TextStyle(
              //               color: Theme.of(context).primaryTextTheme.title.color,
              //             ),
              //           ),
              //           backgroundColor: Theme.of(context).primaryColor,
              //         ),
              //         FlatButton(
              //           child: Text('ORDER NOW'),
              //           onPressed: () {},
              //           textColor: Theme.of(context).primaryColor,
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                    itemCount: cart.itemCount,
                    itemBuilder: (_, i) {
                      // print(cart.items[i]);

                      return Card(
                          margin: EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 4,
                          ),
                          child: ListTile(
                              isThreeLine: true,
                              leading: Wrap(children: <Widget>[
                                CircleAvatar(
                                  radius: cart.items[i].title.length >= 15
                                      ? 30
                                      : 25,
                                  backgroundImage: CachedNetworkImageProvider(
                                    "http://via.placeholder.com/350x200", //testing

                                    // cart.items[i].img,
                                  ),
                                ),
                              ]),
                              title:
                                  //  Text(
                                  //   "cart.items[i].title",
                                  //   style: TextStyle(
                                  //       color: Theme.of(context).primaryColor,
                                  //       fontSize: 20),
                                  // ),
                                  Text(cart.items[i].title,
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 20)),
                              subtitle: Wrap(
                                  direction: Axis.vertical,
                                  children: <Widget>[
                                    Text(
                                      "${cart.items[i].weight.toString()}",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                    Text(
                                      '₹${(cart.items[i].price * cart.items[i].quantity)}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                  ]),
                              trailing: FittedBox(
                                alignment: Alignment.bottomCenter,
                                // width: 152,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      0,
                                      cart.items[i].title.length >= 15
                                          ? 25
                                          : 30,
                                      0,
                                      0),
                                  child: Wrap(
                                    runSpacing: 1,
                                    alignment: WrapAlignment.spaceAround,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: <Widget>[
                                      IconButton(
                                          icon: Icon(Icons.remove_circle,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          iconSize: 35,
                                          onPressed: () {
                                            if (cart.items[i].quantity == 1) {
                                              productProvider.subQuant(
                                                  cart.items[i].catName,
                                                  cart.items[i].column);
                                              cart.removeItem(cart.items[i]);

                                              print(cart.items.length);
                                            } else {
                                              productProvider.subQuant(
                                                  cart.items[i].catName,
                                                  cart.items[i].column);
                                              cart.reduceQuant(CartItem(
                                                  id: cart.items[i].id,
                                                  price: cart.items[i].price,
                                                  quantity:
                                                      cart.items[i].quantity,
                                                  title: cart.items[i].title,
                                                  img: cart.items[i].img,
                                                  catName:
                                                      cart.items[i].catName,
                                                  weight: cart.items[i].weight,
                                                  column:
                                                      cart.items[i].column));
                                            }
                                          }),
                                      Text(cart.items[i].quantity.toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold)),
                                      IconButton(
                                        icon: Icon(Icons.add_circle,
                                            color:
                                                Theme.of(context).primaryColor),
                                        iconSize: 35,
                                        onPressed: () {
                                          productProvider.addQuant(
                                              cart.items[i].catName,
                                              cart.items[i].column);
                                          cart.addItem(CartItem(
                                              id: cart.items[i].id,
                                              price: cart.items[i].price,
                                              quantity: cart.items[i].quantity,
                                              title: cart.items[i].title,
                                              img: cart.items[i].img,
                                              catName: cart.items[i].catName,
                                              weight: cart.items[i].weight,
                                              column: cart.items[i].column));
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        iconSize: 35,
                                        onPressed: () {
                                          productProvider.removeFrmCart(
                                              cart.items[i].catName,
                                              cart.items[i].column);
                                          // cart.removeAll();///testing
                                          cart.removeItem(cart.items[i]);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              )));
                    }),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(18.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: <Widget>[
              //       Text(
              //         'Total',
              //         style: TextStyle(fontSize: 20),
              //       ),
              //       Spacer(),
              //       Chip(
              //         label: Text(
              //           '₹${cart.totalAmount.toStringAsFixed(2)}',
              //           style: TextStyle(
              //             color: Theme.of(context).primaryTextTheme.title.color,
              //           ),
              //         ),
              //         backgroundColor: Theme.of(context).primaryColor,
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
        floatingActionButton: Container(
            width: w * 0.92,
            height: 50.0,
            color: Theme.of(context).primaryColor,
            child: new RawMaterialButton(
                shape: new CircleBorder(),
                elevation: 0.0,
                child: cart.items.isEmpty
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              CustomRoute(
                                  builder: (context) => TabScreen(),
                                  settings: RouteSettings(arguments: 0)));
                        },
                        child: Text("Add few Items",
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                      )
                    : cart.isLoading
                        ? CircularProgressIndicator()
                        : Row(
                            children: <Widget>[
                              Container(
                                width: w * 0.28,
                                height: 50.0,
                                color: Color.fromRGBO(8, 108, 86, 1),
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(width: 6),
                                    Icon(Icons.shopping_cart,
                                        color: Colors.white),
                                    SizedBox(width: 2),
                                    Text(
                                        // "45555165.00",
                                        '₹${cart.totalAmount.toStringAsFixed(1)}',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.white))
                                  ],
                                ),
                              ),
                              Spacer(),
                              Text("CHECKOUT",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                              SizedBox(
                                width: 8,
                              ),
                              Icon(
                                Icons.check_circle,
                                color: Colors.white,
                                size: 32,
                              ),
                              SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                onPressed: (cart.items.isEmpty)
                    ? () {
                        bottom.updateTab(0);
                        Navigator.push(
                            context,
                            CustomRoute(
                                builder: (context) => TabScreen(),
                                settings: RouteSettings(arguments: 0)));
                      }
                    : () async {
                        cart.items.forEach((element) {
                          a.add(element.toOrder());
                        });
                        print(a.toString());
                        SharedPreferences store =
                            await SharedPreferences.getInstance();

                        print("getting jwt from the device");
                        String token = store.getString('jwt');
                        if (token != null) {
                          Map jwt = json.decode(ascii
                              .decode(base64.decode(base64.normalize(token))));
                          UserDetails user = UserDetails.fromJson(jwt["data"]);
                          Map<dynamic, dynamic> order = Map<dynamic, dynamic>();

                          order = {
                            "cust_id": user.custId,
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
                                await callSnackBar(
                                    "Order Placed Successfully 🎉🎉🎉");
                                await Future.delayed(
                                    Duration(milliseconds: 2000));

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
                        }
                      })));
  }
}
