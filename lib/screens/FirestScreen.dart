import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:meatapp/adjust/badge.dart';
import 'package:meatapp/adjust/bottomNavigation.dart';
import 'package:meatapp/adjust/shimmer.dart';
import 'package:meatapp/adjust/widget.dart';
import 'package:flutter/material.dart' as snack;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:meatapp/adjust/short.dart';
import 'package:meatapp/adjust/custom_route.dart';
import 'package:meatapp/Api/categoryApi.dart';
import 'package:meatapp/model/cart.dart';
import 'package:meatapp/screens/cart_screen.dart';
import 'package:meatapp/screens/profile/UserProfile.dart';
import 'package:meatapp/screens/tabScreen.dart';
import 'package:provider/provider.dart';
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
class Post {
  final String title;
  final String description;

  Post(this.title, this.description);
}

class _FirstScreenState extends State<FirstScreen> {
  ScrollController _controller;
  final GlobalKey<ScaffoldState> firstscreen = new GlobalKey<ScaffoldState>();

  bool isVisible = true;
  List<String> _dropList = ['Mallapur', "Gachibawli", "Sec-Bad"];
  String _selected = "Select Location";
  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }
Future<List<Post>> search(String search) async {
  await Future.delayed(Duration(seconds: 2));
  return List.generate(search.length, (int index) {
    return Post(
      "Title : $search $index",
      "Description :$search $index",
    );
  });
}
  @override
  Widget build(BuildContext context) {
    
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
          // Icon(Icons.search)
       
        ],
      ),
    );
    print(Short.h.toString());
    print(Short.w.toString());
    var h = Short.h - appbar.preferredSize.height;
    var w = Short.w;

    int visible() {
      setState(() {
        print("visible false");
        isVisible = false;
      });
      return 2;
    }

    print(isLogin.toString());
  final SearchBarController<Post> _searchBarController = SearchBarController();

    return Scaffold(
      key: firstscreen, resizeToAvoidBottomPadding: false,
      appBar: appbar,
      // bottomNavigationBar: isLogin ? bottomBar(context, 0) : SizedBox(),
      bottomNavigationBar: bottomBar(context, 0), 
      drawer: Draw(context),
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                  
                Padding(
                  padding: EdgeInsets.only(left: 18.0, top: 4, bottom: 5),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Theme.of(context).primaryColor,
                        size: 35,
                      ),
                      
                      DropdownButton<String>(
                        iconEnabledColor: Colors.grey,
                        underline: Container(),
                        items: _dropList
                            .map((drop) => DropdownMenuItem<String>(
                                  child: Text(
                                    drop,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  value: drop,
                                ))
                            .toList(),
                        onChanged: (String value) {
                          setState(() => _selected = value);
                        },
                        hint: Text(
                          _selected,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
           CachedNetworkImage(
                imageUrl: 'http://via.placeholder.com/350x200',
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fadeOutDuration: const Duration(seconds: 1),
                fadeInDuration: const Duration(seconds: 3),
              ),
            
                  Carousel(context, firstscreen),
                  SizedBox(height: h * 0.05),
                  Center(
                    child: SizedBox(
                      width: w * 0.90,
                      // height: h * 0.06,
                      child: RaisedButton(
                          color: Colors.grey[500],
                          child: Text("Shop by Category",
                              style:
                                  TextStyle(color: Colors.white, fontSize: h * 0.03)),
                          onPressed: () {
                            print("shop by category");
                          }),
                    ),
                  ),
                ])),
                FutureBuilder<List<Category>>(
                    future: getCategories(firstscreen),
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

                                      Navigator.push(
                                          context,
                                          CustomRoute(
                                              builder: (context) => TabScreen(),
                                              settings: RouteSettings(arguments: i)));
                                      // Navigator.pushNamed(context, "tab", arguments: i);
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          height: h * 0.20,
                                          width: w * 0.45,
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            elevation: 4.0,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: GridTile(
                                                child: Hero(
                                                  tag: i,
                                                  child: Image.network(
                                                    category.data[i].img,
                                                    fit: BoxFit.fill,
                                                    loadingBuilder:
                                                        (BuildContext context,
                                                            Widget child,
                                                            ImageChunkEvent
                                                                loadingProgress) {
                                                      if (loadingProgress == null)
                                                        return child;
                                                      return Shimmer.fromColors(
                                                          loop: 2,
                                                          baseColor: Colors.grey[400],
                                                          highlightColor:
                                                              Colors.white12,
                                                          child: Container(
                                                            height: h * 0.20,
                                                            width: w * 0.45,
                                                            color: Colors.grey,
                                                          ));
                                                      // Center(
                                                      //           child: CircularProgressIndicator(
                                                      //               // value: loadingProgress.expectedTotalBytes != null
                                                      //               //     ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                                      //               //     : null,
                                                      //               ),
                                                      //         );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Center(
                                            child: Text(category.data[i].categoryName,
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
                            childCount: category.data.length,
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
                          child: Image.network(
                            "http://carigarifurniture.com/product_images/h/img_6539__14221_thumb.jpg",
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                    // value: loadingProgress.expectedTotalBytes != null
                                    //     ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                    //     : null,
                                    ),
                              );
                            },
                          ))
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 4.0,
        onPressed: () {
          // Add your onPressed code here!
        },
        child: Consumer<Cart>(
          builder: (_, cart, ch) => GestureDetector(
            onTap: ()=> Navigator.push(
                  context, CustomRoute(builder: (c) => CartScreen())),
                      child: Badge(
              child: ch,
              value: cart.itemCount.toString(),
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
      ),
    );
  }
}
