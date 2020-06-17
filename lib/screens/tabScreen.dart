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
                            height: 300,
                            width: w * 0.8,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5.0, // soften the shadow
                                spreadRadius: 1.0, //extend the shadow
                                offset: Offset(
                                  5.0, // Move to right 10  horizontally
                                  5.0, // Move to bottom 10 Vertically
                                ),
                              ),
                            ]),
                            child: GridTile(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(minHeight: 180),
                                child: Image.network(
                                  o[i].img,
                                  height: 150,
                                  width: w * 0.8,
                                  alignment: Alignment.topCenter,
                                  errorBuilder: (BuildContext contet, Object ex,
                                      StackTrace stackTrace) {
                                    if (stackTrace == null) return ex;
                                    return Shimmer.fromColors(
                                        baseColor: Colors.grey[400],
                                        highlightColor: Colors.white,
                                        child: Container(
                                          height: 202,
                                          width: w * 0.7,
                                          color: Colors.grey,
                                        ));
                                  },
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Shimmer.fromColors(
                                        baseColor: Colors.grey[400],
                                        highlightColor: Colors.white,
                                        child: Container(
                                          height: 202,
                                          width: w * 0.7,
                                          color: Colors.grey,
                                        ));
                                  },
                                ),
                              ),
                              footer: Container(
                        color: Colors.white,
                                child: Column(
                                  children: <Widget>[
                                    GridTileBar(
                                        backgroundColor: Colors.white,
                                        title: Text(o[i].item,
                                            style:
                                                TextStyle(color: Colors.black))),
                                    Row(
                                      mainAxisAlignment:
                                       MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(o[i].desc),
                                        Spacer(),
                                        o[i].quantity > 0
                                            ? Row(
                                                children: <Widget>[
                                                  IconButton(
                                                      icon: Icon(
                                                          Icons.remove_circle,color:Theme.of(context).primaryColor),
                                                      onPressed: () {
                                                            if(o[i].quantity==1){        
                                                                  cart.removeItem(o[i].id);

                                                                  print(cart.items.length);
                                                                  }

                                                         productProvider.subQuant(
                                                      o[i].catname, i);
                                                      cart.reduceQuant(o[i].id, o[i].price, o[i].item,
                                                            o[i].catname,
                                                            i);
                                                      }),
                                                  Text(o[i].quantity.toString(),style:TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                                                  IconButton(
                                                      icon:
                                                          Icon(Icons.add_circle,color:Theme.of(context).primaryColor),
                                                      onPressed: () {
                                                        productProvider.addQuant(
                                                            o[i].catname, i);
                                                        cart.addItem(
                                                            o[i].id,
                                                            o[i].price,
                                                            o[i].item,
                                                            o[i].catname,
                                                            i);
                                                      }),
                                                ],
                                              )
                                            : IconButton(
                                                icon: Icon(
                                                  Icons.shopping_cart,
                                                ),
                                                onPressed: () {
                                                  cart.addItem(o[i].id,
                                                      o[i].price, o[i].item,
                                                            o[i].catname,
                                                            i);
                                                  productProvider.addQuant(
                                                      o[i].catname, i);
                                                },
                                                color:
                                                    Theme.of(context).accentColor,
                                              ),
                                        Consumer<Products>(
                                          builder: (ctx, produc, ch) {return IconButton(
                                            icon: Icon(
                                              o[i].fav
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                            ),
                                            color: Theme.of(context).accentColor,
                                            onPressed: () {
                                              produc.toggleFavoriteStatus(
                                                  o[i].catname, i);
                                            ch=CircularProgressIndicator();},
                                          );
                                      },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          onTap: () => Navigator.push(context,CustomRoute(builder:(c)=>Description(catName:o[i].catname),settings: RouteSettings(arguments:i)), ),
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
          
          floatingActionButton:  FloatingActionButton(
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
                Navigator.push(context, CustomRoute(builder:(c)=>CartScreen()));
              },
            ),
          ),
      backgroundColor: Theme.of(context).primaryColor,
    ), ),
    );
  }
}
