import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meatapp/adjust/short.dart';
import 'package:meatapp/adjust/short.dart' as soty;

import 'package:meatapp/adjust/widget.dart';

class Tab extends StatefulWidget {
  @override
  _TabState createState() => _TabState();
}

class _TabState extends State<Tab> {
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
              child: Text(Short.catgry[index]),
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
        appBar: appbar,
        drawer: Draw(context),
        body: TabBarView(
          children: Short.catgry.entries. map((o) {

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
                      child: Container(
                        height: 202,
                        width: w*0.7,
                        child: GridTile(
                            child: Image.network(
                                "http://carigarifurniture.com/product_images/h/img_6539__14221_thumb.jpg",
                                fit: BoxFit.contain,),
                            footer: GridTileBar(
                                backgroundColor: Colors.amber,
                                title: Text(Short.cat[o.key][i]))),
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
          tabs: 
           [
            
            new Icon(Icons.home),
            new Icon(Icons.rss_feed),
            new Icon(Icons.perm_identity),
            new Icon(Icons.settings),
          ],
          labelColor: Colors.yellow,
          unselectedLabelColor: Colors.blue,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.all(5.0),
          indicatorColor: Colors.red,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
