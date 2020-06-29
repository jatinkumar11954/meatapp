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

  void test() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    List<String> sL = s.getStringList("cart");
    print(sL.toString());
  }

  @override
  Widget build(BuildContext context) {
    test();
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
                  print(cart.items.values.toList()[i]);

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
                                  cart.items.values.toList()[i].title.length >=
                                          15
                                      ? 30
                                      : 25,
                              backgroundImage: CachedNetworkImageProvider(
                                cart.items.values.toList()[i].img,
                              ),
                            ),
                          ]),
                          title:
                              //  Text(
                              //   "cart.items.values.toList()[i].title",
                              //   style: TextStyle(
                              //       color: Theme.of(context).primaryColor,
                              //       fontSize: 20),
                              // ),
                              Text(cart.items.values.toList()[i].title,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 20)),
                          subtitle:
                              Wrap(direction: Axis.vertical, children: <Widget>[
                            Text(
                              "${cart.items.values.toList()[i].weight.toString()}",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              '₹${(cart.items.values.toList()[i].price * cart.items.values.toList()[i].quantity)}',
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
                                  cart.items.values.toList()[i].title.length >=
                                          15
                                      ? 25
                                      : 30,
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
                                        if (cart.items.values
                                                .toList()[i]
                                                .quantity ==
                                            1) {
                                          productProvider.subQuant(
                                              cart.items.values
                                                  .toList()[i]
                                                  .catName,
                                              cart.items.values
                                                  .toList()[i]
                                                  .column);
                                          cart.removeItem(
                                              cart.items.values.toList()[i].id);

                                          print(cart.items.length);
                                        }
                                        productProvider.subQuant(
                                            cart.items.values
                                                .toList()[i]
                                                .catName,
                                            cart.items.values
                                                .toList()[i]
                                                .column);
                                        cart.reduceQuant(
                                            cart.items.values.toList()[i].id,
                                            cart.items.values.toList()[i].price,
                                            cart.items.values.toList()[i].title,
                                            cart.items.values.toList()[i].img,
                                            cart.items.values
                                                .toList()[i]
                                                .catName,
                                            cart.items.values
                                                .toList()[i]
                                                .weight,
                                            cart.items.values
                                                .toList()[i]
                                                .column);
                                      }),
                                  Text(
                                      cart.items.values
                                          .toList()[i]
                                          .quantity
                                          .toString(),
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
                                          cart.items.values.toList()[i].catName,
                                          cart.items.values.toList()[i].column);
                                      cart.addItem(
                                          cart.items.values.toList()[i].id,
                                          cart.items.values.toList()[i].price,
                                          cart.items.values.toList()[i].title,
                                          cart.items.values.toList()[i].img,
                                          cart.items.values.toList()[i].catName,
                                          cart.items.values.toList()[i].weight,
                                          cart.items.values.toList()[i].column);
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    iconSize: 35,
                                    onPressed: () {
                                      productProvider.removeFrmCart(
                                          cart.items.values.toList()[i].catName,
                                          cart.items.values.toList()[i].column);
                                      cart.removeItem(
                                          cart.items.values.toList()[i].id);
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
