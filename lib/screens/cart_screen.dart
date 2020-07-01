import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meatapp/adjust/bottomNavigation.dart';
import 'package:meatapp/model/subCategory.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/cart.dart';

class CartScreen extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final productProvider = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      bottomNavigationBar: bottomBar(context, 1),
      body: Column(
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
                              radius:
                                  cart.items[i].title.length >= 15 ? 30 : 25,
                              backgroundImage: CachedNetworkImageProvider(
                                                                              "http://via.placeholder.com/350x200",//testing

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
                          subtitle:
                              Wrap(direction: Axis.vertical, children: <Widget>[
                            Text(
                              "${cart.items[i].weight.toString()}",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              '₹${(cart.items[i].price * cart.items[i].quantity)}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ]),
                          trailing: FittedBox(
                            alignment: Alignment.bottomCenter,
                            // width: 152,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                  0,
                                  cart.items[i].title.length >= 15 ? 25 : 30,
                                  0,
                                  0),
                              child: Wrap(
                                runSpacing: 1,
                                alignment: WrapAlignment.spaceAround,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                      icon: Icon(Icons.remove_circle,
                                          color:
                                              Theme.of(context).primaryColor),
                                      iconSize: 35,
                                      onPressed: () {
                                        if (cart.items[i].quantity == 1) {
                                          productProvider.subQuant(
                                              cart.items[i].catName,
                                              cart.items[i].column);
                                          cart.removeItem(cart.items[i]);

                                          print(cart.items.length);
                                        }
                                        productProvider.subQuant(
                                            cart.items[i].catName,
                                            cart.items[i].column);
                                                cart.reduceQuant(CartItem(
                                          id: cart.items[i].id,
                                          price: cart.items[i].price,
                                          quantity: cart.items[i].quantity,
                                          title: cart.items[i].title,
                                          img: cart.items[i].img,
                                          catName: cart.items[i].catName,
                                          weight: cart.items[i].weight,
                                          column: cart.items[i].column));
                                 
                                      }),
                                  Text(cart.items[i].quantity.toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold)),
                                  IconButton(
                                    icon: Icon(Icons.add_circle,
                                        color: Theme.of(context).primaryColor),
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
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Total',
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                Chip(
                  label: Text(
                    '₹${cart.totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Theme.of(context).primaryTextTheme.title.color,
                    ),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
