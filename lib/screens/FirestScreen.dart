import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meatapp/adjust/badge.dart';
import 'package:meatapp/adjust/bottomNavigation.dart';
import 'package:meatapp/adjust/shimmer.dart';
import 'package:meatapp/adjust/widget.dart';
import 'package:flutter/material.dart' as snack;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:meatapp/adjust/short.dart';
import 'package:meatapp/adjust/custom_route.dart';
import 'package:meatapp/Api/categoryApi.dart';
import 'package:meatapp/details/userDetails.dart';
import 'package:meatapp/model/bottom.dart';
import 'package:meatapp/model/cart.dart';
import 'package:meatapp/model/search.dart';
import 'package:meatapp/screens/cart_screen.dart';
import 'package:meatapp/screens/tabScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../main.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

void callSnackBar(String msg, GlobalKey<ScaffoldState> _scaffoldkey) {
  print(msg + "snack msg");
  final Snack = new snack.SnackBar(
    content: new Text(msg),
    duration: new Duration(seconds: 3),
  );
  _scaffoldkey.currentState.showSnackBar(Snack);
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
    print("is user login ");
    print(isLogin);
    // getUser();
  }

  void getUser() async {
    SharedPreferences store = await SharedPreferences.getInstance();

    print("getting jwt from the device");
    String token = store.getString('jwt');
    if (token != null) {
      Map jwt =
          json.decode(ascii.decode(base64.decode(base64.normalize(token))));
      UserDetails user = UserDetails.fromJson(jwt["data"]);
    }
  }

  final GlobalKey<ScaffoldState> firstscreen = new GlobalKey<ScaffoldState>();

  bool searchProduct = false;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
