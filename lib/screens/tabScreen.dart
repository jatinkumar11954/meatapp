import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meatapp/adjust/short.dart';
import 'package:meatapp/adjust/short.dart' as soty;

import 'package:meatapp/adjust/widget.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    final index = ModalRoute.of(context).settings.arguments;
    Short().init(context);

    var w = Short.w;
    final appbar = AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.green,
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
      length: 5,
      child: new Scaffold(
        key: _scaffoldKey,
        appBar: appbar,
        drawer: Draw(context),
        body: TabBarView(
            children: Short.catgry.entries.map((o) {
          // print(soty.o.value);
          print(Short.cat[o.key][1]);
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: Short.cat[o.key].length,
                itemBuilder: (ctx, i) {
                  print(o.value);
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Container(
                          height: 202,
                          width: w * 0.7,
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
                              child: Image.network(
                                "http://carigarifurniture.com/product_images/h/img_6539__14221_thumb.jpg",
                                fit: BoxFit.contain,
                              ),
                              footer: GridTileBar(
                                  backgroundColor: Colors.white,
                                  title: Text(Short.cat[o.key][i],
                                      style: TextStyle(color: Colors.black)))),
                        ),
                        onTap: () => Navigator.pushNamed(context, "Desc",
                            arguments: o.key),
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
              color:Colors.white,
              child: Tab(
                  text: "${Short.catgry[p.key]}", icon: Icon(Short.icon[p.key])),
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
          unselectedLabelColor: Colors.green,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: Colors.grey,
          indicatorWeight:1 ,
        ),
        backgroundColor: Colors.white
      ),
    );
  }
}
