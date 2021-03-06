import 'package:flutter/material.dart';
import 'package:meatapp/adjust/bottomNavigation.dart';
import 'package:meatapp/adjust/widget.dart';

import 'package:meatapp/adjust/short.dart';
import 'package:meatapp/adjust/custom_route.dart';
import 'package:meatapp/screens/profile/UserProfile.dart';
import 'package:meatapp/screens/tabScreen.dart';
import 'package:shimmer/shimmer.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  ScrollController _controller;
  bool isVisible = true;
    List<String> _dropList = ['Mallapur', "Gachibawli", "Sec-Bad"];
  String _selected = "Select Location";
  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
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
          Text("FirstMeat"),
          // Image.asset(
          //   'images/logo.png',
          //   fit: BoxFit.fill,
          //   height: Short.h * 4.5,
          // ),
          Icon(Icons.search)
        ],
      ),
    );
    print(Short.h.toString());
    print(Short.w.toString());
    var h = Short.h - appbar.preferredSize.height;
    var w = Short.w;

    void visible() {
      setState(() {
        print("visible false");
        isVisible = false;
      });
    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
        appBar: appbar,
        bottomNavigationBar: bottomBar(context, 0),
        drawer: Draw(context),
        body: CustomScrollView(
          scrollDirection: Axis.vertical,
            slivers: <Widget>[
        SliverList(
            delegate: SliverChildListDelegate([
         Padding(
           padding: EdgeInsets.only(left:18.0,top:4,bottom: 5),
           child: Row(children: <Widget>[
             Icon(Icons.location_on,color: Theme.of(context).primaryColor,size: 35,),
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
        fontSize: 18,fontWeight: FontWeight.w500
            ),
          ),
        ),
           ],),
         ),
          Carousel(context),
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
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (BuildContext ctx, int i) {
        return Padding(
          padding:
        EdgeInsets.only(left: w * 0.015, right: w * 0.015),
          child: Center(
            child: GestureDetector(
        onTap: () {
          print("navigating");
          Navigator.push(context, CustomRoute(builder: (context) => TabScreen(),settings:RouteSettings(arguments:i)));
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
                        Short.img[i],
                        fit: BoxFit.fill,
                        loadingBuilder: (BuildContext context,
                            Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null)
                            return child;
                          return Shimmer.fromColors(
                    baseColor: Colors.grey[400],
                    highlightColor: Colors.white,
                    child: Container(
                       height: h * 0.20,
              width: w * 0.45,
              color: Colors.grey,
                    )
                    
                  ) ;
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
                child: Text(Short.catgry[i],
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
            childCount: 4,
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 98 / 90,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
          ),
        ),
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
          ));
  }
}