//         var i = ModalRoute.of(context).settings.arguments;
// print(i.toString());
    Short().init(context);
    final appbar = AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      // Color.fromRGBO(191, 32, 37, 1.0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("FreshMeat"),
          // Image.asset(
          //   'images/logo.png',
          //   fit: BoxFit.fill,
          //   height: Short.h * 4.5,
          // ),
          //
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () =>
                  showSearch(context: context, delegate: ProductSearch()))
        ],
      ),
    );
    print(Short.h.toString());
    print(Short.w.toString());
    var h = Short.h - appbar.preferredSize.height;
    var w = Short.w;

    print(isLogin.toString());

    return Scaffold(
      key: firstscreen, resizeToAvoidBottomPadding: false,
      appBar: appbar,
      bottomNavigationBar: isLogin ? bottomBar(context, 0) : SizedBox(),
      // bottomNavigationBar: bottomBar(context, 0),
      drawer: Draw(context),
      body: WillPopScope(
        onWillPop: () {
          showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  // insetPadding:  EdgeInsets.all(20),
                  titlePadding: EdgeInsets.fromLTRB(40, 30, 40, 10),
                  contentPadding: EdgeInsets.fromLTRB(40, 5, 40, 0),
                  backgroundColor: Color.fromRGBO(46, 54, 67, 1),
                  title: Text('Exit from FreshMeat?',
                      style: TextStyle(color: Colors.white)),
                  content: Text('This will close the App!',
                      style: TextStyle(color: Colors.white)),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('No'),
                    ),
                    FlatButton(
                      onPressed: () =>
                          SystemChannels.platform.invokeMethod<void>(
                        'SystemNavigator.pop',
                      ),
                      /*Navigator.of(context).pop(true)*/
                      child: Text('Exit'),
                    ),
                  ],
                ),
              ) ??
              false;

          // Navigator.pushReplacementNamed(context, "Login");
        },
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            SliverList(
                delegate: SliverChildListDelegate([
              // CachedNetworkImage(
              //   imageUrl: 'http://via.placeholder.com/350x200',
              //   placeholder: (context, url) => const CircularProgressIndicator(),
              //   errorWidget: (context, url, error) => const Icon(Icons.error),
              //   fadeOutDuration: const Duration(seconds: 1),
              //   fadeInDuration: const Duration(seconds: 3),
              // ),
              SizedBox(height: 20),

              Material(
                child: GestureDetector(
                  child: Center(
                    child: Container(
                        width: w * 0.86,
                        height: 50,
                        // margin: EdgeInsets.fromLTRB(15, 2, 15, 8),
                        decoration: BoxDecoration(border: Border.all(width: 1)),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(width: 10),
                            Icon(Icons.search),
                            SizedBox(width: 10),
                            Hero(
                              tag: "storesearch",
                              child: Text(
                                'StoreSearch',
                                style: TextStyle(
                                    color: Colors.black,
                                    // Theme.of(context).primaryColor,
                                    fontSize: 19),
                              ),
                            ),
                            Spacer()
                          ],
                        )),
                  ),
                  onTap: () =>
                      showSearch(context: context, delegate: StoreSearch()),
                ),
              ),
              SizedBox(height: 20),

              Carousel(context, firstscreen), //testing
              SizedBox(height: h * 0.05),
              Center(
                child: SizedBox(
                  width: w * 0.90,
                  // height: h * 0.06,
                  child: RaisedButton(
                      color: Colors.grey[500],
                      child: Text("Shop by Category",
                          style: TextStyle(
                              color: Colors.white, fontSize: h * 0.03)),
                      onPressed: () {
                        print("shop by category");
                      }),
                ),
              ),
            ])),
            FutureBuilder<List<Category>>(
                future: getCategories(firstscreen, cart),
                builder: (context, category) {
                  if (category.hasData) {
                    print("category has data");
                    return SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext ctx, int i) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: w * 0.015, right: w * 0.015),
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  print("navigating");
                                  Provider.of<Bottom>(context, listen: false)
                                      .updateTab(i);
                                  Navigator.pushReplacement(
                                      context,
                                      CustomRoute(
                                          builder: (context) => TabScreen(),
                                          settings:
                                              RouteSettings(arguments: i)));
                                  // Navigator.pushNamed(context, "tab", arguments: i);
                                },
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: h * 0.20,
                                      width: w * 0.45,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        elevation: 4.0,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: GridTile(
                                            // child:
                                            //  Hero(
                                            //   tag: i,
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "http://via.placeholder.com/350x200", //testing
                                              //  category.data[i].img,
                                              fit: BoxFit.fill,
                                              placeholder: (context, url) =>
                                                  Shimmer.fromColors(
                                                      loop: 2,
                                                      baseColor:
                                                          Colors.grey[400],
                                                      highlightColor:
                                                          Colors.white12,
                                                      child: Container(
                                                        height: h * 0.20,
                                                        width: w * 0.45,
                                                        color: Colors.grey,
                                                      )),
                                              errorWidget: (_, str, dynamic) =>
                                                  Center(
                                                child: Icon(Icons.error),
                                              ),

                                              //               // value: loadingProgress.expectedTotalBytes != null
                                              //               //     ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                              //               //     : null,
                                              //
                                            ),
                                            // ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Center(
                                        child: Text(
                                            category.data[i].categoryName
                                                .replaceFirst(
                                                    category.data[i]
                                                        .categoryName[0],
                                                    category
                                                        .data[i].categoryName[0]
                                                        .toUpperCase()),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: h * 0.025,
                                                fontWeight: FontWeight.bold)))
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: category.data.length ?? 0,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 98 / 90,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                      ),
                    );
                  } else if (category.hasError) {
                    return Text("${category.error}");
                  }
                  return SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext ctx, int i) {
                        return Shimmer.fromColors(
                            baseColor: Colors.grey[300],
                            highlightColor: Colors.white,
                            child: ShrimGrid(context, h, w));
                      },
                      childCount: 4,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 98 / 90,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                    ),
                  );
                }),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  //  SizedBox(height:h*0.0001),
                  SizedBox(
                    width: w,
                    child: CachedNetworkImage(
                        imageUrl: "http://via.placeholder.com/350x200",

                        // "http://carigarifurniture.com/product_images/h/img_6539__14221_thumb.jpg",//testing
                        placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(
                                  // value: loadingProgress.expectedTotalBytes != null
                                  //     ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                  //     : null,
                                  ),
                            )),
                    // Image.network(
                    //   "http://carigarifurniture.com/product_images/h/img_6539__14221_thumb.jpg",
                    //   loadingBuilder: (BuildContext context, Widget child,
                    //       ImageChunkEvent loadingProgress) {
                    //     if (loadingProgress == null) return child;
                    //     return Center(
                    //       child: CircularProgressIndicator(
                    //           // value: loadingProgress.expectedTotalBytes != null
                    //           //     ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                    //           //     : null,
                    //           ),
                    //     );
                    //   },
                    // )
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: isLogin
          ? FloatingActionButton(
              elevation: 4.0,
              onPressed: () {
                  Provider.of<Bottom>(context, listen: false)
                                      .updateINdex(1);
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
                     Provider.of<Bottom>(context, listen: false)
                                      .updateINdex(1);
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
  }
}
