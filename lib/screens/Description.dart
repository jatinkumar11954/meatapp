import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:meatapp/adjust/short.dart';
import 'package:meatapp/adjust/widget.dart';

class Description extends StatefulWidget {
  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  @override
  Widget build(BuildContext context) {
    final i = ModalRoute.of(context).settings.arguments;
    Short().init(context);
    final appbar = AppBar(
      backgroundColor: Colors.green,
      // actions: <Widget>[
      //   IconButton(
      //       icon: Icon(Icons.arrow_back_ios),
      //       onPressed: () => Navigator.pop(context))
      // ],
      // Color.fromRGBO(191, 32, 37, 1.0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(Short.catgry[i]),
          // Image.asset(
          //   'images/logo.png',
          //   fit: BoxFit.fill,
          //   height: Short.h * 4.5,
          // ),
        ],
      ),
    );
    print(Short.h.toString());
    print(Short.w.toString());
    var h = Short.h - appbar.preferredSize.height;
    var w = Short.w;

    return Scaffold(
        appBar: appbar,
        drawer: Draw(context),
        body: WillPopScope(
            onWillPop: () {
              // Navigator.pushNamed(context,''),
              Navigator.pop(context);
            },
            child: ListView(
              children: <Widget>[
                Center(
                  child: Hero(
                    tag: i,
                    child: Image.network(
                      Short.img[i],
                      fit: BoxFit.fill,
                      width: w * 0.98,
                      height: h * 0.4,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5, top: 25, left: 17),
                  child: ListTile(
                      title: Text(Short.catgry[i],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: h * 0.03,
                              fontWeight: FontWeight.w500)),
                      subtitle: Text(
                        "29-30 Pieces",
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
                      Text("  500",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: h * 0.035,
                          )),
                    ],
                  ),
                ),
                Divider(thickness: 4),
                SizedBox(height:30),
                Center(
                  child: SizedBox(
                    width: w * 0.95,
                    child: RaisedButton(
                        color: Colors.green,
                        onPressed: () => print("login button clicked"),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.arrow_forward, color: Colors.white),
                            Text("LOGIN/SIGN UP TO CHECKOUT",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: h * 0.028,
                                )),
                          ],
                        )),
                  ),
                )
              ],
            )));
  }
}
