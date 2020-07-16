import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:meatapp/Api/categoryApi.dart';
import 'package:meatapp/adjust/badge.dart';
import 'package:meatapp/adjust/custom_route.dart';
import 'package:meatapp/adjust/icons.dart';
import 'package:meatapp/adjust/short.dart';
import 'package:meatapp/adjust/short.dart' as soty;

import 'package:meatapp/adjust/widget.dart';
import 'package:meatapp/model/bottom.dart';
import 'package:meatapp/model/cart.dart';
import 'package:meatapp/model/subCategory.dart';
import 'package:meatapp/screens/Description.dart';
import 'package:meatapp/screens/FirestScreen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swipe_gesture_recognizer/swipe_gesture_recognizer.dart';

import '../main.dart';
import 'cart_screen.dart';

class TabScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Products>(context, listen: false).items;
    final categoryList =
        Provider.of<Category>(context, listen: false).categoryList;

    final productProvider = Provider.of<Products>(context);

    final cart = Provider.of<Cart>(context, listen: false);

    final index = ModalRoute.of(context).settings.arguments;
    Short().init(context);
    final tabProvider = Provider.of<Bottom>(context);

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
              onPressed: () {
                tabProvider.updateINdex(0);
                Navigator.pushReplacement(
                    context,
                    CustomRoute(
                      builder: (context) => FirstScreen(),
                    ));
              },
            )),
        Align(
          widthFactor: 2.3,
          alignment: Alignment.center,
          child: IconButton(
              icon: new Icon(Icons.view_headline),
              onPressed: () {
                print("  drawer");
                _scaffoldKey.currentState.openDrawer();
              }),
        ),
        Positioned(
            left: 80,
            top: 10,
            child: SizedBox(
              width: w * 0.83,
              child: Text("Fresh Meat"),
              // Text(Short.catgry[index]),
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

    return DefaultTabController(
      initialIndex: index,
      length: 4,
      child: Builder(builder: (context) {
        return new Scaffold(
          key: _scaffoldKey,
          appBar: appbar,
          drawer: Draw(context),
          body: WillPopScope(
            onWillPop: () {
              tabProvider.updateINdex(0);
              Navigator.pushReplacement(
                  context, CustomRoute(builder: (context) => FirstScreen()));
            },
            child: Center(
              child: TabBarView(
                  children: product.map((o) {
                return SwipeGestureRecognizer(
                  onSwipeLeft: () {
                    print("left");
                    DefaultTabController.of(context).index < catList.length - 1
                        ? DefaultTabController.of(context).animateTo(
                            DefaultTabController.of(context).index + 1,
                            duration: Duration(milliseconds: 700),
                            curve: Curves.easeIn)
                        : print("less than catlist-1 =3");
                    tabProvider
                        .updateTab(DefaultTabController.of(context).index);
                  },
                  onSwipeRight: () {
                    print("ri8");
                    print(DefaultTabController.of(context).index);
                    DefaultTabController.of(context).index > 0
                        ? DefaultTabController.of(context).animateTo(
                            DefaultTabController.of(context).index - 1,
                            duration: Duration(milliseconds: 700),
                            curve: Curves.easeOut)
                        : print("greater then 0");
                    tabProvider
                        .updateTab(DefaultTabController.of(context).index);
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: o.length,
                        itemBuilder: (ctx, i) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    CustomRoute(
                                        builder: (c) =>
                                            Description(catName: o[i].catname),
                                        settings: RouteSettings(arguments: i))),
                                child: Container(
                                  height: 400,
                                  width: w * 0.87,
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                      color: Colors.black45,
                                      blurRadius: 5.0, // soften the shadow
                                      spreadRadius: 0.7, //extend the shadow
                                      offset: Offset(
                                        1.0, // Move to right 10  horizontally
                                        -1.0, // Move to bottom 10 Vertically
                                      ),
                                    ),
                                  ]),
                                  child: GridTile(
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      imageUrl:
                                          "http://via.placeholder.com/350x200", //testing

                                      //  o[i].img,
                                      width: w * 0.7,
                                      placeholder: (c, s) => Shimmer.fromColors(
                                          baseColor: Colors.grey[400],
                                          highlightColor: Colors.white,
                                          child: Container(
                                            width: w * 0.7,
                                            color: Colors.grey,
                                          )),
                                    ),
                                    footer: Container(
                                      color: Colors.white,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          GridTileBar(
                                            backgroundColor: Colors.white,
                                            title: Text(
                                              o[i].item.replaceFirst(
                                                  o[i].item[0],
                                                  o[i].item[0].toUpperCase()),
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  color: Colors.black),
                                            ),
                                            subtitle: Text(
                                                o[i].pieces.toString(),
                                                style: TextStyle(
                                                    color: Colors.black)),
                                          ),
                                          Divider(
                                            color: Colors.grey,
                                          ),
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                18, 0, 0, 14),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                // Text("Magna anim labore irure non labore incididunt exercitation.",
                                                // softWrap: true,
                                                //     style: TextStyle(
                                                //       color: Colors.black45,
                                                //       fontSize: 18,
                                                //     )),
                                                Text(o[i].desc,
                                                    style: TextStyle(
                                                      color: Colors.black45,
                                                      fontSize: 18,
                                                    )),
                                                Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 10, 0, 14),
                                                    height: 34,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[300],
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                    child: Center(
                                                        child: Text(
                                                            "Weight: 400-500",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54,
                                                                fontSize:
                                                                    h * 0.02,
                                                                fontWeight:
                                                                    FontWeight.w400)))),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text("339 ",
                                                        style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 20,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                        )),
                                                    Text(
                                                        o[i].weight == null
                                                            ? " price"
                                                            : "  ${o[i].price}",
                                                        style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          fontSize: 23,
                                                        )),
                                                    Spacer(),
                                                    o[i].quantity > 0
                                                        ? Row(
                                                            children: <Widget>[
                                                              IconButton(
                                                                  icon: Icon(
                                                                      Icons
                                                                          .remove_circle,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColor),
                                                                  onPressed:
                                                                      () {
                                                                    if (o[i].quantity ==
                                                                        1) {
                                                                      cart.removeItem(CartItem(
                                                                          id: o[i]
                                                                              .id,
                                                                          price: o[i]
                                                                              .price,
                                                                          quantity: o[i]
                                                                              .quantity,
                                                                          title: o[i]
                                                                              .item,
                                                                          img: o[i]
                                                                              .img,
                                                                          catName: o[i]
                                                                              .catname,
                                                                          weight: o[i]
                                                                              .weight,
                                                                          column:
                                                                              i));

                                                                      // print(cart.items
                                                                      //     .length);
                                                                    }
                                                                    cart.reduceQuant(CartItem(
                                                                        id: o[i]
                                                                            .id,
                                                                        price: o[i]
                                                                            .price,
                                                                        quantity:
                                                                            o[i]
                                                                                .quantity,
                                                                        title: o[i]
                                                                            .item,
                                                                        img: o[i]
                                                                            .img,
                                                                        catName:
                                                                            o[i]
                                                                                .catname,
                                                                        weight: o[i]
                                                                            .weight,
                                                                        column:
                                                                            i));
                                                                    productProvider
                                                                        .subQuant(
                                                                            o[i].catname,
                                                                            i);
                                                                  }),
                                                              Text(
                                                                  o[i]
                                                                      .quantity
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                              IconButton(
                                                                  icon: Icon(
                                                                      Icons
                                                                          .add_circle,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColor),
                                                                  onPressed:
                                                                      () {
                                                                    cart.addItem(CartItem(
                                                                        id: o[i]
                                                                            .id,
                                                                        price: o[i]
                                                                            .price,
                                                                        quantity:
                                                                            o[i]
                                                                                .quantity,
                                                                        title: o[i]
                                                                            .item,
                                                                        img: o[i]
                                                                            .img,
                                                                        catName:
                                                                            o[i]
                                                                                .catname,
                                                                        weight: o[i]
                                                                            .weight,
                                                                        column:
                                                                            i));
                                                                    productProvider
                                                                        .addQuant(
                                                                            o[i].catname,
                                                                            i);
                                                                  }),
                                                            ],
                                                          )
                                                        : isLogin
                                                            ? GestureDetector(
                                                                child:
                                                                    Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          bottom:
                                                                              5),
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              8),
                                                                  color: Colors
                                                                      .grey,
                                                                  child: Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Icon(
                                                                        Icons
                                                                            .shopping_cart,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      Text(
                                                                        "Add to Cart",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                onTap: () {
                                                                  cart.addItem(CartItem(
                                                                      id: o[i]
                                                                          .id,
                                                                      price: o[
                                                                              i]
                                                                          .price,
                                                                      quantity:
                                                                          1,
                                                                      title: o[
                                                                              i]
                                                                          .item,
                                                                      img: o[
                                                                              i]
                                                                          .img,
                                                                      catName: o[
                                                                              i]
                                                                          .catname,
                                                                      weight: o[
                                                                              i]
                                                                          .weight,
                                                                      column:
                                                                          i));
                                                                  productProvider
                                                                      .addQuant(
                                                                          o[i].catname,
                                                                          i);
                                                                },
                                                              )
                                                            : SizedBox(),
                                                    isLogin
                                                        ? Consumer<Products>(
                                                            builder: (ctx,
                                                                produc, ch) {
                                                              return Container(
                                                                width: 45,
                                                                height: 40,
                                                                margin: EdgeInsets
                                                                    .fromLTRB(
                                                                        8,
                                                                        0,
                                                                        14,
                                                                        5),
                                                                decoration:
                                                                    BoxDecoration(
                                                                        border:
                                                                            Border.all(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                )),
                                                                child: Center(
                                                                  child:
                                                                      IconButton(
                                                                    iconSize:
                                                                        30,
                                                                    icon: Icon(
                                                                      o[i].fav
                                                                          ? Icons
                                                                              .favorite
                                                                          : Icons
                                                                              .favorite_border,
                                                                    ),
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                    onPressed:
                                                                        () {
                                                                      produc.toggleFavoriteStatus(
                                                                          o[i].catname,
                                                                          i);
                                                                      ch =
                                                                          CircularProgressIndicator();
                                                                    },
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          )
                                                        : SizedBox(),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )),
                );
              }).toList()),
            ),
          ),
          bottomNavigationBar: TabBar(
              labelPadding: EdgeInsets.all(0),
              labelColor: Colors.white,
              dragStartBehavior: DragStartBehavior.start,
              // selectedFontSize: 0,

              indicatorSize: TabBarIndicatorSize.tab,
              isScrollable: true,
              unselectedLabelColor: Theme.of(context).primaryColor,
              // elevation: 20,
              onTap: (value) {
                tabProvider.updateTab(DefaultTabController.of(context).index);
              },
              tabs: catList.map((p) {
                // print(soty.o.value);
                Map<String, Object> iconData = {
                  "${catList[0].categoryName}": CustomIcon.Eggs,
                  "${catList[1].categoryName}": CustomIcon.Chicken,
                  "${catList[2].categoryName}": CustomIcon.Mutton,
                  "${catList[3].categoryName}": CustomIcon.SeaFood
                };
                Color bgColor = Colors.white;
                Color fgColor = Theme.of(context).primaryColor;

                if (p == catList[tabProvider.tabIndex ?? 0]) {
                  bgColor = Theme.of(context).primaryColor;
                } else {
                  bgColor = Colors.white;
                }
                if (p == catList[tabProvider.tabIndex ?? 0]) {
                  fgColor = Colors.white;
                } else {
                  fgColor = Theme.of(context).primaryColor;
                }
                return Container(
                    decoration: BoxDecoration(
                      //      boxShadow:[    BoxShadow(
                      //                  blurRadius: 8.0,
                      // offset: Offset(5.0, 0.0),
                      // color: Colors.black87),
                      //               ],
                      border: Border.all(
                        width: 1,
                        color: Theme.of(context).primaryColor,
                      ),
                      color: bgColor,
                    ),
                    width: w * 0.25,
                    child: Tab(
                      text: "${p.categoryName}",
                      icon: Icon(
                        iconData[p.categoryName],
                        color: fgColor,
                        size: 20,
                      ),
                    ));
              }).toList()),
          backgroundColor: Colors.white,
          floatingActionButton: isLogin
              ? FloatingActionButton(
                  elevation: 4.0,
                  onPressed: () {
                    Navigator.push(
                        context, CustomRoute(builder: (c) => CartScreen()));
                  },
                  child: Consumer<Cart>(
                    builder: (_, cart, ch) => GestureDetector(
                      onTap: () => Navigator.push(
                          context, CustomRoute(builder: (c) => CartScreen())),
                      child: Badge(
                        child: ch,
                        value: cart?.itemCount.toString(),
                        color: Colors.black,
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        print("cartscreen");
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
                      ))),
        );
      }),
    );
  }
}
