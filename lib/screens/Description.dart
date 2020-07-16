import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:meatapp/Api/categoryApi.dart';
import 'package:meatapp/adjust/badge.dart';
import 'package:meatapp/adjust/bottomNavigation.dart';
import 'package:meatapp/adjust/custom_route.dart';
import 'package:meatapp/adjust/short.dart';
import 'package:meatapp/adjust/widget.dart';
import 'package:meatapp/main.dart';
import 'package:meatapp/model/bottom.dart';
import 'package:meatapp/model/cart.dart';
import 'package:meatapp/model/subCategory.dart';
import 'package:provider/provider.dart';

import 'cart_screen.dart';

class Description extends StatefulWidget {
  String catName;
  Description({this.catName});
  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<Products>(context);

    final cart = Provider.of<Cart>(context, listen: false);
    final bottom = Provider.of<Bottom>(context, listen: false);

    final product = Provider.of<Products>(context, listen: false).items;
        final categoryList = Provider.of<Category>(context, listen: false).categoryList;


    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    final i = ModalRoute.of(context).settings.arguments;
    int ro = categoryList.indexWhere((ele) {
      return ele.categoryName == widget.catName;
    });
    Short().init(context);

    var w = Short.w;
    final appbar = AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).primaryColor,
      titleSpacing: 0,

      title: Stack(children: <Widget>[
        Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context))),
        Align(
          widthFactor: 2.3,
          alignment: Alignment.center,
          child: IconButton(
              icon: new Icon(Icons.view_headline),
              onPressed: () {
                print(
                    "drawer loremLabore duis Lorem id veniam id eu eiusmod dolor dolor eu culpa irure.");
                _scaffoldKey.currentState.openDrawer();
              }),
        ),
        Positioned(
            left: 80,
            top: 10,
            child: SizedBox(
              width: w * 0.83,
              child:
                  // Text("Desc"),.replaceFirst(product[ro][i].item[0],
                  Text(product[ro][i].item.replaceFirst(
                      product[ro][i].item[0],
                      product[ro][i]
                          .item[0]
                          .toUpperCase())), //testing uncomment
            )),
      ]),

      // Image.asset(
      //   'images/logo.png',
      //   fit: BoxFit.fill,
      //   height: Short.h * 4.5,
      // ),
    );
    print(Short.h.toString());
    print(Short.w.toString());
    var h = Short.h - appbar.preferredSize.height;

    return Scaffold(
        key: _scaffoldKey,
        appBar: appbar,
        drawer: Draw(context),
        // bottomNavigationBar: isLogin
        //     ? bottomBar(context, 2)
        //     : SizedBox(), //testing remove afterwards
        body: ListView(
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Hero(
                  tag: i,
                  child: Image.network(
                    product[ro][i].img,
                    fit: BoxFit.fill,
                    width: w * 0.98,
                    height: h * 0.4,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5, top: 25, left: 17),
              child: ListTile(
                  title: Text(product[ro][i].desc,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: h * 0.03,
                          fontWeight: FontWeight.w500)),
                  subtitle: Text(
                    product[ro][i].weight == null
                        ? "weigth"
                        : product[ro][i].weight.toString(),
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: h * 0.02,
                        fontWeight: FontWeight.w400),
                  )),
            ),
            Divider(thickness: 4),
            Padding(
              padding: EdgeInsets.only(
                  bottom: 10, top: 25, left: 25, right: w * 0.55),
              child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Center(
                      child: Text("Weight: 400-500",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: h * 0.02,
                              fontWeight: FontWeight.w400)))),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 40, bottom: 30),
              child: Row(
                children: <Widget>[
                  Text("339 ",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: h * 0.03,
                        decoration: TextDecoration.lineThrough,
                      )),
                  Text(
                      product[ro][i].weight == null
                          ? " price"
                          : "  ${product[ro][i].price}",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: h * 0.035,
                      )),
                ],
              ),
            ),
            Divider(thickness: 4),
            product[ro][i].quantity > 0
                ? Container(
                    width: w * 0.5,
                    height: 60,
                    margin: EdgeInsets.fromLTRB(25, 25, w * 0.5, 25),
                    // padding:
                    //     EdgeInsets.all(
                    //         2),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2, color: Theme.of(context).primaryColor)),

                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.remove_circle,
                                  size: 40,
                                  color: Theme.of(context).primaryColor),
                              onPressed: () {
                                if (product[ro][i].quantity == 1) {
                                  cart.removeItem(CartItem(
                                      id: product[ro][i].id,
                                      price: product[ro][i].price,
                                      quantity: product[ro][i].quantity,
                                      title: product[ro][i].item,
                                      img: product[ro][i].img,
                                      catName: product[ro][i].catname,
                                      weight: product[ro][i].weight,
                                      column: i));

                                  // print(cart.items
                                  //     .length);
                                }
                                cart.reduceQuant(CartItem(
                                    id: product[ro][i].id,
                                    price: product[ro][i].price,
                                    quantity: product[ro][i].quantity,
                                    title: product[ro][i].item,
                                    img: product[ro][i].img,
                                    catName: product[ro][i].catname,
                                    weight: product[ro][i].weight,
                                    column: i));
                                productProvider.subQuant(
                                    product[ro][i].catname, i);
                              }),
                          SizedBox(
                            width: 15,
                          ),
                          Text(product[ro][i].quantity.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 5,
                          ),
                          IconButton(
                              icon: Icon(Icons.add_circle,
                                  size: 40,
                                  color: Theme.of(context).primaryColor),
                              onPressed: () {
                                cart.addItem(CartItem(
                                    id: product[ro][i].id,
                                    price: product[ro][i].price,
                                    quantity: product[ro][i].quantity,
                                    title: product[ro][i].item,
                                    img: product[ro][i].img,
                                    catName: product[ro][i].catname,
                                    weight: product[ro][i].weight,
                                    column: i));
                                productProvider.addQuant(
                                    product[ro][i].catname, i);
                              }),
                        ],
                      ),
                    ),
                  )
                : GestureDetector(
                    child: Container(
                      width: w * 0.5,
                      margin: EdgeInsets.fromLTRB(25, 25, w * 0.5, 25),
                      padding: EdgeInsets.all(18),
                      color: Colors.grey,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                          Text(
                            "Add to Cart",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      cart.addItem(CartItem(
                          id: product[ro][i].id,
                          price: product[ro][i].price,
                          quantity: 1,
                          title: product[ro][i].item,
                          img: product[ro][i].img,
                          catName: product[ro][i].catname,
                          weight: product[ro][i].weight,
                          column: i));
                      productProvider.addQuant(product[ro][i].catname, i);
                    },
                  ),
            SizedBox(height: 30),
            SizedBox(
              height: 60,
            )
          ],
        ),
        floatingActionButton: isLogin
            ? FloatingActionButton(
                elevation: 4.0,
                onPressed: () {
                  bottom.updateINdex(1);
                  Navigator.push(
                      context, CustomRoute(builder: (c) => CartScreen()));
                },
                child: Consumer<Cart>(
                  builder: (_, cart, ch) => Badge(
                    child: ch,
                    value: cart?.itemCount.toString(),
                    color: Colors.black,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      print("cartscreen");
                      bottom.updateINdex(1);

                      Navigator.push(
                          context, CustomRoute(builder: (c) => CartScreen()));
                    },
                  ),
                ),
                backgroundColor: Theme.of(context).primaryColor,
              )
            : Container(
                width: w * 0.91,
                height: 45.0,
                color: Theme.of(context).primaryColor,
                child: new RawMaterialButton(
                    shape: new CircleBorder(),
                    elevation: 0.0,
                    // child: Theme.of(context).primaryColor,
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, "Login"),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(Icons.arrow_forward, color: Colors.white),
                        Text(" LOGIN/SIGN UP TO CHECKOUT",
                            softWrap: true,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            )),
                      ],
                    ))));
  }
}
