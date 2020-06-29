import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meatapp/Api/categoryApi.dart';
import 'package:meatapp/adjust/badge.dart';
import 'package:meatapp/adjust/custom_route.dart';
import 'package:meatapp/adjust/short.dart';
import 'package:meatapp/adjust/short.dart' as soty;

import 'package:meatapp/adjust/widget.dart';
import 'package:meatapp/model/cart.dart';
import 'package:meatapp/model/subCategory.dart';
import 'package:meatapp/screens/Description.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'cart_screen.dart';

class TabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Products>(context, listen: false).items;
    final productProvider = Provider.of<Products>(context);
    final cart = Provider.of<Cart>(context);

    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    final index = ModalRoute.of(context).settings.arguments;
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
      child: new Scaffold(
        key: _scaffoldKey,
        appBar: appbar,
        drawer: Draw(context),
        body: TabBarView(
            children: product.map((o) {
          // print(soty.o.value);
          // print(Short.cat[o.key][1]);
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: o.length,
                itemBuilder: (ctx, i) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
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
                              imageUrl: o[i].img,
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  GridTileBar(
                                    backgroundColor: Colors.white,
                                    title: Text(
                                      o[i].item.replaceFirst(o[i].item[0],
                                          o[i].item[0].toUpperCase()),
                                      style: TextStyle(
                                          fontSize: 22, color: Colors.black),
                                    ),
                                    subtitle: Text(o[i].pieces.toString(),
                                        style: TextStyle(color: Colors.black)),
                                  ),
                                  Divider(
                                    color: Colors.grey,
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(18, 0, 0, 14),
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
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: Center(
                                                child: Text("Weight: 400-500",
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: h * 0.02,
                                                        fontWeight:
                                                            FontWeight.w400)))),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text("339 ",
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 20,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                )),
                                            Text(
                                                o[i].weight == null
                                                    ? " price"
                                                    : "  ${o[i].price}",
                                                style: TextStyle(
                                                  color: Theme.of(context)
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
                                                          onPressed: () {
                                                            if (o[i].quantity ==
                                                                1) {
                                                              cart.removeItem(
                                                                  o[i].id);

                                                              print(cart.items
                                                                  .length);
                                                            }

                                                            productProvider
                                                                .subQuant(
                                                                    o[i].catname,
                                                                    i);
                                                            cart.reduceQuant(
                                                                o[i].id,
                                                                o[i].price,
                                                                o[i].item,
                                                                o[i].img,
                                                                o[i].catname,
                                                                o[i].weight,
                                                                i);
                                                          }),
                                                      Text(
                                                          o[i]
                                                              .quantity
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      IconButton(
                                                          icon: Icon(
                                                              Icons.add_circle,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                          onPressed: () {
                                                            productProvider
                                                                .addQuant(
                                                                    o[i].catname,
                                                                    i);
                                                            cart.addItem(
                                                                o[i].id,
                                                                o[i].price,
                                                                o[i].item,
                                                                o[i].img,
                                                                o[i].catname,
                                                                o[i].weight,
                                                                i);
                                                          }),
                                                    ],
                                                  )
                                                : GestureDetector(
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: 5),
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      color: Colors.grey,
                                                      child: Row(
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons.shopping_cart,
                                                            color: Colors.white,
                                                          ),
                                                          Text(
                                                            "Add to Cart",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      cart.addItem(
                                                          o[i].id,
                                                          o[i].price,
                                                          o[i].item,
                                                          o[i].img,
                                                          o[i].catname,
                                                          o[i].weight,
                                                          i);
                                                      productProvider.addQuant(
                                                          o[i].catname, i);
                                                    },
                                                  ),
                                            Consumer<Products>(
                                              builder: (ctx, produc, ch) {
                                                return Container(
                                                  width: 45,
                                                  height: 40,
                                                  margin: EdgeInsets.fromLTRB(
                                                      8, 0, 14, 5),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  )),
                                                  child: Center(
                                                    child: IconButton(
                                                      iconSize: 30,
                                                      icon: Icon(
                                                        o[i].fav
                                                            ? Icons.favorite
                                                            : Icons
                                                                .favorite_border,
                                                      ),
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      onPressed: () {
                                                        produc
                                                            .toggleFavoriteStatus(
                                                                o[i].catname,
                                                                i);
                                                        ch =
                                                            CircularProgressIndicator();
                                                      },
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
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
                        onTap: () => Navigator.push(
                          context,
                          CustomRoute(
                              builder: (c) =>
                                  Description(catName: o[i].catname),
                              settings: RouteSettings(arguments: i)),
                        ),
                      ),
                    ),
                  );
                },
              ));
        }).toList()),
        //     new Container(
        //       color: Colors.yellow,
        //     ),

        //     // new Container(color: Colors.orange,),
        //     new Container(
        //       color: Colors.lightGreen,
        //     ),
        //     new Container(
        //       color: Colors.red,
        //     ),
        //   ],
        // ),
        bottomNavigationBar: new TabBar(
          tabs: Short.icon.entries.map((p) {
            // print(soty.o.value);
            print("this is p value${p}");
            return Container(
              color: Colors.white,
              child: Tab(
                  text: "${Short.catgry[p.key]}",
                  icon: Icon(Short.icon[p.key])),
            );
          }).toList(),
          //      [

          //  Tab(text: "Add",icon: Icon(Icons.home)),
          //         Tab(text: "Add",icon: Icon(Icons.rss_feed)),

          //  Tab(text: "Add",icon: Icon(Icons.panorama_fish_eye)),

          //  Tab(text: "Add",icon: Icon(Icons.settings)),

          //       // new Icon(Icons.home),
          //       // new Icon(Icons.rss_feed),
          //       // new Icon(Icons.perm_identity),
          //       // new Icon(Icons.settings),
          //     ],
          labelColor: Colors.black,
          unselectedLabelColor: Theme.of(context).primaryColor,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: Colors.grey,
          indicatorWeight: 1,
        ),
        backgroundColor: Colors.white,

        floatingActionButton: FloatingActionButton(
          elevation: 4.0,
          onPressed: () {
            // Add your onPressed code here!
          },
          child: Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
              color: Colors.black,
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context, CustomRoute(builder: (c) => CartScreen()));
              },
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
