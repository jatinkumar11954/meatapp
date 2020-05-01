import 'package:flutter/material.dart';
import 'package:meatapp/adjust/widget.dart';

import 'package:meatapp/adjust/short.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    Short().init(context);
    final appbar = AppBar(
      backgroundColor: Colors.green,
      // Color.fromRGBO(191, 32, 37, 1.0),
      // actions: <Widget>[Row(
      //    children: <Widget>[IconButton(icon: Icon(Icons.arrow_back), onPressed:()=>Navigator.pop(context)),Draw(context)]
      // )],
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
        appBar: appbar,
        drawer: Draw(context),
        body: WillPopScope(
          onWillPop: () {
            Navigator.pop(context);
          },
          child: Container(
              child: CustomScrollView(//custom scroll
            slivers: <Widget>[
              SliverList(
                  delegate: SliverChildListDelegate([
                Visibility(
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                            icon: Icon(Icons.cancel, color: Colors.green),
                            onPressed: visible),
                      ),
                      Align(
                          heightFactor: 1.5,
                          widthFactor: 1.5,
                          alignment: Alignment.center,
                          child: SizedBox(
                            width:w*0.6,
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // RichText(text: null),
                              RichText(
                                text: TextSpan(
                                    text: 'Get',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: ' ₹ 50 OFF  ',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: h * 0.025,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: 'on your',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      )
                                    ]),
                              ),

                              Text(
                                "1st App Order above 249 ",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                              // Text("data"),
                              Text("UseCode App50",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: h * 0.025,
                                      fontWeight: FontWeight.bold))
                            ],
                          )
                              // Image.asset("img/location.png")
                              )),
                      Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.only(top: 30.0, right: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: RaisedButton(
                                color: Colors.green,
                                child: Text(
                                  "GetApp",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                onPressed: () {
                                  print("Get App button CLicked");
                                },
                              ),
                            ),
                          ))
                    ],
                  ),
                  visible: isVisible,
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
                            Navigator.pushNamed(context, "Desc", arguments: i);
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
                                            return Center(
                                              child: CircularProgressIndicator(
                                                  // value: loadingProgress.expectedTotalBytes != null
                                                  //     ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                                  //     : null,
                                                  ),
                                            );
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
          )),
        ));
  }
}
